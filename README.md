# MobileApplication-FlutterProjects

This repository contains a collection of Flutter practice projects for a Mobile Application Development course. Each folder is an independent Flutter project or chapter practice folder.

## Projects

| Folder | Description |
| --- | --- |
| `chapter2_practice` | Basic Flutter starter app and counter-style practice. |
| `chapter3_practice` | Restaurant and diet browsing UI practice using widgets, models, assets, and SVGs. |
| `chapter4_practice` | Contact list app using ListView and navigation to a detail page. |
| `chapter5_practice` | Food category grid app with category cards and detail screens. |
| `chapter6_practice` | BMI calculator practice using TextField input and basic calculations. |
| `chapter7_practice` | Chapter 7 practice notes or placeholder folder. |
| `chapter7_practice_SQLite` | SQLite CRUD notes app using local database storage. |
| `chapter8_practice_Firebase` | Firebase notes app using Firebase Core and Cloud Firestore. |
| `chapter9_practice` | OpenStreetMap practice app using flutter_map and map markers. |

## Requirements

- Flutter SDK
- Dart SDK compatible with the versions listed in each project's `pubspec.yaml`
- Android Studio, VS Code, or another Flutter-compatible editor
- A configured emulator or physical device

## How to Run a Project

Open a terminal inside any Flutter project folder, then run:

```bash
flutter pub get
flutter run
```

For example:

```bash
cd chapter9_practice
flutter pub get
flutter run
```

## Notes

Generated Flutter files such as `build/`, `.dart_tool/`, platform build folders, and local environment files are ignored by git. The Firebase project does not include private local configuration by default, so set up your own Firebase project before running it.
