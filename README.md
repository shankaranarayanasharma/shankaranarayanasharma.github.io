# Flutter Portfolio - Project Image Management Guide

This guide explains step-by-step how to add new project screenshots, organize them into folders, register them in `pubspec.yaml`, and display them automatically in the project details carousel with dynamic device mockups.

---

## 📁 Step 1: Where to Put the Images

Create a dedicated folder for your project inside `assets/images/`:

```
assets/images/<project_folder_name>/
```

### Folder Structure Example
Place your main thumbnail image in the project folder and organize device screenshots into platform subfolders:

```
assets/images/request_management/
├── rm.png                        # Main project thumbnail / preview image
├── android/                      # Android phone screenshots
│   ├── screen1.jpg
│   ├── screen2.jpg
│   ├── screen3.jpg
│   └── screen4.jpg
└── tablet/                       # Tablet / iPad screenshots
    ├── screen1.png
    ├── screen2.png
    ├── screen3.png
    └── screen4.png
```

### Supported Platform Subfolder Names
`ProjectMediaCarousel` automatically detects the platform based on folder names:
- `/android/` or `_android` → Android Mockup Frame
- `/iphone/` or `/ios/` or `_iphone` → iPhone Mockup Frame
- `/tablet/` or `_tablet` → Android Tablet Frame
- `/ipad/` or `_ipad` → iPad Mockup Frame
- `/web/` or `_web` → Web Browser Frame
- `/mac/` or `/macos/` or `_mac` → macOS Desktop Frame

---

## ⚙️ Step 2: Register Folders in `pubspec.yaml`

Flutter requires every directory containing assets to be explicitly registered in `pubspec.yaml`.

Open `pubspec.yaml` and add your new project directory and its subdirectories under `flutter:` → `assets:`:

```yaml
flutter:
  assets:
    - assets/images/request_management/
    - assets/images/request_management/android/
    - assets/images/request_management/tablet/
```

> ⚠️ **Note:** Subdirectories are not recursively added by Flutter automatically. You must list each subfolder (e.g. `android/`, `tablet/`) ending with a trailing `/`.

---

## 📝 Step 3: Assign Project in `lib/data/portfolio_data.dart`

Open [`lib/data/portfolio_data.dart`](file:///Users/shankaranarayanasharma/Projects/Github/shankaranarayanasharma.github.io/lib/data/portfolio_data.dart) and locate or add your project entry in the `portfolioProjects` list:

```dart
{
  "title": "Request Management",
  "description": "Request management system helping admins and users...",
  "image": "assets/images/request_management/rm.png", // Point to main image inside the project folder
  "categories": ["Flutter"],
  "media": [], // Leave empty! Images in subfolders are scanned and loaded automatically.
  "technologies": ["Flutter", "Laravel", "MySQL", "Bloc"],
  "github": "https://github.com/shankaranarayanasharma",
  "year": "2024",
  "role": "Lead Developer",
  "projectType": "Mobile App",
}
```

### How Automatic Loading Works
Because `"image"` points to `assets/images/request_management/rm.png`, the app calculates the base folder (`assets/images/request_management/`) and automatically:
1. Scans all asset keys in `AssetManifest`.
2. Discovers all screenshot files in `android/`, `tablet/`, etc.
3. Groups screenshots by device platform.
4. Renders platform filter tabs and displays screenshots inside interactive device frames.

---

## 🚀 Step 4: Restart the Application

Whenever you add new asset files or edit `pubspec.yaml`:
- **Hot Reload will NOT load new assets**.
- Perform a **Hot Restart** (`R` in terminal) or rebuild/restart your app (`flutter run`).

---

## 💡 Quick Checklist Summary
1. 📂 Place files in `assets/images/<project_name>/<platform>/`
2. ⚙️ Register folder paths in `pubspec.yaml`
3. 📝 Set `"image": "assets/images/<project_name>/<main_image>.png"` and `"media": []` in `portfolio_data.dart`
4. 🔄 Perform a Hot Restart!
