import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── CARRERAS ──────────────────────────────────────────────────────────────────
const List<String> carreras = [
  'Desarrollo de Software',
  'Enfermería',
  'Gastronomía',
  'Administración de Empresas',
  'Diseño Gráfico',
  'Marketing Digital',
  'Contabilidad',
  'Mecánica Automotriz',
  'Electricidad Industrial',
  'Turismo y Hotelería',
];

// ── PANTALLA ──────────────────────────────────────────────────────────────────
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nombreCtrl = TextEditingController();
  final _apellidoCtrl = TextEditingController();
  final _cedulaCtrl = TextEditingController();
  final _colegioCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _celularCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  String? _carreraSeleccionada;
  bool _showPass = false;
  bool _showConfirmPass = false;
  String _errorMsg = '';

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _cedulaCtrl.dispose();
    _colegioCtrl.dispose();
    _emailCtrl.dispose();
    _celularCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  bool get _passLengthOk => _passCtrl.text.length >= 6;
  bool get _passMatchOk =>
      _passCtrl.text == _confirmPassCtrl.text &&
      _passCtrl.text.isNotEmpty;

  void _handleRegister() {
    setState(() => _errorMsg = '');

    if (!_formKey.currentState!.validate()) return;

    if (_carreraSeleccionada == null) {
      setState(() => _errorMsg = 'Selecciona una carrera de interés');
      return;
    }
    if (_passCtrl.text != _confirmPassCtrl.text) {
      setState(() => _errorMsg = 'Las contraseñas no coinciden');
      return;
    }

    // Simulación de registro exitoso → redirigir al feed invitado
    Navigator.of(context).pushReplacementNamed('/feed-guest');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // ── BOTÓN ATRÁS ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Color(0xFF103B40)),
                  ),
                ),
              ),
            ),

            // ── CONTENIDO SCROLLABLE ───────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        'assets/images/Logo_app.png',
                        width: 96,
                        height: 96,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),

                      // Título
                      const Text(
                        '¡Regístrate como Invitado!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF103B40),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Explora nuestra comunidad educativa',
                        style:
                            TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 16),

                      // Banner promoción
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF2DA679),
                              Color(0xFF0F5944)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xFF2DA679)
                                    .withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4)),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.school_rounded,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text('¡PROMOCIÓN ESPECIAL!',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                    color: Color(0xFF96D9C0),
                                    fontSize: 13),
                                children: [
                                  TextSpan(
                                      text: 'Regístrate ahora y obtén '),
                                  TextSpan(
                                    text: '20% de descuento',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  TextSpan(text: ' al matricularte'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── CARD FORMULARIO ──────────────────────────
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                              color: const Color(0xFF96D9C0)
                                  .withOpacity(0.3),
                              width: 1.5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 16,
                                offset: const Offset(0, 4)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nombre + Apellido
                            Row(
                              children: [
                                Expanded(
                                  child: _buildField(
                                    label: 'Nombre *',
                                    hint: 'Juan',
                                    icon: Icons.person_outline_rounded,
                                    controller: _nombreCtrl,
                                    validator: (v) => v == null || v.isEmpty
                                        ? 'Requerido'
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildField(
                                    label: 'Apellido *',
                                    hint: 'Pérez',
                                    icon: Icons.person_outline_rounded,
                                    controller: _apellidoCtrl,
                                    validator: (v) => v == null || v.isEmpty
                                        ? 'Requerido'
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            // Cédula
                            _buildField(
                              label: 'Cédula de Identidad *',
                              hint: '0999999999',
                              icon: Icons.credit_card_rounded,
                              controller: _cedulaCtrl,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (v) {
                                if (v == null || v.isEmpty)
                                  return 'Requerido';
                                if (v.length < 10)
                                  return 'Mínimo 10 dígitos';
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            // Carrera dropdown
                            _buildDropdownField(),
                            const SizedBox(height: 14),

                            // Colegio
                            _buildField(
                              label: 'Colegio de Procedencia *',
                              hint: 'Ej: Colegio Nacional',
                              icon: Icons.school_outlined,
                              controller: _colegioCtrl,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Requerido'
                                  : null,
                            ),
                            const SizedBox(height: 14),

                            // Email
                            _buildField(
                              label: 'Correo Electrónico *',
                              hint: 'correo@ejemplo.com',
                              icon: Icons.mail_outline_rounded,
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.isEmpty)
                                  return 'Requerido';
                                if (!v.contains('@'))
                                  return 'Email inválido';
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            // Celular
                            _buildField(
                              label: 'Número de Celular *',
                              hint: '0999 999 999',
                              icon: Icons.phone_outlined,
                              controller: _celularCtrl,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (v) {
                                if (v == null || v.isEmpty)
                                  return 'Requerido';
                                if (v.length < 10)
                                  return 'Mínimo 10 dígitos';
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            // Contraseñas
                            Row(
                              children: [
                                Expanded(
                                  child: _buildPasswordField(
                                    label: 'Contraseña *',
                                    hint: 'Mínimo 6 caracteres',
                                    controller: _passCtrl,
                                    show: _showPass,
                                    onToggle: () => setState(
                                        () => _showPass = !_showPass),
                                    validator: (v) {
                                      if (v == null || v.isEmpty)
                                        return 'Requerido';
                                      if (v.length < 6)
                                        return 'Mínimo 6 caracteres';
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildPasswordField(
                                    label: 'Confirmar *',
                                    hint: 'Repite tu contraseña',
                                    controller: _confirmPassCtrl,
                                    show: _showConfirmPass,
                                    onToggle: () => setState(() =>
                                        _showConfirmPass =
                                            !_showConfirmPass),
                                    validator: (v) {
                                      if (v != _passCtrl.text)
                                        return 'No coinciden';
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Indicadores de seguridad
                            _buildPasswordIndicators(),
                            const SizedBox(height: 16),

                            // Error
                            if (_errorMsg.isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                      color: Colors.red[200]!,
                                      width: 1.5),
                                ),
                                child: Text(
                                  _errorMsg,
                                  style: TextStyle(
                                      color: Colors.red[700],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),

                            if (_errorMsg.isNotEmpty)
                              const SizedBox(height: 16),

                            // Botón registrar
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF2DA679),
                                      Color(0xFF0F5944)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF2DA679)
                                          .withOpacity(0.4),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: _handleRegister,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                  ),
                                  child: const Text(
                                    'REGISTRARME COMO INVITADO',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Info descuento
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF96D9C0)
                                        .withOpacity(0.2),
                                    const Color(0xFF2DA679)
                                        .withOpacity(0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      height: 1.5),
                                  children: [
                                    TextSpan(
                                        text:
                                            'Al registrarte como invitado podrás explorar nuestra comunidad educativa, ver publicaciones institucionales y conocer todas nuestras carreras. '),
                                    TextSpan(
                                      text:
                                          '¡No olvides tu 20% de descuento!',
                                      style: TextStyle(
                                          color: Color(0xFF0F5944),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ¿Ya eres estudiante?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('¿Ya eres estudiante? ',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14)),
                          GestureDetector(
                            onTap: () =>
                                Navigator.of(context).pushNamed('/login'),
                            child: const Text(
                              'Inicia sesión aquí',
                              style: TextStyle(
                                  color: Color(0xFF2DA679),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── CAMPO TEXTO ────────────────────────────────────────────────────────────
  Widget _buildField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Color(0xFF103B40),
                fontWeight: FontWeight.w600,
                fontSize: 12)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: (_) => setState(() => _errorMsg = ''),
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            prefixIcon: Icon(icon, color: Colors.grey, size: 20),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFFE0E0E0), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFFE0E0E0), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFF2DA679), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  // ── CAMPO CONTRASEÑA ───────────────────────────────────────────────────────
  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool show,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Color(0xFF103B40),
                fontWeight: FontWeight.w600,
                fontSize: 12)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: !show,
          onChanged: (_) => setState(() {}),
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            prefixIcon: const Icon(Icons.lock_outline_rounded,
                color: Colors.grey, size: 20),
            suffixIcon: GestureDetector(
              onTap: onToggle,
              child: Icon(
                show
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
                size: 20,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFFE0E0E0), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFFE0E0E0), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFF2DA679), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  // ── DROPDOWN CARRERA ───────────────────────────────────────────────────────
  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Carrera de Interés *',
            style: TextStyle(
                color: Color(0xFF103B40),
                fontWeight: FontWeight.w600,
                fontSize: 12)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: _carreraSeleccionada,
          hint: const Text('Selecciona una carrera',
              style: TextStyle(color: Colors.grey, fontSize: 13)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Colors.grey),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.school_rounded,
                color: Colors.grey, size: 20),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFFE0E0E0), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFFE0E0E0), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFF2DA679), width: 2),
            ),
          ),
          items: carreras
              .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c,
                        style: const TextStyle(
                            color: Color(0xFF103B40), fontSize: 13)),
                  ))
              .toList(),
          onChanged: (v) =>
              setState(() => _carreraSeleccionada = v),
        ),
      ],
    );
  }

  // ── INDICADORES CONTRASEÑA ─────────────────────────────────────────────────
  Widget _buildPasswordIndicators() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Requisitos de contraseña:',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          _PasswordCheck(
            ok: _passLengthOk,
            label: 'Al menos 6 caracteres',
          ),
          const SizedBox(height: 4),
          _PasswordCheck(
            ok: _passMatchOk,
            label: 'Las contraseñas coinciden',
          ),
        ],
      ),
    );
  }
}

// ── PASSWORD CHECK ────────────────────────────────────────────────────────────
class _PasswordCheck extends StatelessWidget {
  final bool ok;
  final String label;
  const _PasswordCheck({required this.ok, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ok
                ? const Color(0xFF2DA679)
                : Colors.grey[300],
          ),
          child: ok
              ? const Icon(Icons.check_rounded,
                  color: Colors.white, size: 12)
              : null,
        ),
        const SizedBox(width: 8),
        Text(label,
            style: TextStyle(
                color: ok ? const Color(0xFF2DA679) : Colors.grey,
                fontSize: 12,
                fontWeight:
                    ok ? FontWeight.w600 : FontWeight.normal)),
      ],
    );
  }
}