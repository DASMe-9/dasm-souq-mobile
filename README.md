# سوق داسم — تطبيق الجوال

تطبيق Flutter لـ **سوق داسم** (souq.dasm.com.sa) — الإعلانات المبوّبة داخل منظومة DASM.

## البنية

```
dasm_souq_mobile/
├── lib/
│   ├── main.dart                     # init DI + runApp
│   ├── app.dart                      # MaterialApp + RTL + theme
│   └── features/
│       ├── splash/                   # شاشة البداية + auth check
│       ├── auth/                     # تسجيل الدخول (Sanctum)
│       └── home/                     # الصفحة الرئيسية (placeholder)
└── packages/dasm_core/               # مكتبة مشتركة بين كل تطبيقات داسم
    └── lib/src/
        ├── api/                      # Dio + Bearer interceptor
        ├── auth/                     # AuthService + TokenStorage (secure)
        ├── config/                   # ApiConfig (base URL)
        ├── di/                       # get_it locator
        └── theme/                    # ألوان + Tajawal + Material 3
```

## التشغيل المحلي

```bash
flutter pub get
flutter run
```

## التوكن وAPI

- **Base URL:** `https://api.dasm.com.sa/api`
- **Auth:** Sanctum (access token) — يُخزَّن في `flutter_secure_storage`
- **Login:** `POST /auth/login` → `access_token`
- **Logout:** `POST /logout` (auth:sanctum)

## الألوان الرسمية

| | |
|---|---|
| primary | `#1F4B7A` (DASM Blue) |
| accent  | `#009345` (DASM Green) |

## Bundle ID

- Android: `com.dasm.souq`
- iOS: `com.dasm.souq`

## التطبيقات القادمة على نفس `dasm_core`

1. **dasm_souq_mobile** (هذا) — سوق الإعلانات
2. `dasm_shipping_mobile` — الشحن
3. `dasm_inspection_mobile` — الفحص
