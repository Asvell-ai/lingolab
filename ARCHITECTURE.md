# LingoLab - Professional Flutter Architecture

Bu loyihada **Production-Level** Flutter arxitekturasi qo'llanilgan.

## 🏗️ Arxitektura

```
lib/
├── core/
│   ├── constants/           # App konstantalari
│   │   └── app_constants.dart
│   ├── network/             # Network va API
│   │   └── app_dio.dart     # Dio setup, interceptors
│   ├── utils/               # Utilities
│   │   ├── validators.dart
│   │   └── extensions.dart
│   ├── services/            # Business services
│   └── widgets/             # Reusable widgets
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/              # Data models
│   │   │   ├── datasources/         # Remote datasources
│   │   │   └── repositories/        # Repository implementations
│   │   │
│   │   └── presentation/
│   │       ├── cubit/               # State management
│   │       ├── pages/               # Pages
│   │       └── widgets/             # Feature-specific widgets
│   │
│   └── home/
│       ├── data/
│       │   ├── models/
│       │   ├── datasources/
│       │   └── repositories/
│       │
│       └── presentation/
│           ├── cubit/
│           ├── pages/
│           └── widgets/
│
├── injection_container.dart  # Dependency Injection setup
└── main.dart               # App entry point
```

## 🔄 Data Flow

```
UI (Page)
   ↓
Cubit (State Management)
   ↓
Repository (Business Logic)
   ↓
Datasource (API Calls)
   ↓
AppDio (HTTP Client)
```

## 📦 Dependencies

```yaml
- flutter_bloc: State Management
- get_it: Dependency Injection
- dio: HTTP Client
- equatable: Value Equality
```

## ✨ Arxitektura Qoidalari

### 1️⃣ **Entity/UseCase/Either YOQ**
- Ortiqcha abstraktsiya yok
- To'g'ridan-to'g'ri Exception throw qilish
- Models birbaqa ishlash

### 2️⃣ **Simple Data Flow**
- UI → Cubit → Repository → Datasource → API
- Ortiqcha layer yo'q

### 3️⃣ **State Management (Cubit)**
- Faqat `flutter_bloc` Cubit ishlash
- State o'zgarishlari Cubit-da
- UI ichida business logic yo'q

### 4️⃣ **Networking**
- Dio + Interceptors
- Automatic token injection
- Refresh token qo'llab-quvvatlash
- Generic ApiClient yo'q

### 5️⃣ **Dependency Injection**
- get_it singleton pattern
- Barcha repository, datasource, cubit register
- setup_service_locator() main-da chaqirish

### 6️⃣ **Kod Sifati**
- `Equatable` immutable state uchun
- `copyWith` method o'zgartirishlar uchun
- Validators qo'llanish
- Extensions utility methodlar uchun

### 7️⃣ **UI Patterns**
- `_buildHeader()` methodlar yok!
- Widgetlar to'g'ridan-to'g'ri yozish
- BlocBuilder, BlocListener ishlatish
- StatelessWidget > StatefulWidget

## 📋 Feature Yaratish Checklist

Har bir feature uchun quyidagi fayllarni yaratish kerak:

```
feature/
├── data/
│   ├── models/          # Models (fromJson, toJson, copyWith)
│   ├── datasources/     # Abstract + Implementation
│   └── repositories/    # Abstract + Implementation
└── presentation/
    ├── cubit/           # Cubit + State
    ├── pages/           # Screen pages
    └── widgets/         # Feature-specific widgets
```

## 🎯 Naming Conventions

- **Models**: `FeatureModel`
- **Datasources**: `FeatureRemoteDatasource` (abstract), `FeatureRemoteDatasourceImpl`
- **Repositories**: `FeatureRepository` (abstract), `FeatureRepositoryImpl`
- **Cubits**: `FeatureCubit`
- **States**: `FeatureState`, `FeatureLoading`, `FeatureSuccess`, `FeatureFailure`
- **Pages**: `FeaturePage`
- **Widgets**: `CustomWidget`

## 🚀 Setup va Run

```bash
# Dependencies o'rnatish
flutter pub get

# Build
flutter build apk      # Android
flutter build ipa      # iOS
flutter build web      # Web

# Development
flutter run            # Debug mode
flutter run -v         # Verbose
```

## 📱 Authentication Flow

1. User login page-da email/password kiritadi
2. Cubit `login` method chaqiriladi
3. Repository `login` method-ni ishlaydi
4. Datasource API-ga POST request yuboradi
5. Response token + user data bilan qaytadi
6. State `AuthSuccess` emit qiladi
7. UI home page-ga o'tadi

## 📚 Testing Strategy

- Unit testing (Cubit, Repository)
- Widget testing (UI Components)
- Integration testing (API flows)
- Mock datasources va repositories

## ⚠️ Kamonki

- ❌ Hech qanday `Either<Failure, Success>`
- ❌ UseCase abstraktsiyasi
- ❌ Entity/DTO o'rtasi farq
- ❌ `_buildXxx()` metodlar
- ❌ Business logic UI-da
- ❌ Global variables
- ❌ Ortiqcha provider patterns

## ✅ Best Practices

- ✅ Validation, extension va utilities ishlatish
- ✅ Equatable immutable state
- ✅ BlocBuilder/BlocListener pattern
- ✅ Try-catch exceptions handling
- ✅ Constants file-da konfiguratsiya
- ✅ AppDio singleton
- ✅ Get_it setup service locator

---

**Production Ready Flutter App** 🎯
