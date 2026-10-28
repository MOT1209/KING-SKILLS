---
name: typescript-strict
description: تُستخدم عند كتابة أو مراجعة TypeScript بأنواع صارمة مع تجنب any واستخدام الأنواع المشتقة والتضييق الآمن.
---

# TypeScript صارم

## متى تُستخدم
- كتابة كود TypeScript جديد أو تحويل JavaScript.
- مراجعة كود مليء بـ `any` أو التأكيدات `as`.
- تفعيل الوضع الصارم في مشروع قائم تدريجياً.

لا تُستخدم عندما: المشروع بلغة أخرى، أو المطلوب مراجعة عامة للكود (`code-review`).

## خطوات العمل
1. اقرأ `tsconfig.json`: هل `strict` مفعّل؟ وهل خيارات مثل `noUncheckedIndexedAccess` و`exactOptionalPropertyTypes` مفعّلة؟ واقتصر على ما يدعمه إصدار TypeScript في المشروع.
2. افحص المواضع الضعيفة: `any` الصريح، `as` غير الضروري، `!` (non-null assertion)، `@ts-ignore`، ودوال بلا نوع إرجاع في الواجهات العامة.
3. اشتقّ الأنواع بدل تكرارها: `typeof`، `keyof`، `ReturnType`، `Parameters`، `Pick`، `Omit`، `Partial`، `Required`، `Record`، والأنواع المشروطة والمطابِقة (mapped types) عند الحاجة.
4. استبدل `any` بـ `unknown` عند البيانات الخارجية، ثم ضيّقها بحراس نوع (type guards) أو بالتحقق وقت التشغيل (مثل مكتبة تحقق متوافقة مع المشروع).
5. استعمل الاتحادات المميَّزة (discriminated unions) بدل الحقول الاختيارية المتناثرة، وافحص الاكتمال بـ `never` في `switch`.
6. اجعل البيانات غير قابلة للتعديل حيث يمكن: `readonly`، `as const`، `satisfies` للتحقق دون توسيع النوع.
7. نظّف الأنواع في حدود النظام (استجابات API، JSON، متغيرات البيئة): لا تثق بأنواعها دون تحقق.
8. شغّل `tsc --noEmit` والـ lint وأصلح الأخطاء، وإن كثرت فقسّم الإصلاح على ملفات.

## صيغة المخرجات
الكود المعدَّل بأنواع صارمة، ثم قائمة بما استُبدل ولماذا، ثم نتيجة `tsc`، ثم ما يحتاج قرار المستخدم.

## قواعد وحدود
- لا تستعمل `any` أو `@ts-ignore` لإسكات خطأ؛ إن لزم فاستخدم `@ts-expect-error` مع تعليق سبب ومرجع مهمة.
- لا تضيّق النوع بـ `as` دون تحقق فعلي.
- لا ترفع مستوى الصرامة في كل المشروع دفعة واحدة دون موافقة.
- لا تغيّر السلوك وقت التشغيل أثناء تحسين الأنواع إلا بإضافة تحقق مقصود.

## قائمة تحقق
- لا `any` صريح جديد، ولا `@ts-ignore`.
- كل `as` له مبرر أو استُبدل بحارس نوع.
- البيانات الخارجية تُقرأ كـ `unknown` ثم تُتحقق.
- `tsc --noEmit` ينجح بلا أخطاء جديدة.
- الميزات الحديثة (مثل `satisfies`) مستعملة فقط إن كان إصدار TypeScript في المشروع يدعمها.

## حالات حدّية
- مكتبة ثالثة بلا أنواع: اكتب ملف تعريف (`.d.ts`) محدوداً ولا تستعمل `any` شاملاً.
- فهرسة كائن بمفتاح ديناميكي: استخدم `Record` أو `Map` مع التعامل مع احتمال `undefined`.
- أنواع دائرية معقدة: بسّطها بدل بناء أنواع مشروطة عميقة يصعب قراءتها.
- كود قديم ضخم: فعّل الصرامة على الملفات الجديدة أولاً.

## مثال كامل
### المدخل
```ts
function getUser(data: any) { return { id: data.id as number, name: data.name }; }
```
### المخرج
```ts
type User = { readonly id: number; readonly name: string };

function isUser(v: unknown): v is User {
  return typeof v === "object" && v !== null
    && typeof (v as Record<string, unknown>).id === "number"
    && typeof (v as Record<string, unknown>).name === "string";
}

function getUser(data: unknown): User {
  if (!isUser(data)) throw new TypeError("Invalid user payload");
  return { id: data.id, name: data.name };
}
```
التغييرات: `any` ← `unknown` مع حارس نوع، حذف `as number` غير الآمن، نوع إرجاع صريح، خصائص `readonly`. سؤال: هل تفضّل مكتبة تحقق موجودة في المشروع بدل الحارس اليدوي؟
