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

      Navigator.pushReplacement(
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
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 700;

    return Scaffold(
      body: FadeTransition(
        opacity: fadeAnim,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF00695C),
                Color(0xFF4DB6AC),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 18 : 32,
                vertical: 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height - 48,
                ),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 980),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.96),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 24,
                          spreadRadius: 2,
                          offset: const Offset(0, 10),
                          color: Colors.black.withOpacity(0.12),
                        ),
                      ],
                    ),
                    child: isMobile
                        ? _buildMobileLayout()
                        : _buildDesktopLayout(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 11,
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00695C),
                  Color(0xFF2E8B80),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(28),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildLogoLarge(),
                const SizedBox(height: 28),
                const Text(
                  "MI INTESUD SOCIAL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Red Social Institucional",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  "Conecta con tu comunidad educativa, revisa información institucional y accede a tu cuenta de manera rápida y segura.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 30),
                _infoItem(Icons.school, "Acceso para estudiantes y docentes"),
                const SizedBox(height: 16),
                _infoItem(Icons.verified_user, "Validación segura de cuenta"),
                const SizedBox(height: 16),
                _infoItem(Icons.groups, "Conexión con la comunidad INTESUD"),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 12,
          child: Padding(
            padding: const EdgeInsets.all(36),
            child: _buildFormContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          _buildLogoSmall(),
          const SizedBox(height: 16),
          const Text(
            "MI INTESUD SOCIAL",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF00695C),
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Red Social Institucional",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          _buildFormContent(),
        ],
      ),
    );
  }

  Widget _buildFormContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bienvenido nuevamente",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00695C),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Inicia sesión con tu correo institucional",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 28),

        _inputField(
          controller: emailController,
          hint: "Correo institucional",
          icon: Icons.email_outlined,
        ),

        const SizedBox(height: 16),

        _inputField(
          controller: passwordController,
          hint: "Contraseña",
          icon: Icons.lock_outline,
          obscure: obscurePassword,
          suffix: IconButton(
            icon: Icon(
              obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFF467B79),
            ),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
        ),

        const SizedBox(height: 12),

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
            const Expanded(
              child: Text(
                "Recordar sesión",
                style: TextStyle(fontSize: 14),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "¿Olvidaste tu contraseña?",
                style: TextStyle(
                  color: Color(0xFF467B79),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        _mainButton(
          cargando ? "CARGANDO..." : "INICIAR SESIÓN",
          cargando ? null : iniciarSesion,
        ),

        const SizedBox(height: 26),

        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "o",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),

        const SizedBox(height: 24),

        const Text(
          "Primer ingreso – Validar matrícula",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00695C),
          ),
        ),

        const SizedBox(height: 14),

        _inputField(
          controller: cedulaController,
          hint: "Número de cédula",
          icon: Icons.badge_outlined,
        ),

        const SizedBox(height: 14),

        _secondaryButton(
          "VALIDAR Y ACTIVAR CUENTA",
          cargando ? null : validarCedula,
        ),

        const SizedBox(height: 20),

        if (mensajeExito != null) _message(mensajeExito!, Colors.green),

        if (mensajeError != null) ...[
          if (mensajeExito != null) const SizedBox(height: 8),
          _message(mensajeError!, Colors.red),
        ],
      ],
    );
  }

  Widget _buildLogoLarge() {
    return Row(
      children: [
        Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Image(
              image: AssetImage("assets/logo.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoSmall() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0x143B8D84),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Padding(
        padding: EdgeInsets.all(14),
        child: Image(
          image: AssetImage("assets/logo.png"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF467B79)),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14),
          filled: true,
          fillColor: const Color(0xFFF4F7F6),
          suffixIcon: suffix,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF467B79),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _mainButton(String text, VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF467B79),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }

  Widget _secondaryButton(String text, VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF467B79),
          side: const BorderSide(color: Color(0xFF467B79), width: 1.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onTap,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _message(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}