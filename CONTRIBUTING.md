# المساهمة | Contributing

[العربية](#العربية) | [English](#english)

## العربية

شكراً لاهتمامك بـ king-SKILLS. كل مهارة هنا مجلد مستقل داخل فئة، وتُكتب بالعربية (الأصل الذي يستعمله Claude) مع ترجمة إنجليزية.

### إضافة مهارة جديدة

1. اختر الفئة: `writing` أو `productivity` أو `design` أو `engineering` أو `workflows`.
2. انسخ القالب: `cp -r _template <الفئة>/skills/<اسم-المهارة>` (اسم بحروف إنجليزية صغيرة وشرطات).
3. عدّل `SKILL.md` بالعربية: الترويسة (`name` يطابق اسم المجلد، و`description` جملة واحدة)، ثم الأقسام الستة: متى تُستخدم، خطوات العمل، صيغة المخرجات، قواعد وحدود، حالات حدّية، مثال كامل. الطول بين 60 و120 سطراً.
4. عدّل `README.md` (ما تفعله المهارة، متى تستخدمها، مثالان على الأقل، جدول «ماذا تتوقع»).
5. اكتب النسخة الإنجليزية: `SKILL.en.md` و`README.en.md` بالعناوين الإنجليزية نفسها الموجودة في القالب. أبقِ `name` كما هو، ولا تترجم أسماء المهارات والأكواد.
6. أضف المهارة إلى جدول فئتها في `README.md` و`README.en.md`، وعدّل عدد المهارات في الشارة.
7. شغّل `scripts/validate.sh` حتى ينجح بلا أخطاء (ويمكن إضافة `--with-claude` إن كان Claude Code مثبتاً). وإن عدّلت `scripts/` أو `tests/` فشغّل `bash tests/run.sh` أيضاً. يشغّل GitHub Actions الفحصين نفسيهما على كل طلب دمج.
8. افتح طلب دمج بوصف مختصر للمهارة.

### فئة جديدة

أنشئ `<فئة>/.claude-plugin/plugin.json` (الاسم `king-<فئة>`)، وأضف مدخلاً في `.claude-plugin/marketplace.json`، وأضف اسم الفئة إلى مصفوفة `CATEGORIES` في `scripts/install.sh` و`scripts/validate.sh`، ثم إلى جدول الفئات في README. لا تبدأ اسم الحزمة بـ `claude-` أو `anthropic-` (محجوزة).

تصنيف `workflows` استثناء مقصود: مهاراته إنجليزية أولاً وتحتاج `SKILL.md` و`README.md` فقط، مع مجلدات `references/` و`scripts/` و`assets/` التي تحتاجها. لا تُطبَّق عليه قاعدة النسختين العربية والإنجليزية ولا حدود الأقسام الستة.

### قواعد المحتوى

- لا تختلق مصادر أو أرقاماً أو اقتباسات؛ والمعيار يُذكر باسمه الدقيق.
- لا تكتب برمجيات خبيثة أو شيفرات استغلال؛ الأمثلة الأمنية للكشف والإصلاح فقط.
- لا بيانات حقيقية أو أسرار في الأمثلة؛ استخدم عناصر نائبة واضحة.
- الأمثلة التي فيها أرقام أو أكواد يجب أن تكون قد شُغّلت وصحّت نتائجها.
- لكل مهارة سطر «لا تُستخدم عندما» يحيل إلى المهارة الأنسب بالاسم إن وُجد تداخل (في `SKILL.md` أو `README.md`).

### الترخيص

بمساهمتك توافق على ترخيص عملك بموجب [MIT](LICENSE).

## English

Thanks for your interest in king-SKILLS. Every skill is a standalone folder inside a category, written in Arabic (the version Claude uses) with an English translation.

### Adding a skill

1. Pick the category: `writing`, `productivity`, `design`, `engineering` or `workflows`.
2. Copy the template: `cp -r _template <category>/skills/<skill-name>` (lowercase English letters and hyphens).
3. Edit `SKILL.md` in Arabic: the front matter (`name` equals the folder name, `description` is one sentence), then the six sections: when to use, workflow, output format, rules and limits, edge cases, full example. Length: 60 to 120 lines.
4. Edit `README.md` (what the skill does, when to use it, at least two example requests, a "what to expect" table).
5. Write the English version: `SKILL.en.md` and `README.en.md` using the English headings from the template. Keep `name` unchanged, and do not translate skill names or code.
6. Add the skill to its category table in `README.md` and `README.en.md`, and update the skill count in the badge.
7. Run `scripts/validate.sh` until it passes with no errors (add `--with-claude` if Claude Code is installed). If you changed `scripts/` or `tests/`, also run `bash tests/run.sh`. GitHub Actions runs both on every pull request.
8. Open a pull request with a short description of the skill.

### A new category

Create `<category>/.claude-plugin/plugin.json` (name `king-<category>`), add an entry to `.claude-plugin/marketplace.json`, add the category to the `CATEGORIES` array in `scripts/install.sh` and `scripts/validate.sh`, then to the category table in the READMEs. Do not start a plugin name with `claude-` or `anthropic-` (reserved).

`workflows` is a deliberate exception: its skills are English-first and need only `SKILL.md` and `README.md`, plus whatever `references/`, `scripts/` and `assets/` folders they use. The Arabic/English pair rule and the six-section limits do not apply there.

### Content rules

- Do not invent sources, numbers or quotations; cite standards by their exact name.
- Do not write malware or exploit code; security examples are for detection and fixing only.
- No real data or secrets in examples; use clear placeholders.
- Examples containing numbers or code must have been run and their results verified.
- Every skill has a "Do not use when" line in `SKILL.md` or `README.md` pointing to the better-suited skill by name where there is overlap.

### License

By contributing you agree to license your work under the [MIT](LICENSE) license.
