import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class CalendarService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [CalendarApi.calendarEventsScope],
  );

  Future<void> addEvent({
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final httpClient = (await _googleSignIn.authenticatedClient())!;
      final calendar = CalendarApi(httpClient);

      final event = Event()
        ..summary = title
        ..description = description
        ..start = (EventDateTime()..dateTime = startTime)
        ..end = (EventDateTime()..dateTime = endTime);

      await calendar.events.insert(event, 'primary');
    } catch (e) {
      print('Error al añadir evento al calendario: $e');
      rethrow;
    }
  }
}
