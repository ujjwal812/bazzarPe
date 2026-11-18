import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/otp_screen.dart';
import '../screens/privacy_screen.dart';
import '../screens/profile_setup_screen.dart';
import '../screens/location_screen.dart';
import '../screens/home_screen.dart';
import '../screens/pickup_screen.dart';
import '../screens/tracking_screen.dart';
import '../screens/vendor_screen.dart';
import '../screens/verification_screen.dart';
import '../screens/completed_screen.dart';
import '../screens/invoice_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/notifications_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String privacy = '/privacy';
  static const String profileSetup = '/profile-setup';
  static const String location = '/location';
  static const String home = '/home';
  static const String pickup = '/pickup';
  static const String tracking = '/tracking';
  static const String vendor = '/vendor';
  static const String verification = '/verification';
  static const String completed = '/completed';
  static const String invoice = '/invoice';
  static const String settings = '/settings';
  static const String notifications = '/notifications';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        onboarding: (context) => const OnboardingScreen(),
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),
        otp: (context) => const OtpScreen(),
        privacy: (context) => const PrivacyScreen(),
        profileSetup: (context) => const ProfileSetupScreen(),
        location: (context) => const LocationScreen(),
        home: (context) => const HomeScreen(),
        pickup: (context) => const PickupScreen(),
        tracking: (context) => const TrackingScreen(),
        vendor: (context) => const VendorScreen(),
        verification: (context) => const VerificationScreen(),
        completed: (context) => const CompletedScreen(),
        invoice: (context) => const InvoiceScreen(),
        settings: (context) => const SettingsScreen(),
        notifications: (context) => const NotificationsScreen(),
      };
}
