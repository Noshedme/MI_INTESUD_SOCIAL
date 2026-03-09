import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mi_intesud_social/pages/home_page.dart';

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
  bool cargando = false;

  String? mensajeExito;
  String? mensajeError;

  late AnimationController _animController;
  late Animation<double> fadeAnim;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cedulaController.dispose();
    super.dispose();
  }

  Future<void> iniciarSesion() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        mensajeExito = null;
        mensajeError = 'Ingresa correo y contraseña.';
      });
      return;
    }

    setState(() {
      cargando = true;
      mensajeExito = null;
      mensajeError = null;
    });

    try {
      final resultado = await FirebaseFirestore.instance
          .collection('usuarios')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (resultado.docs.isEmpty) {
        setState(() {
          mensajeError = 'Correo o contraseña incorrectos.';
        });
        return;
      }

      final datos = resultado.docs.first.data();
      final nombre = (datos['nombre'] ?? '').toString();
      final correo = (datos['email'] ?? '').toString();
      final rol = (datos['rol'] ?? '').toString();

      setState(() {
        mensajeExito = 'Inicio de sesión correcto.';
      });

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            nombre: nombre,
            email: correo,
            rol: rol,
          ),
        ),
      );
    } catch (e) {
      setState(() {
        mensajeError = 'Error al iniciar sesión: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          cargando = false;
        });
      }
    }
  }

  Future<void> validarCedula() async {
    final cedula = cedulaController.text.trim();

    if (cedula.isEmpty) {
      setState(() {
        mensajeExito = null;
        mensajeError = 'Ingresa una cédula.';
      });
      return;
    }

    setState(() {
      cargando = true;
      mensajeExito = null;
      mensajeError = null;
    });

    try {
      final resultado = await FirebaseFirestore.instance
          .collection('usuarios')
          .where('C.I', isEqualTo: cedula)
          .limit(1)
          .get();

      if (resultado.docs.isEmpty) {
        setState(() {
          mensajeError =
              'La cédula no se encuentra registrada en el sistema.';
        });
        return;
      }

      final datos = resultado.docs.first.data();
      final nombre = (datos['nombre'] ?? '').toString();

      setState(() {
        mensajeExito = 'Cuenta validada correctamente para $nombre.';
      });
    } catch (e) {
      setState(() {
        mensajeError = 'Error al validar cédula: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          cargando = false;
        });
      }
    }
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
                    ),
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

                    GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 36,
                        backgroundColor: Color(0x33467B79),
                        backgroundImage: AssetImage("assets/logo.png"),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      "MI INTESUD SOCIAL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text("Bienvenido nuevamente"),

                    const SizedBox(height: 22),

                    _inputField(
                      controller: emailController,
                      hint: "Correo institucional",
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 14),

                    _inputField(
                      controller: passwordController,
                      hint: "Contraseña",
                      icon: Icons.lock,
                      obscure: obscurePassword,
                      suffix: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Checkbox(
                          activeColor: const Color(0xFF467B79),
                          value: recordar,
                          onChanged: (v) {
                            setState(() {
                              recordar = v ?? false;
                            });
                          },
                        ),
                        const Text("Recordar sesión"),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "¿Olvidaste tu contraseña?",
                            style: TextStyle(color: Color(0xFF467B79)),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    _mainButton(
                      cargando ? "CARGANDO..." : "INICIAR SESIÓN",
                      cargando ? null : iniciarSesion,
                    ),

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

                    _secondaryButton(
                      "VALIDAR Y ACTIVAR CUENTA",
                      cargando ? null : validarCedula,
                    ),

                    const SizedBox(height: 16),

                    if (mensajeExito != null)
                      _message(mensajeExito!, Colors.green),

                    if (mensajeError != null) ...[
                      if (mensajeExito != null) const SizedBox(height: 6),
                      _message(mensajeError!, Colors.red),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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

  Widget _mainButton(String text, VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF467B79),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _secondaryButton(String text, VoidCallback? onTap) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF467B79),
        side: const BorderSide(color: Color(0xFF467B79)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Center(child: Text(text)),
      ),
    );
  }

  Widget _message(String text, Color color) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 10),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 12),
          ),
        ),
      ],
    );
  }
}