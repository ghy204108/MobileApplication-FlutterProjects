# Chapter 8 Firebase Notes Setup

This app implements the Firebase Firestore CRUD hands-on practice from Chapter 8.

## App Summary

- App name: Firebase Notes
- Android package name: com.example.chapter8_practice_firebase
- Firestore collection: notes
- Fields:
  - title
  - content
  - timestamp

## Firebase Setup Needed

1. Open Firebase Console and create a Firebase project.
2. Register an Android app using this package name:

```text
com.example.chapter8_practice_firebase
```

3. Download `google-services.json`.
4. Place it here:

```text
android/app/google-services.json
```

5. Enable Firestore Database in test mode for class practice.
6. Run the app again.

Without `google-services.json`, the app opens a setup screen instead of crashing.
