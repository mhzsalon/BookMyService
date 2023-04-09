import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/splash_page.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: 'test_public_key_23811b40badb44a8a1122e318e0f1ad5',
      builder: (context, navkey) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          navigatorKey: navkey,
          localizationsDelegates: const [KhaltiLocalizations.delegate],
        );
      },
    );
  }
}
