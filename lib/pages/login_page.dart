import 'package:flutter/material.dart';
import 'dart:async'; // Para temporizadores si necesitas

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cedulaController = TextEditingController();

  bool recordar = false;
  bool obscurePassword = true;

  String? message; // Mensaje dinámico (success o error)
  Color? messageColor; // Color del mensaje

  late AnimationController _animController;
  late Animation<double> fadeAnim;
  late Animation<double> scaleAnim;

  @override
  void initState() {
    super.initState();

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

  // Simula login (muestra mensaje success o error)
  void _handleLogin() {
    // Aquí iría lógica real de backend, por ahora simula
    setState(() {
      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
        message = "✅ Cuenta activada correctamente";
        messageColor = Colors.green;
      } else {
        message = "❌ La cédula no se encuentra registrada en el sistema académico.";
        messageColor = Colors.red;
      }
    });

    // Simula navegación con fade-out después de mostrar mensaje
    Timer(const Duration(seconds: 2), () {
      // Aquí Navigator.pushReplacement con fade a página principal (por ahora snackbar)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? 'Procesando...')),
      );
      // Para fade-out real: Navigator.pushReplacement con PageRouteBuilder como en splash
    });
  }

  // Simula validación de cédula
  void _handleValidar() {
    // Aquí iría lógica real, por ahora simula
    setState(() {
      if (cedulaController.text.isNotEmpty) {
        message = "✅ Cuenta activada correctamente";
        messageColor = Colors.green;
      } else {
        message = "❌ La cédula no se encuentra registrada en el sistema académico.";
        messageColor = Colors.red;
      }
    });

    // Simula navegación con fade-out
    Timer(const Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? 'Validando...')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Fondo gradiente elegante y profesional, igual al splash mejorado
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // HEADER: Título principal con sombra para profundidad
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
                    const SizedBox(height: 8),

                    // Subtítulo
                    const Text(
                      'Red Social Institucional',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // CUERPO: Logo con scale-in, usando la imagen real en lugar del icono
                    ScaleTransition(
                      scale: scaleAnim,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0x33467B79).withOpacity(0.2),
                        backgroundImage: const AssetImage('assets/login.png'), // 
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Título secundario
                    const Text(
                      'MI INTESUD SOCIAL',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'Bienvenido nuevamente',
                      style: TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 22),

                    // EMAIL
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _inputField(
                        controller: emailController,
                        hint: "Correo institucional",
                        icon: Icons.email,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // PASSWORD
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _inputField(
                        controller: passwordController,
                        hint: "Contraseña",
                        icon: Icons.lock,
                        obscure: obscurePassword,
                        suffix: IconButton(
                          icon: Icon(obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () =>
                              setState(() => obscurePassword = !obscurePassword),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Row con checkbox y link
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: const Color(0xFF467B79),
                            value: recordar,
                            onChanged: (v) => setState(() => recordar = v!),
                          ),
                          const Text("Recordar sesión"),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // Lógica para olvidar contraseña (por ahora vacío)
                            },
                            child: const Text(
                              "¿Olvidaste tu contraseña?",
                              style: TextStyle(color: Color(0xFF467B79)),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // BOTÓN LOGIN
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _mainButton("INICIAR SESIÓN", _handleLogin),
                    ),
                    const SizedBox(height: 16),

                    const Text("o"),
                    const SizedBox(height: 16),

                    const Text("Primer ingreso – Validar matrícula"),
                    const SizedBox(height: 12),

                    // CÉDULA
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _inputField(
                        controller: cedulaController,
                        hint: "Número de cédula",
                        icon: Icons.badge,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // BOTÓN VALIDAR
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _secondaryButton("VALIDAR Y ACTIVAR CUENTA", _handleValidar),
                    ),
                    const SizedBox(height: 16),

                    // FOOTER: Mensaje dinámico (solo si hay)
                    if (message != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _message(message!, messageColor!),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 INPUT MODERNO (mejorado con sombras sutiles)
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF467B79)),
          hintText: hint,
          filled: true,
          fillColor: Colors.white, // Cambiado a blanco para contraste con gradiente
          suffixIcon: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // 🔥 BOTÓN PRINCIPAL (con animación de press)
  Widget _mainButton(String text, VoidCallback onTap) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF467B79),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          shadowColor: Colors.black.withOpacity(0.2),
          elevation: 4,
        ),
        onPressed: onTap,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  // BOTÓN SECUNDARIO (mejorado con elevación sutil)
  Widget _secondaryButton(String text, VoidCallback onTap) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF467B79),
        side: const BorderSide(color: Color(0xFF467B79)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      onPressed: onTap,
      child: SizedBox(width: double.infinity, child: Center(child: Text(text))),
    );
  }

  // MENSAJES (con animación fade-in cuando aparece)
  Widget _message(String text, Color color) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _animController,
        curve: Curves.easeIn,
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 10),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: color, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}