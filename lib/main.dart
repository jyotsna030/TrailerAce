import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Ensure this import is correct
import 'screens/phone_verification_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(TraileraceApp());
}

class TraileraceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trailerace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhoneVerificationScreen(),
    );
  }
}
