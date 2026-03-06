import 'package:flutter/material.dart';
import 'package:mi_intesud_social/pages/splash_screen.dart'; // Ajusta si es necesario
import 'package:mi_intesud_social/pages/welcome_screen.dart'; // Importa Bienvenida
import 'package:mi_intesud_social/pages/login_page.dart'; // Importa Login (ajusta la ruta)

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
        fontFamily: 'Arial', // Si usas custom, agrégalo en pubspec.yaml
        primarySwatch: Colors.teal, // Cambiado a teal para acercar a 0xFF467B79 (o crea un custom swatch)
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
          accentColor: const Color(0xFF467B79), // Tu acento principal
        ),
        useMaterial3: true, // Activa Material 3 para diseños más modernos
      ),
      home: const SplashScreen(), // Empieza con Splash
      routes: {
        '/welcome': (context) => const WelcomeScreen(), // Ruta para Bienvenida
        '/login': (context) => const LoginPage(), // Ruta para Login
        // Agrega más rutas aquí si tienes otras pantallas (ej: '/home')
      },
    );
  }
}