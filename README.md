# 🎯 LingoLab - Professional Flutter Architecture

**Production-Level** Flutter app arxitekturasi - **Clean**, **Simple**, **Scalable**

## ✨ Arkitektura Xususiyatlari

✅ **NO Entity/UseCase/Either/Failure** - Ortiqcha pattern yo'q  
✅ **NO Repository Abstraction** - Direct implementation  
✅ **NO dartz Package** - Exception throw  
✅ **Cubit Pattern** - Simple state management  
✅ **Dio Networking** - Modern HTTP client  
✅ **Get_it DI** - Dependency injection  
✅ **Production Ready** - Real-world app uchun  

## 📊 Project Structure

```
lib/
├── core/
│   ├── constants/           ← App konfiguratsiya
│   ├── network/             ← Dio + Interceptors
│   ├── services/            ← Local storage
│   ├── utils/               ← Validators, Extensions
│   └── widgets/             ← Reusable UI components
│
├── features/
│   ├── auth/                ← Authentication feature
│   │   ├── data/            ← Models, Datasource, Repository
│   │   └── presentation/    ← Cubit, Pages, Widgets
│   │
│   └── home/                ← Home feature (example)
│       ├── data/
│       └── presentation/
│
├── injection_container.dart ← DI Setup
└── main.dart               ← App entry point
```

## 🚀 Getting Started

### 1. Setup
```bash
flutter pub get
```

### 2. Run
```bash
flutter run
```

### 3. Build
```bash
flutter build apk      # Android
flutter build ipa      # iOS
flutter build web      # Web
```

## 📝 Feature Structure

Har bir feature uchun:

```
my_feature/
├── data/
│   ├── models/
│   │   └── my_feature_models.dart
│   ├── datasources/
│   │   └── my_feature_remote_datasource.dart
│   └── repositories/
│       └── my_feature_repository.dart
│
└── presentation/
    ├── cubit/
    │   ├── my_feature_cubit.dart
    │   └── my_feature_state.dart
    ├── pages/
    │   └── my_feature_page.dart
    └── widgets/
        └── custom_widget.dart
```

## 📦 Dependencies

```yaml
flutter_bloc: ^8.1.3
get_it: ^7.6.0
dio: ^5.3.1
equatable: ^2.0.5
```

## 🔐 Key Principles

- **KISS**: Keep It Simple, Stupid
- **YAGNI**: You Aren't Gonna Need It
- **DRY**: Don't Repeat Yourself
- **Production Ready**: Error handling, Validation

## ✅ What's Included

✅ Cubit state management  
✅ Dio networking with interceptors  
✅ Dependency injection (get_it)  
✅ Clean folder structure  
✅ Auth & Home features  
✅ Custom widgets  
✅ Validators & Extensions  

## ⚠️ What's NOT Included

❌ Entity/UseCase pattern  
❌ Either<Failure, Success>  
❌ dartz package  
❌ `_buildXxx()` methods  
❌ Business logic in UI  

---

See `ARCHITECTURE.md` for detailed guide.
