import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores
  final _nombreCtrl = TextEditingController(text: 'María');
  final _apellidoCtrl = TextEditingController(text: 'López');
  final _usernameCtrl = TextEditingController(text: 'marialopez');
  final _bioCtrl = TextEditingController(
      text:
          'Apasionada por la tecnología y el desarrollo de software. Me encanta aprender nuevas tecnologías y compartir conocimientos con la comunidad universitaria.');
  final _emailCtrl =
      TextEditingController(text: 'maria.lopez@intesud.edu');
  final _celularCtrl = TextEditingController(text: '0991234567');
  final _ubicacionCtrl = TextEditingController(text: 'Quito, Ecuador');

  String _carreraSeleccionada = 'Gastronomía';
  bool _isSaving = false;
  bool _hasChanges = false;

  final List<String> _carreras = [
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

  @override
  void initState() {
    super.initState();
    // Detectar cambios en cualquier campo
    for (final ctrl in [
      _nombreCtrl,
      _apellidoCtrl,
      _usernameCtrl,
      _bioCtrl,
      _emailCtrl,
      _celularCtrl,
      _ubicacionCtrl,
    ]) {
      ctrl.addListener(() => setState(() => _hasChanges = true));
    }
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _usernameCtrl.dispose();
    _bioCtrl.dispose();
    _emailCtrl.dispose();
    _celularCtrl.dispose();
    _ubicacionCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    // Simular guardado
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;
    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text('Perfil actualizado correctamente',
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

    setState(() => _hasChanges = false);
    Navigator.of(context).pop();
  }

  void _handleDiscard() {
    if (!_hasChanges) {
      Navigator.of(context).pop();
      return;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('¿Descartar cambios?',
            style: TextStyle(
                color: Color(0xFF103B40), fontWeight: FontWeight.bold)),
        content: const Text(
          'Tienes cambios sin guardar. ¿Estás seguro de que quieres salir?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Seguir editando',
                style: TextStyle(
                    color: Color(0xFF2DA679),
                    fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Descartar',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
                child: Column(
                  children: [
                    // Foto de perfil
                    _buildAvatarSection(),
                    const SizedBox(height: 20),

                    // Info personal
                    _buildSection(
                      title: 'Información Personal',
                      icon: Icons.person_rounded,
                      children: [
                        // Nombre + Apellido
                        Row(
                          children: [
                            Expanded(
                              child: _buildField(
                                label: 'Nombre',
                                controller: _nombreCtrl,
                                icon: Icons.person_outline_rounded,
                                validator: (v) => v == null || v.isEmpty
                                    ? 'Requerido'
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildField(
                                label: 'Apellido',
                                controller: _apellidoCtrl,
                                icon: Icons.person_outline_rounded,
                                validator: (v) => v == null || v.isEmpty
                                    ? 'Requerido'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Username
                        _buildField(
                          label: 'Nombre de usuario',
                          controller: _usernameCtrl,
                          icon: Icons.alternate_email_rounded,
                          prefix: '@',
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Requerido';
                            if (v.contains(' '))
                              return 'Sin espacios';
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // Bio
                        _buildField(
                          label: 'Sobre mí',
                          controller: _bioCtrl,
                          icon: Icons.edit_note_rounded,
                          maxLines: 4,
                          hint: 'Cuéntanos algo sobre ti...',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Info de contacto
                    _buildSection(
                      title: 'Información de Contacto',
                      icon: Icons.contact_mail_rounded,
                      children: [
                        _buildField(
                          label: 'Correo Electrónico',
                          controller: _emailCtrl,
                          icon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Requerido';
                            if (!v.contains('@')) return 'Email inválido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        _buildField(
                          label: 'Número de Celular',
                          controller: _celularCtrl,
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 14),
                        _buildField(
                          label: 'Ubicación',
                          controller: _ubicacionCtrl,
                          icon: Icons.location_on_outlined,
                          hint: 'Ciudad, País',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Info académica
                    _buildSection(
                      title: 'Información Académica',
                      icon: Icons.school_rounded,
                      children: [
                        _buildDropdown(),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Botón guardar
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _hasChanges
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
                          boxShadow: _hasChanges
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
                          onPressed:
                              _hasChanges && !_isSaving ? _handleSave : null,
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
                                  'GUARDAR CAMBIOS',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 0.5),
                                ),
                        ),
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
                onTap: _handleDiscard,
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
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Editar Perfil',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text('Actualiza tu información',
                        style: TextStyle(
                            color: Color(0xFF96D9C0), fontSize: 12)),
                  ],
                ),
              ),
              // Indicador de cambios pendientes
              if (_hasChanges)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.orange.withOpacity(0.4)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.edit_rounded,
                          color: Colors.orange, size: 14),
                      SizedBox(width: 4),
                      Text('Sin guardar',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ── AVATAR ────────────────────────────────────────────────────────────────
  Widget _buildAvatarSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF2DA679),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2DA679).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 58,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1638953052562-21e347a142bf?w=300'),
                backgroundColor: Color(0xFF96D9C0),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => _showPhotoOptions(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2DA679), Color(0xFF0F5944)],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2)),
                    ],
                  ),
                  child: const Icon(Icons.camera_alt_rounded,
                      color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Cambiar foto de perfil',
                style: TextStyle(
                    color: Color(0xFF103B40),
                    fontWeight: FontWeight.bold,
                    fontSize: 17)),
            const SizedBox(height: 16),
            _PhotoOption(
              icon: Icons.camera_alt_rounded,
              label: 'Tomar una foto',
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 10),
            _PhotoOption(
              icon: Icons.photo_library_rounded,
              label: 'Elegir de la galería',
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 10),
            _PhotoOption(
              icon: Icons.delete_outline_rounded,
              label: 'Eliminar foto actual',
              color: Colors.red,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ── SECCIÓN ───────────────────────────────────────────────────────────────
  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
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
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2DA679), Color(0xFF0F5944)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Text(title,
                  style: const TextStyle(
                      color: Color(0xFF103B40),
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  // ── CAMPO ─────────────────────────────────────────────────────────────────
  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
    String? prefix,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
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
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint ?? label,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            prefixIcon: maxLines == 1
                ? Icon(icon, color: Colors.grey, size: 20)
                : Padding(
                    padding: const EdgeInsets.only(left: 12, top: 12),
                    child: Icon(icon, color: Colors.grey, size: 20),
                  ),
            prefixText: prefix,
            prefixStyle: const TextStyle(
                color: Color(0xFF103B40), fontWeight: FontWeight.w600),
            filled: true,
            fillColor: const Color(0xFFF8F8F8),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
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

  // ── DROPDOWN ──────────────────────────────────────────────────────────────
  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Carrera',
            style: TextStyle(
                color: Color(0xFF103B40),
                fontWeight: FontWeight.w600,
                fontSize: 12)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: _carreraSeleccionada,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Colors.grey),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.school_rounded,
                color: Colors.grey, size: 20),
            filled: true,
            fillColor: const Color(0xFFF8F8F8),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          ),
          items: _carreras
              .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c,
                        style: const TextStyle(
                            color: Color(0xFF103B40), fontSize: 13)),
                  ))
              .toList(),
          onChanged: (v) => setState(() {
            _carreraSeleccionada = v!;
            _hasChanges = true;
          }),
        ),
      ],
    );
  }
}

// ── PHOTO OPTION ──────────────────────────────────────────────────────────────
class _PhotoOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _PhotoOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = const Color(0xFF2DA679),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Text(label,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
            const Spacer(),
            Icon(Icons.chevron_right_rounded, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}