import 'package:flutter/material.dart';
import 'dart:async'; // Para el temporizador
import 'package:mi_intesud_social/welcome_screen.dart'; // 👈 Importa la nueva Bienvenida (ajusta la ruta si es necesario)

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> fadeAnim;
  late Animation<double> scaleAnim;

  @override
  void initState() {
    super.initState();

    // Configura el controlador de animación (igual que en login)
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Fade-in para toda la pantalla
    fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);

    // Scale-in sutil para el logo
    scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );

    // Inicia la animación de entrada
    _animController.forward();

    // Temporizador para pasar a la BIENVENIDA con transición suave (4 segundos)
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Transición de salida: fade suave
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500), // Suave y rápida
        ),
      );
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Fondo gradiente elegante y profesional: de gris claro a acento sutil
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xfff5f5f5), // Gris claro del login (arriba)
              Color(0xFFE0F2F1), // Tono suave derivado del acento 0xFF467B79
              Color(0xFFB2DFDB), // Más profundidad, elegante sin ser chillón
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: fadeAnim, // Efecto de entrada fade-in
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo con scale-in animado, más grande para impacto full-screen
                  ScaleTransition(
                    scale: scaleAnim,
                    child: GestureDetector(
                      onTap: () {}, // Puedes agregar algo si quieres
                      child: CircleAvatar(
                        radius: 80, // Más grande para llenar pantalla profesionalmente
                        backgroundColor: const Color(0x33467B79).withOpacity(0.2), // Fondo translúcido sutil
                        backgroundImage: const AssetImage("assets/login.png"), // 👈 Tu logo
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Texto principal con sombra suave para profundidad
                  const Text(
                    'MI INTESUD SOCIAL',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF467B79), // Acento del login para elegancia
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black12,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtítulo con estilo moderno
                  const Text(
                    'Red Social Institucional',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Elemento visual adicional: Línea divisoria elegante
                  Container(
                    width: 200,
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.transparent, Color(0xFF467B79), Colors.transparent],
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),

                  // Spinner con color acento y tamaño mayor para visibilidad
                  const CircularProgressIndicator(
                    strokeWidth: 5,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF467B79)),
                  ),
                  const SizedBox(height: 16),

                  // Texto de carga para no dejar vacío, profesional
                  const Text(
                    'Cargando tu experiencia social...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}