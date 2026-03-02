import 'package:flutter/material.dart';
import 'dart:async'; // Para el temporizador
import 'package:mi_intesud_social/pages/login_page.dart'; // Importa tu LoginPage (ajusta la ruta si es necesario)

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Espera 3 segundos y luego va al login
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Fondo gris claro como en la imagen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tu logo real en lugar de "LOGO"
            Container(
              padding: const EdgeInsets.all(8), // Espacio alrededor del logo
              decoration: BoxDecoration(
                color: Colors.grey[300], // Fondo gris del contenedor, como en la imagen
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
              ),
              child: Image.asset(
                'assets/logo.png', // 👈 Tu logo aquí
                width: 120, // Ajusta el ancho si quieres (prueba con 100-150)
                height: 60, // Ajusta la altura (para que no se estire)
                fit: BoxFit.contain, // Mantiene las proporciones del logo
              ),
            ),
            const SizedBox(height: 16),

            // Texto principal
            const Text(
              'MI INTESUD SOCIAL',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Subtítulo
            const Text(
              'Red Social Institucional',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 100), // Espacio para el spinner abajo

            // Spinner de carga
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}