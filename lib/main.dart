import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mi_intesud_social/firebase_options.dart';
import 'package:mi_intesud_social/pages/welcome_screen.dart';
import 'package:mi_intesud_social/pages/login_page.dart';
import 'package:mi_intesud_social/pages/guest_home_page.dart';
import 'package:mi_intesud_social/screens/home_screen.dart';
import 'package:mi_intesud_social/screens/store_screen.dart';
import 'package:mi_intesud_social/screens/profile_screen.dart';
import 'package:mi_intesud_social/screens/settings_screen.dart';
import 'package:mi_intesud_social/screens/edit_profile_screen.dart';
import 'package:mi_intesud_social/pages/eventos_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MiIntesudSocialApp());
}

class MiIntesudSocialApp extends StatelessWidget {
  const MiIntesudSocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MI INTESUD SOCIAL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xfff5f5f5),
      ),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/guest-home': (context) => const GuestHomePage(),
        '/home': (context) => const HomeScreen(username: 'Usuario'),
        '/store': (context) => const StoreScreen(username: 'Usuario'),
        '/profile': (context) => const ProfileScreen(username: 'Usuario'),
        '/settings': (context) => const SettingsScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/eventos': (context) => const EventosScreen(),
      },
    );
  }
}