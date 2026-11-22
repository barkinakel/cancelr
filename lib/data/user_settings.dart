// Profile and settings for Step 2.2 (placeholder values).
// Firebase Authentication and Firestore replace this in Step 3.
class UserSettings {
  UserSettings._();

  static String name = 'Your name';
  static String email = 'name@email.com';
  static int defaultReminderDays = 3;
  static bool notificationsOn = true;

  static void reset() {
    name = 'Your name';
    email = 'name@email.com';
    defaultReminderDays = 3;
    notificationsOn = true;
  }
}
