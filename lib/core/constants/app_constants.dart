// Nexo Core Constants
abstract final class AppConstants {
  static const String appName = 'Nexo';
  static const String appVersion = '1.0.0';

  // Firestore collections
  static const String usersCollection = 'users';
  static const String notesCollection = 'notes';
  static const String mealPlansCollection = 'meal_plans';
  static const String quickNotesCollection = 'quick_notes';

  // Gemini model
  static const String geminiModel = 'gemini-1.5-flash';

  // Notification channel IDs
  static const String mealNotificationChannelId = 'nexo_meals';
  static const String calendarNotificationChannelId = 'nexo_calendar';
}
