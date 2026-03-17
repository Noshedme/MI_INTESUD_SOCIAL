import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/feed_guest_screen.dart';
import 'screens/events_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/comments_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/store_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/change_password_screen.dart';

void main() {
  runApp(const MiIntesudApp());
}

class MiIntesudApp extends StatelessWidget {
  const MiIntesudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MI INTESUD SOCIAL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2DA679),
          primary: const Color(0xFF103B40),
          secondary: const Color(0xFF2DA679),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/':                 (context) => const SplashScreen(),
        '/welcome':          (context) => const WelcomeScreen(),
        '/login':            (context) => const LoginScreen(),
        '/register':         (context) => const RegisterScreen(),
        '/feed-guest':       (context) => const FeedGuestScreen(),
        '/events':           (context) => const EventsScreen(),
        '/feed':             (context) => const FeedScreen(),
        '/comments':         (context) => const CommentsScreen(),
        '/messages':         (context) => const MessagesScreen(),
        '/profile':          (context) => const ProfileScreen(),
        '/store':            (context) => const StoreScreen(),
        '/settings':         (context) => const SettingsScreen(),
        '/notifications':    (context) => const NotificationsScreen(),
        '/edit-profile':     (context) => const EditProfileScreen(),
        '/change-password':  (context) => const ChangePasswordScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/chat') {
          final userId = settings.arguments as int? ?? 1;
          return MaterialPageRoute(
            builder: (_) => ChatScreen(userId: userId),
          );
        }
        if (settings.name == '/store') {
          final isGuest = settings.arguments as bool? ?? false;
          return MaterialPageRoute(
            builder: (_) => StoreScreen(isGuest: isGuest),
          );
        }
        if (settings.name == '/comments') {
          return MaterialPageRoute(
            builder: (_) => const CommentsScreen(),
          );
        }
        return null;
      },
    );
  }
}