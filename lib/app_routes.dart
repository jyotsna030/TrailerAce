import 'package:flutter/material.dart';
import 'package:trailerace/screens/phone_verification_screen.dart';
import 'package:trailerace/screens/otp_verification_screen.dart';
import 'package:trailerace/screens/dashboard_screen.dart';
import 'package:trailerace/screens/registration_screen.dart';
import 'package:trailerace/screens/login_screen.dart';
import 'package:trailerace/screens/home_screen.dart';
import 'package:trailerace/screens/end_shift_screen.dart';
import 'package:trailerace/screens/extra_shifts_screen.dart';
import 'package:trailerace/screens/chat_screen.dart';

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    '/': (context) => PhoneVerificationScreen(),
    '/otp-verification': (context) => OTPVerificationScreen(),
    '/dashboard': (context) => DashboardScreen(),
    '/registration': (context) => RegistrationScreen(),
    '/login': (context) => LoginScreen(),
    '/home': (context) => HomeScreen(),
    '/end-shift': (context) => EndShiftScreen(),
    '/extra-shifts': (context) => ExtraShiftsScreen(),
    '/chat': (context) => ChatScreen(),
  };
}
