# 🚀 دليل استخدام Git & GitHub لفريق العمل (Git Workflow Guide)

دليل مبسط وعملي باللغة العربية يشرح كيفية التعامل مع Git داخل مشروع **Dokkan** خطوة بخطوة، مع الالتزام بأفضل الممارسات لتجنب المشاكل والتعارضات (Conflicts).

---

## 📌 1. القواعد الذهبية للفريق (Golden Rules)

1. **ممنوع الشغل أو الـ Commit المباشر على فرع `main`!**
2. كل ميزة جديدة أو شاشة بتشتغل عليها لازم تاخدلها **فرع خاص بيها (Branch)**.
3. قبل ما تبدأ شغل كل يوم أو قبل ما تاخد Branch جديد، اعمل `pull` عشان تاخد آخر تحديثات من زمايلك.
4. رسائل الـ Commit لازم تكون واضحة ومحددة.

---

## 🏷️ 2. تسمية الفروع (Branch Naming Conventions)

عشان المشروع يكون منظم والكل يفهم الفرع ده بيعمل إيه بمجرد قراءة اسمه، بنستخدم الصيغة القياسية:
```text
<type>/<feature-name>
```

### أشهر الأنواع (Types):
| النوع | متى تستخدمه؟ | مثال عملي |
|---|---|---|
| **`feat/`** | ميزة أو شاشة جديدة كلياً (Feature) | `feat/home-screen`<br>`feat/cart-page`<br>`feat/add-product-admin` |
| **`fix/`** | تصليح مشكلة أو Bug في الشاشة | `fix/login-validation-error`<br>`fix/cart-price-calculation` |
| **`style/`** | تعديل ألوان أو خطوط أو هوامش (UI/CSS/Themes) | `style/dark-mode-colors`<br>`style/splash-padding` |
| **`refactor/`** | إعادة ترتيب الكود أو تحسين الأداء بدون تغيير الوظيفة | `refactor/auth-bloc-state`<br>`refactor/product-card-widget` |
| **`docs/`** | كتابة أو تعديل التوثيق وملفات الشرح | `docs/git-workflow`<br>`docs/api-endpoints` |
| **`chore/`** | تحديث مكتبات في `pubspec.yaml` أو إعدادات عامة | `chore/update-dependencies`<br>`chore/assets-cleanup` |

---

## 🛠️ 3. الخطوات اليومية لكل مبرمج (Daily Workflow)

### الخطوة 1: التأكد إنك على آخر تحديث من الـ `main`
قبل ما تفتح فرع جديد، تأكد إنك واقف على الـ `main` ومعاك أحدث كود:
```bash
# الانتقال لفرع main
git checkout main

# سحب أحدث كود نزله باقي الفريق من GitHub
git pull origin main
```

---

### الخطوة 2: إنشاء فرع جديد للشاشة بتاعتك (Branch)
دلوقتي هتعمل فرع جديد وتبدأ شغل جواه:
```bash
# إنشاء فرع جديد والانتقال إليه مباشرة
git checkout -b feat/cart-screen
```
> 💡 **ملاحظة:** أمر `git checkout -b` بيعمل الفرع وينقلك عليه في خطوة واحدة.

---

### الخطوة 3: معرفة حالة الملفات المعدلة (Status)
وأنت شغال في الكود، تقدر تشوف الملفات اللي اتعدلت:
```bash
git status
```

---

### الخطوة 4: تجهيز وحفظ التعديلات (Add & Commit)
لما تخلص جزء من الشاشة أو وظيفة معينة:
```bash
# 1. تجهيز كل الملفات المعدلة
git add .

# 2. حفظ التعديل مع رسالة واضحة تشرح إيه اللي اتعمل
git commit -m "feat: implement active shopping bag item cards and tally"
```

#### ✍️ طريقة كتابة الـ Commit Message الصح:
بنستخدم نفس البرفكس بتاع الـ Branch:
- `feat: add splash screen timer and animation`
- `fix: resolve otp countdown resend delay`
- `style: apply atelier dark theme palette to profile`

---

### الخطوة 5: رفع الفرع بتاعك على GitHub (Push)
لأول مرة ترفع الفرع ده على سيرفر GitHub:
```bash
git push -u origin feat/cart-screen
```
> في المرات اللي بعد كده على نفس الفرع، تقدر تكتب `git push` بس.

---

### الخطوة 6: عمل Pull Request (PR)
بعد ما ترفع الفرع على GitHub:
1. ادخل على صفحة الريبو في موقع **GitHub**.
2. هتلاقي زرار أخضر ظهرلك اسمه **"Compare & pull request"**.
3. اكتب عنوان ووصف بسيط للتعديلات.
4. اطلب مراجعة من التيم ليدر (Ahmed Jihad) عشان يعتمد الـ Merge للـ `main`.

---

## 🔄 4. كيف تستقبل تعديلات زمايلك في فرعك؟ (Keep Updated)

لو زميلك خلص شاشته وتم دمجها في `main` وأنت عايز تاخد شغله عندك في الفرع:
```bash
# وأنت واقف جوه فرعك الحالي:
git pull origin main
```
لو مفيش تعارض هيتم التحديث فوراً.

---

## 📋 5. ملخص سريع لأهم الأوامر (Cheat Sheet)

```bash
# عرض كل الفروع ومعرفة الفرع الحالي
git branch

# عمل فرع جديد والتحويل عليه
git checkout -b <branch-name>

# الانتقال بين الفروع
git checkout <branch-name>

# معرفة الملفات المتغيرة
git status

# إضافة كل التعديلات
git add .

# حفظ التعديلات برمز ورسالة واضحة
git commit -m "feat: description"

# رفع التعديلات على GitHub
git push origin <branch-name>

# سحب أحدث نسخة من السيرفر
git pull origin main
```

---

## 👥 أمثلة لفروع أعضاء الفريق في Dokkan:

- **Ahmed Jihad:** `feat/home-feed-carousel`, `feat/admin-product-management`
- **Sayed:** `feat/shopping-bag-cart`, `feat/empty-cart-state`
- **El-Forma:** `feat/categories-catalog`, `feat/contact-us-form`
- **Mariam:** `feat/splash-screen`, `feat/onboarding-flow`
- **Mohamed Adel:** `feat/login-screen`, `feat/auth-validation-errors`
- **Shahd:** `feat/forgot-password-request`, `feat/otp-verification`
- **Habiba:** `feat/profile-settings-hub`, `feat/change-password-screen`
