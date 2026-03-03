import 'package:flutter/material.dart';
import 'package:mi_intesud_social/pages/login_page.dart'; // Importa tu LoginPage (ajusta la ruta si es necesario)

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> fadeAnim;
  late Animation<double> scaleAnim;

  @override
  void initState() {
    super.initState();

    // Configura el controlador de animación (igual que en splash y login)
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
          // Fondo gradiente elegante y profesional, igual al splash y login
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xfff5f5f5), // Gris claro (arriba)
              Color(0xFFE0F2F1), // Tono suave derivado del acento 0xFF467B79
              Color(0xFFB2DFDB), // Más profundidad, elegante
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
                  // Logo en rectángulo gris, como en wireframe
                  ScaleTransition(
                    scale: scaleAnim,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // Gris como en wireframe
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/login.png', // Tu logo (fallback a texto si no carga)
                        width: 120,
                        height: 60,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Text(
                          'LOGO',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Título principal con sombra
                  const Text(
                    'MI INTESUD SOCIAL',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF467B79),
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

                  // Subtítulo largo, como en wireframe
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Conectamos a toda la comunidad educativa del Instituto Sudamericano Quito!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),

                  // Botón "INICIAR SESIÓN" (gris como wireframe, va a Login)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300], // Gris como en wireframe
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            transitionDuration: const Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(child: Text('INICIAR SESIÓN', style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Botón "ENTRAR COMO INVITADO" (gris claro, placeholder)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200], // Gris más claro como en wireframe
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 2,
                        shadowColor: Colors.black.withOpacity(0.1),
                      ),
                      onPressed: () {
                        // Placeholder: Muestra mensaje (dime si quieres navegar a otra pantalla)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Entrando como invitado... (próximamente)')),
                        );
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(child: Text('ENTRAR COMO INVITADO', style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
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