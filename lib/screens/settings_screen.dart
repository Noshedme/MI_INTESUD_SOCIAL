import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                // ── CUENTA Y PERFIL ──────────────────────────────
                _SettingsSection(
                  title: 'Cuenta y Perfil',
                  icon: Icons.person_rounded,
                  headerColors: const [Color(0xFF103B40), Color(0xFF0F5944)],
                  items: [
                    _SettingsItem(
                      icon: Icons.person_outline_rounded,
                      iconColors: const [Color(0xFF96D9C0), Color(0xFF2DA679)],
                      title: 'Editar Perfil',
                      subtitle: 'Actualiza tu información personal',
                      onTap: () =>
                          Navigator.of(context).pushNamed('/profile'),
                    ),
                    _SettingsItem(
                      icon: Icons.lock_outline_rounded,
                      iconColors: const [Color(0xFF2DA679), Color(0xFF0F5944)],
                      title: 'Cambiar Contraseña',
                      subtitle: 'Actualiza tu contraseña de acceso',
                      onTap: () => Navigator.of(context)
                          .pushNamed('/change-password'),
                    ),
                    _SettingsItem(
                      icon: Icons.shield_outlined,
                      iconColors: const [Color(0xFF0F5944), Color(0xFF103B40)],
                      title: 'Privacidad y Seguridad',
                      subtitle: 'Controla quién ve tu información',
                      onTap: () {},
                      isLast: true,
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ── NOTIFICACIONES ───────────────────────────────
                _SettingsSection(
                  title: 'Notificaciones',
                  icon: Icons.notifications_rounded,
                  headerColors: const [Color(0xFF2DA679), Color(0xFF0F5944)],
                  items: [
                    _SettingsItem(
                      icon: Icons.notifications_outlined,
                      iconColors: const [Color(0xFF96D9C0), Color(0xFF2DA679)],
                      title: 'Preferencias de Notificaciones',
                      subtitle: 'Gestiona qué notificaciones recibir',
                      onTap: () {},
                      isLast: true,
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ── APARIENCIA ───────────────────────────────────
                _SettingsSection(
                  title: 'Apariencia',
                  icon: Icons.palette_rounded,
                  headerColors: const [Color(0xFF0F5944), Color(0xFF103B40)],
                  items: [
                    _SettingsItem(
                      icon: Icons.palette_outlined,
                      iconColors: const [Color(0xFF2DA679), Color(0xFF0F5944)],
                      title: 'Tema de la Aplicación',
                      subtitle: 'Claro, oscuro o automático',
                      onTap: () => _showThemeDialog(context),
                    ),
                    _SettingsItem(
                      icon: Icons.language_rounded,
                      iconColors: const [Color(0xFF103B40), Color(0xFF0F5944)],
                      title: 'Idioma',
                      subtitle: 'Español (predeterminado)',
                      onTap: () {},
                      isLast: true,
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ── AYUDA ────────────────────────────────────────
                _SettingsSection(
                  title: 'Ayuda y Soporte',
                  icon: Icons.help_outline_rounded,
                  headerColors: const [Color(0xFF96D9C0), Color(0xFF2DA679)],
                  headerTextColor: const Color(0xFF103B40),
                  items: [
                    _SettingsItem(
                      icon: Icons.help_outline_rounded,
                      iconColors: const [Color(0xFF96D9C0), Color(0xFF2DA679)],
                      title: 'Centro de Ayuda',
                      subtitle: 'Preguntas frecuentes y tutoriales',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      icon: Icons.description_outlined,
                      iconColors: const [Color(0xFF2DA679), Color(0xFF0F5944)],
                      title: 'Términos y Condiciones',
                      subtitle: 'Lee nuestras políticas',
                      onTap: () {},
                      isLast: true,
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ── ZONA DE PELIGRO ──────────────────────────────
                _SettingsSection(
                  title: 'Zona de Peligro',
                  icon: Icons.delete_rounded,
                  headerColors: const [Color(0xFFEF4444), Color(0xFFDC2626)],
                  borderColor: Colors.red[200],
                  items: [
                    _SettingsItem(
                      icon: Icons.delete_outline_rounded,
                      iconColors: const [Color(0xFFFFEBEE), Color(0xFFFFEBEE)],
                      iconColor: Colors.red,
                      title: 'Eliminar Cuenta',
                      subtitle: 'Esta acción es permanente',
                      titleColor: Colors.red,
                      arrowColor: Colors.red,
                      hoverColor: Colors.red[50],
                      onTap: () => _showDeleteDialog(context),
                      isLast: true,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ── BOTÓN CERRAR SESIÓN ──────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () => _handleLogout(context),
                      icon: const Icon(Icons.logout_rounded,
                          color: Colors.white, size: 20),
                      label: const Text(
                        'Cerrar Sesión',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ── APP INFO ─────────────────────────────────────
                const Column(
                  children: [
                    Text('MI INTESUD SOCIAL',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    SizedBox(height: 2),
                    Text('Versión 1.0.0',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    SizedBox(height: 4),
                    Text(
                      '© 2026 • 4 Semestre • Escuela Desarrollo de Software',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── HEADER ────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
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
                    border:
                        Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: const Icon(Icons.arrow_back_rounded,
                      color: Colors.white, size: 22),
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Configuración',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text('Personaliza tu experiencia',
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

  // ── DIÁLOGO TEMA ──────────────────────────────────────────────────────────
  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Tema de la Aplicación',
            style: TextStyle(
                color: Color(0xFF103B40), fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ThemeOption(
                icon: Icons.light_mode_rounded,
                label: 'Claro',
                onTap: () => Navigator.pop(context)),
            _ThemeOption(
                icon: Icons.dark_mode_rounded,
                label: 'Oscuro',
                onTap: () => Navigator.pop(context)),
            _ThemeOption(
                icon: Icons.brightness_auto_rounded,
                label: 'Automático',
                onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  // ── DIÁLOGO ELIMINAR CUENTA ───────────────────────────────────────────────
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.red, size: 24),
            SizedBox(width: 8),
            Text('Eliminar Cuenta',
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          '¿Estás seguro de que deseas eliminar tu cuenta? Esta acción es permanente y no se puede deshacer.',
          style: TextStyle(color: Colors.grey, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar',
                style: TextStyle(
                    color: Color(0xFF103B40),
                    fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('/welcome');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Eliminar',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ── LOGOUT ────────────────────────────────────────────────────────────────
  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Cerrar Sesión',
            style: TextStyle(
                color: Color(0xFF103B40), fontWeight: FontWeight.bold)),
        content: const Text(
          '¿Estás seguro de que deseas cerrar sesión?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar',
                style: TextStyle(
                    color: Color(0xFF103B40),
                    fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .pushReplacementNamed('/welcome');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Cerrar Sesión',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ── SECCIÓN ───────────────────────────────────────────────────────────────────
class _SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> headerColors;
  final Color? headerTextColor;
  final Color? borderColor;
  final List<_SettingsItem> items;

  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.headerColors,
    required this.items,
    this.headerTextColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: borderColor ??
              const Color(0xFF96D9C0).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          // Header de sección
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: headerColors),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22)),
            ),
            child: Row(
              children: [
                Icon(icon,
                    color: headerTextColor ?? Colors.white,
                    size: 20),
                const SizedBox(width: 10),
                Text(title,
                    style: TextStyle(
                        color: headerTextColor ?? Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ],
            ),
          ),
          // Items
          ...items,
        ],
      ),
    );
  }
}

// ── ITEM ──────────────────────────────────────────────────────────────────────
class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final List<Color> iconColors;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final Color? titleColor;
  final Color? arrowColor;
  final Color? hoverColor;
  final VoidCallback onTap;
  final bool isLast;

  const _SettingsItem({
    required this.icon,
    required this.iconColors,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
    this.titleColor,
    this.arrowColor,
    this.hoverColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: isLast
                ? const BorderRadius.vertical(
                    bottom: Radius.circular(22))
                : BorderRadius.zero,
            splashColor:
                (hoverColor ?? const Color(0xFF96D9C0)).withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Ícono
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: iconColors),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon,
                        color: iconColor ?? Colors.white,
                        size: 22),
                  ),
                  const SizedBox(width: 14),
                  // Texto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: TextStyle(
                                color: titleColor ??
                                    const Color(0xFF103B40),
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                        const SizedBox(height: 2),
                        Text(subtitle,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12)),
                      ],
                    ),
                  ),
                  // Flecha
                  Icon(Icons.chevron_right_rounded,
                      color: arrowColor ??
                          Colors.grey[400],
                      size: 22),
                ],
              ),
            ),
          ),
        ),
        if (!isLast)
          const Divider(
              height: 1,
              indent: 78,
              endIndent: 16,
              color: Color(0xFFF0F0F0)),
      ],
    );
  }
}

// ── THEME OPTION ──────────────────────────────────────────────────────────────
class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ThemeOption(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF96D9C0).withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color(0xFF2DA679), size: 20),
      ),
      title: Text(label,
          style: const TextStyle(
              color: Color(0xFF103B40), fontWeight: FontWeight.w500)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}