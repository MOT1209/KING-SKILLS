---
name: db-schema-design
description: تُستخدم عند تصميم جداول وعلاقات وفهارس قاعدة بيانات علاقية ومراجعة التطبيع وكتابة خطة ترحيل آمنة.
---

# تصميم مخطط قاعدة البيانات

## متى تُستخدم
- تصميم جداول لميزة جديدة.
- مراجعة مخطط قائم من حيث التطبيع والفهارس.
- كتابة ترحيل (migration) يغيّر جداول تحتوي بيانات حقيقية.

لا تُستخدم عندما: المشكلة استعلام بطيء دون حاجة لتغيير المخطط (`performance-audit`).

## خطوات العمل
1. حدّد نظام القاعدة (PostgreSQL، MySQL، SQLite…) والـ ORM وأداة الترحيل المستخدمة؛ اقرأ المخطط الحالي قبل التصميم.
2. استخرج الكيانات والعلاقات (واحد لواحد، واحد لمتعدد، متعدد لمتعدد عبر جدول وسيط) من المتطلبات.
3. حدّد المفاتيح الأساسية، والمفاتيح الأجنبية مع سلوك الحذف (`RESTRICT`، `CASCADE`، `SET NULL`) بقرار معلَّل.
4. اختر الأنواع الصحيحة: المال بنوع عشري دقيق لا عائم، والتواريخ بمنطقة زمنية صريحة، والحالات بقيود `CHECK` أو نوع تعدادي.
5. اضبط القيود: `NOT NULL`، `UNIQUE`، `CHECK`، لتكون القاعدة نفسها خط الدفاع الأخير.
6. راجع التطبيع: لا تكرار لحقائق، وإن اخترت إلغاء التطبيع لسبب أداء فوثّقه.
7. صمّم الفهارس من الاستعلامات الفعلية (الشروط، الربط، الفرز) لا من التخمين، وانتبه لترتيب الأعمدة في الفهرس المركب وتكلفة الكتابة.
8. اكتب خطة ترحيل: خطوات صغيرة قابلة للعكس، ونمط التوسعة ثم الانكماش (expand/contract) للتغييرات الكاسرة، وملء البيانات على دفعات، ونسخة احتياطية قبل التنفيذ، وخطة تراجع.

## صيغة المخرجات
مخطط ER نصي أو Mermaid، ثم `CREATE TABLE`/ترحيل، ثم جدول الفهارس مع الاستعلام الذي يخدمه كل فهرس، ثم خطة الترحيل والتراجع، ثم افتراضات.

## قواعد وحدود
- لا تنفّذ ترحيلاً على قاعدة حقيقية دون طلب صريح ونسخة احتياطية.
- لا تضف فهرساً دون استعلام يبرّره؛ اطلب خطة التنفيذ (`EXPLAIN`) عند الإمكان.
- لا تضع بيانات حقيقية أو أسراراً في أمثلة الترحيل.
- لا تعتمد صيغة SQL خاصة بنظام دون ذكر النظام.

## حالات حدّية
- جدول ضخم: تجنّب أقفالاً طويلة؛ استخدم إنشاء الفهرس بطريقة غير حاجبة إن دعمها النظام، وتحقق من ذلك في وثائقه.
- إعادة تسمية عمود حيّ: أضف الجديد، انسخ البيانات، حدّث الكود، ثم احذف القديم.
- حذف ناعم (soft delete): نبّه إلى أثره على قيود `UNIQUE` والاستعلامات.

## مثال كامل
### المدخل
«PostgreSQL. أحتاج جداول للطلبات وبنودها، لكل طلب عميل. نبحث غالباً بالعميل والحالة.»

### المخرج
```sql
CREATE TABLE orders (
  id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_id BIGINT NOT NULL REFERENCES customers(id) ON DELETE RESTRICT,
  status      TEXT NOT NULL CHECK (status IN ('pending','paid','cancelled')),
  total       NUMERIC(12,2) NOT NULL CHECK (total >= 0),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE order_items (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  order_id BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  sku TEXT NOT NULL, qty INT NOT NULL CHECK (qty > 0),
  unit_price NUMERIC(12,2) NOT NULL
);
CREATE INDEX idx_orders_customer_status ON orders (customer_id, status);
CREATE INDEX idx_order_items_order_id ON order_items (order_id);
```
| الفهرس | يخدم |
|---|---|
| `(customer_id, status)` | `WHERE customer_id = ? AND status = ?` |
| `order_items (order_id)` | جلب بنود طلب، و`ON DELETE CASCADE` (لا ينشئ PostgreSQL فهرساً للمفتاح الأجنبي تلقائياً) |

الترحيل: ترحيل واحد قابل للعكس (`DROP` بترتيب عكسي). افتراض: جدول `customers` موجود.
