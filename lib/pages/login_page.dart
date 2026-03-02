import 'package:flutter/material.dart';

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

  late AnimationController _animController;
  late Animation<double> fadeAnim;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: FadeTransition(
          opacity: fadeAnim,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: isMobile ? double.infinity : 420,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 18,
                      color: Colors.black.withOpacity(0.08),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.menu),
                    const SizedBox(height: 10),

                    const Text(
                      "MI INTESUD SOCIAL",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Red Social Institucional",
                      style: TextStyle(fontSize: 12),
                    ),

                    const SizedBox(height: 24),

                    // 🔥 LOGO PERSONALIZABLE
                    GestureDetector(
                      onTap: () {
                        // luego aquí puedes abrir selector de imagen
                      },
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: const Color(0x33467B79),
                        backgroundImage:
                            const AssetImage("assets/logo.png"), // 👈 TU LOGO
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      "MI INTESUD SOCIAL",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Text("Bienvenido nuevamente"),

                    const SizedBox(height: 22),

                    // EMAIL
                    _inputField(
                      controller: emailController,
                      hint: "Correo institucional",
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 14),

                    // PASSWORD
                    _inputField(
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

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Checkbox(
                          activeColor: const Color(0xFF467B79),
                          value: recordar,
                          onChanged: (v) => setState(() => recordar = v!),
                        ),
                        const Text("Recordar sesión"),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "¿Olvidaste tu contraseña?",
                            style: TextStyle(color: Color(0xFF467B79)),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 12),

                    // BOTÓN LOGIN
                    _mainButton("INICIAR SESIÓN", () {}),

                    const SizedBox(height: 16),
                    const Text("o"),

                    const SizedBox(height: 16),
                    const Text("Primer ingreso – Validar matrícula"),

                    const SizedBox(height: 12),

                    _inputField(
                      controller: cedulaController,
                      hint: "Número de cédula",
                      icon: Icons.badge,
                    ),

                    const SizedBox(height: 12),

                    _secondaryButton("VALIDAR Y ACTIVAR CUENTA", () {}),

                    const SizedBox(height: 16),

                    // MENSAJES
                    _message("Cuenta activada correctamente", Colors.green),
                    const SizedBox(height: 6),
                    _message(
                        "La cédula no se encuentra registrada en el sistema académico.",
                        Colors.red),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 INPUT MODERNO
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF467B79)),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // 🔥 BOTÓN PRINCIPAL
  Widget _mainButton(String text, VoidCallback onTap) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF467B79),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: onTap,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  // BOTÓN SECUNDARIO
  Widget _secondaryButton(String text, VoidCallback onTap) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF467B79),
        side: const BorderSide(color: Color(0xFF467B79)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: onTap,
      child: SizedBox(width: double.infinity, child: Center(child: Text(text))),
    );
  }

  // MENSAJES
  Widget _message(String text, Color color) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 10),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(color: color, fontSize: 12)),
        )
      ],
    );
  }
}