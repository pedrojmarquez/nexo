import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_widget/home_widget.dart';
import 'package:nexo/firebase_options.dart';
import 'package:nexo/app.dart';
import 'package:nexo/core/services/notification_service.dart';
import 'package:nexo/core/services/home_widget_service.dart';
import 'package:timezone/data/latest.dart' as tz;

/// ─────────────────────────────────────────────────────────────────────────────
/// Punto de entrada de Nexo
/// Bootstrap: Firebase → ProviderScope → MaterialApp
/// ─────────────────────────────────────────────────────────────────────────────
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  tz.initializeTimeZones();
  await NotificationService().init();

  await dotenv.load(fileName: ".env");

  // Registrar el callback que se dispara desde los widgets nativos
  // (p.ej. al tachar/destachar un item de la lista de la compra).
  HomeWidget.registerInteractivityCallback(shoppingWidgetBackgroundCallback);

  runApp(
    const ProviderScope(
      child: NexoApp(),
    ),
  );
}
