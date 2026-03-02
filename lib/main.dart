import 'package:flutter/material.dart';
import 'package:mi_intesud_social/splash_screen.dart'; // Importa la nueva splash (ajusta la ruta si es necesario)

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
        fontFamily: 'Arial',
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // ¡Empieza con Splash!
    );
  }
}