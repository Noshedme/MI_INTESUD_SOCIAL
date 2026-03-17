import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _currentPassCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;
  bool _isSaving = false;

  // Requisitos de contraseña
  bool get _hasMinLength => _newPassCtrl.text.length >= 6;
  bool get _hasUppercase =>
      _newPassCtrl.text.contains(RegExp(r'[A-Z]'));
  bool get _hasNumber =>
      _newPassCtrl.text.contains(RegExp(r'[0-9]'));
  bool get _passwordsMatch =>
      _newPassCtrl.text == _confirmPassCtrl.text &&
      _newPassCtrl.text.isNotEmpty;

  bool get _allRequirementsMet =>
      _hasMinLength && _passwordsMatch && _currentPassCtrl.text.isNotEmpty;

  // Nivel de seguridad
  int get _strengthLevel {
    int level = 0;
    if (_hasMinLength) level++;
    if (_hasUppercase) level++;
    if (_hasNumber) level++;
    if (_newPassCtrl.text.contains(RegExp(r'[!@#\$%^&*]'))) level++;
    return level;
  }

  String get _strengthLabel {
    switch (_strengthLevel) {
      case 0:
      case 1:
        return 'Débil';
      case 2:
        return 'Regular';
      case 3:
        return 'Buena';
      case 4:
        return 'Muy segura';
      default:
        return '';
    }
  }

  Color get _strengthColor {
    switch (_strengthLevel) {
      case 0:
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return const Color(0xFF2DA679);
      case 4:
        return const Color(0xFF0F5944);
      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    _newPassCtrl.addListener(() => setState(() {}));
    _confirmPassCtrl.addListener(() => setState(() {}));
    _currentPassCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _currentPassCtrl.dispose();
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;

    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text('Contraseña actualizada correctamente',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        backgroundColor: const Color(0xFF2DA679),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // ── ÍCONO DECORATIVO ──────────────────────────
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF2DA679),
                            Color(0xFF0F5944),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2DA679).withOpacity(0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.lock_reset_rounded,
                          color: Colors.white, size: 38),
                    ),
                    const SizedBox(height: 14),
                    const Text('Cambiar Contraseña',
                        style: TextStyle(
                            color: Color(0xFF103B40),
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    const SizedBox(height: 4),
                    const Text(
                      'Crea una contraseña segura para proteger tu cuenta',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 24),

                    // ── CONTRASEÑA ACTUAL ────────────────────────
                    _buildCard(
                      title: 'Contraseña Actual',
                      icon: Icons.lock_outline_rounded,
                      child: _buildPasswordField(
                        label: 'Contraseña actual',
                        hint: 'Ingresa tu contraseña actual',
                        controller: _currentPassCtrl,
                        show: _showCurrent,
                        onToggle: () =>
                            setState(() => _showCurrent = !_showCurrent),
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return 'Ingresa tu contraseña actual';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── NUEVA CONTRASEÑA ─────────────────────────
                    _buildCard(
                      title: 'Nueva Contraseña',
                      icon: Icons.lock_rounded,
                      child: Column(
                        children: [
                          _buildPasswordField(
                            label: 'Nueva contraseña',
                            hint: 'Mínimo 6 caracteres',
                            controller: _newPassCtrl,
                            show: _showNew,
                            onToggle: () =>
                                setState(() => _showNew = !_showNew),
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return 'Ingresa una nueva contraseña';
                              if (v.length < 6)
                                return 'Mínimo 6 caracteres';
                              if (v == _currentPassCtrl.text)
                                return 'Debe ser diferente a la actual';
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          _buildPasswordField(
                            label: 'Confirmar contraseña',
                            hint: 'Repite la nueva contraseña',
                            controller: _confirmPassCtrl,
                            show: _showConfirm,
                            onToggle: () =>
                                setState(() => _showConfirm = !_showConfirm),
                            validator: (v) {
                              if (v != _newPassCtrl.text)
                                return 'Las contraseñas no coinciden';
                              return null;
                            },
                          ),

                          // Barra de seguridad
                          if (_newPassCtrl.text.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            _buildStrengthBar(),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── REQUISITOS ────────────────────────────────
                    _buildCard(
                      title: 'Requisitos',
                      icon: Icons.checklist_rounded,
                      child: Column(
                        children: [
                          _Requirement(
                            ok: _hasMinLength,
                            label: 'Al menos 6 caracteres',
                          ),
                          const SizedBox(height: 8),
                          _Requirement(
                            ok: _hasUppercase,
                            label: 'Al menos una mayúscula',
                          ),
                          const SizedBox(height: 8),
                          _Requirement(
                            ok: _hasNumber,
                            label: 'Al menos un número',
                          ),
                          const SizedBox(height: 8),
                          _Requirement(
                            ok: _passwordsMatch,
                            label: 'Las contraseñas coinciden',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── BOTÓN GUARDAR ─────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _allRequirementsMet
                                ? [
                                    const Color(0xFF2DA679),
                                    const Color(0xFF0F5944)
                                  ]
                                : [
                                    Colors.grey[400]!,
                                    Colors.grey[500]!
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: _allRequirementsMet
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF2DA679)
                                        .withOpacity(0.4),
                                    blurRadius: 14,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : [],
                        ),
                        child: ElevatedButton(
                          onPressed: _allRequirementsMet && !_isSaving
                              ? _handleSave
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          child: _isSaving
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'ACTUALIZAR CONTRASEÑA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── NOTA DE SEGURIDAD ─────────────────────────
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF103B40).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: const Color(0xFF103B40).withOpacity(0.1)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline_rounded,
                              color: Color(0xFF103B40), size: 18),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Por seguridad, se cerrará tu sesión en otros dispositivos al cambiar la contraseña.',
                              style: TextStyle(
                                  color: Color(0xFF103B40),
                                  fontSize: 12,
                                  height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── HEADER ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF103B40), Color(0xFF0F5944), Color(0xFF2DA679)],
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black26, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.2)),
                  ),
                  child: const Icon(Icons.arrow_back_rounded,
                      color: Colors.white, size: 22),
                ),
              ),
              const SizedBox(width: 14),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cambiar Contraseña',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text('Mantén tu cuenta segura',
                      style: TextStyle(
                          color: Color(0xFF96D9C0), fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── CARD SECCIÓN ──────────────────────────────────────────────────────────
  Widget _buildCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: const Color(0xFF96D9C0).withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF2DA679), Color(0xFF0F5944)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 17),
              ),
              const SizedBox(width: 10),
              Text(title,
                  style: const TextStyle(
                      color: Color(0xFF103B40),
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  // ── CAMPO CONTRASEÑA ──────────────────────────────────────────────────────
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
            fillColor: const Color(0xFFF8F8F8),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFF2DA679), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
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

  // ── BARRA SEGURIDAD ───────────────────────────────────────────────────────
  Widget _buildStrengthBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Seguridad:',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text(
              _strengthLabel,
              style: TextStyle(
                  color: _strengthColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: List.generate(4, (i) {
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 6,
                margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                decoration: BoxDecoration(
                  color: i < _strengthLevel
                      ? _strengthColor
                      : const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ── REQUIREMENT WIDGET ────────────────────────────────────────────────────────
class _Requirement extends StatelessWidget {
  final bool ok;
  final String label;
  const _Requirement({required this.ok, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ok ? const Color(0xFF2DA679) : const Color(0xFFEEEEEE),
          ),
          child: ok
              ? const Icon(Icons.check_rounded,
                  color: Colors.white, size: 14)
              : const Icon(Icons.close_rounded,
                  color: Colors.grey, size: 14),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: ok ? const Color(0xFF2DA679) : Colors.grey,
            fontSize: 13,
            fontWeight: ok ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}