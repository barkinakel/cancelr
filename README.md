# Cancelr

A Flutter mobile application developed for **CS310 – Mobile Application Development**.

## About

Many people sign up for free trials and subscriptions (streaming services, software, apps) and forget to cancel them in time, resulting in unwanted charges. **Cancelr** lets users keep track of all their free trials and subscriptions in one place and sends reminders before a trial ends or a payment is due, so they can decide whether to cancel or continue before they are charged.

**Intended users:** Anyone who uses free trials or multiple subscriptions, especially students and young adults managing a limited budget.

## Planned Features

- Add, edit and delete free trials / subscriptions (name, end date, price)
- List of upcoming trial expirations and payment dates
- Reminder notifications before a trial ends
- User sign up / log in

## Running the app

**Flutter version:** 3.50.0 (stable channel)

1. Install Flutter and Android Studio, then make sure `flutter doctor` shows no errors for Flutter and the Android toolchain.
2. Start an Android emulator (Android Studio → Device Manager) or an iOS simulator.
3. In the project folder, run:

```
flutter pub get
flutter run
```

Run the tests with `flutter test`.

Step 2.2 uses placeholder data; login and sign-up are UI only. Firebase is added in Step 3.

## Project structure

```
lib/
  main.dart, app.dart   app entry point, theme and routes
  theme/                colors, text styles and spacing shared by all screens
  models/               Subscription model
  data/                 sample data and the in-memory store
  routes/               route names for every screen
  widgets/              reusable widgets (buttons, text fields, filter row, logo, bottom bar, dialogs)
  screens/              one file per screen
assets/
  fonts/                Anton and Space Grotesk (Open Font License)
  images/               local images (app logo)
```

## Group Details

**Group:** 33

| Name | Student ID | GitHub |
|------|------------|--------|
| Barkın Akel | 34223 | @barkinakel |
| Onat Köse | 34383 | @koseonat |
| Zeynep Sezer | 34132 | @zeynepsezer827 |
| Boran Öztaş | 34168 | @boranoztas |

## Tech Stack

- Flutter (Dart)
- Firebase
