import 'package:flutter/material.dart';
// Importamos las páginas usando la ruta completa del paquete
import 'package:mi_intesud_social/pages/login_page.dart';
import 'package:mi_intesud_social/pages/profile_screen.dart';
import 'package:mi_intesud_social/pages/store_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MI INTESUD SOCIAL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // Habilita el diseño moderno de Material 3
        primaryColor: const Color(0xFF103B40),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2DA679),
          primary: const Color(0xFF103B40),
          secondary: const Color(0xFF2DA679),
        ),
        fontFamily: 'Arial',
      ),
      // Definimos la página inicial
      home: const LoginPage(),
      
      // Opcional: Definir rutas para usar Navigator.pushNamed
      routes: {
        '/login': (context) => const LoginPage(),
        '/store': (context) => const StoreScreen(),
        '/profile': (context) => const ProfileScreen(username: 'Usuario INTESUD'),
      },
    );
  }
}