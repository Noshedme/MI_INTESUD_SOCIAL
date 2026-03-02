import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // Verifica que esta ruta sea correcta en tu proyecto

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
        primarySwatch: Colors.green,
        useMaterial3: true, // Habilita el diseño moderno de Flutter
      ),
      // Aquí aplicamos el simulador para que se vea como celular
      home: const MobileSimulator(child: HomePage()),
    );
  }
}

// Este widget envuelve tu app en un marco de teléfono
class MobileSimulator extends StatelessWidget {
  final Widget child;
  const MobileSimulator({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Fondo oscuro profesional
      body: Center(
        child: Container(
          // Dimensiones estándar de un smartphone moderno
          width: 375, 
          height: 812,
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(45), // Bordes curvos del móvil
            border: Border.all(color: Colors.black, width: 12), // El marco físico
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            children: [
              // La pantalla de la aplicación
              ClipRRect(
                borderRadius: BorderRadius.circular(33),
                child: child,
              ),
              // Detalle de la "Cámara/Notch" superior para realismo
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 150,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}