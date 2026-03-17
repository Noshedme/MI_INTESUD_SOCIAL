import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700))
      ..forward();
    _fadeAnim =
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // ── SLIVER HEADER ──────────────────────────────────
              SliverToBoxAdapter(child: _buildProfileHeader()),

              // ── CONTENIDO ──────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: SlideTransition(
                        position: _slideAnim,
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            _buildInfoCard(),
                            const SizedBox(height: 16),
                            _buildAcademicCard(),
                            const SizedBox(height: 16),
                            _buildBioCard(),
                            const SizedBox(height: 16),
                            _buildActivityCard(),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── PROFILE HEADER ────────────────────────────────────────────────────────
  Widget _buildProfileHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF103B40), Color(0xFF0F5944), Color(0xFF2DA679)],
        ),
      ),
      child: Stack(
        children: [
          // Círculos decorativos
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF96D9C0).withOpacity(0.12),
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              child: Column(
                children: [
                  // Top bar
                  Row(
                    children: [
                      _GlassBtn(
                        icon: Icons.arrow_back_rounded,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      const Spacer(),
                      const Text(
                        'Mi Perfil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      _GlassBtn(
                        icon: Icons.settings_rounded,
                        onTap: () =>
                            Navigator.of(context).pushNamed('/settings'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Avatar
                  Stack(
                    children: [
                      // Glow
                      Container(
                        width: 136,
                        height: 136,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1638953052562-21e347a142bf?w=300'),
                          backgroundColor: Color(0xFF96D9C0),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2DA679),
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.camera_alt_rounded,
                              color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Nombre
                  const Text(
                    'María López',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Estudiante de Gastronomía',
                    style: TextStyle(
                        color: Color(0xFF96D9C0), fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '@marialopez',
                    style: TextStyle(
                        color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 24),

                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _StatItem(value: '156', label: 'Publicaciones'),
                      _VertDivider(),
                      _StatItem(value: '892', label: 'Seguidores'),
                      _VertDivider(),
                      _StatItem(value: '234', label: 'Siguiendo'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Botones acción
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/edit-profile'),
                          icon: const Icon(Icons.edit_rounded, size: 18),
                          label: const Text('Editar Perfil'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF103B40),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            elevation: 4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share_rounded, size: 18),
                          label: const Text('Compartir'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: BorderSide(
                                color: Colors.white.withOpacity(0.4),
                                width: 1.5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── TARJETA INFORMACIÓN ────────────────────────────────────────────────────
  Widget _buildInfoCard() {
    return _SectionCard(
      title: 'Información Personal',
      icon: Icons.person_rounded,
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.mail_outline_rounded,
            label: 'Email',
            value: 'maria.lopez@intesud.edu',
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.phone_outlined,
            label: 'Teléfono',
            value: '+593 99 123 4567',
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Ubicación',
            value: 'Quito, Ecuador',
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Miembro desde',
            value: 'Enero 2024',
          ),
        ],
      ),
    );
  }

  // ── TARJETA ACADÉMICA ──────────────────────────────────────────────────────
  Widget _buildAcademicCard() {
    return _SectionCard(
      title: 'Información Académica',
      icon: Icons.menu_book_rounded,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF103B40), Color(0xFF0F5944)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.workspace_premium_rounded,
                      color: Colors.white, size: 32),
                  SizedBox(height: 10),
                  Text('3',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  Text('Certificados',
                      style: TextStyle(
                          color: Color(0xFF96D9C0), fontSize: 12)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2DA679), Color(0xFF0F5944)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.groups_rounded,
                      color: Colors.white, size: 32),
                  SizedBox(height: 10),
                  Text('12',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  Text('Grupos',
                      style: TextStyle(
                          color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── BIO ────────────────────────────────────────────────────────────────────
  Widget _buildBioCard() {
    return _SectionCard(
      title: 'Sobre mí',
      icon: Icons.info_outline_rounded,
      child: const Text(
        'Apasionada por la tecnología y el desarrollo de software. Me encanta aprender nuevas tecnologías y compartir conocimientos con la comunidad universitaria. Actualmente enfocada en desarrollo web y machine learning.',
        style: TextStyle(
            color: Colors.grey, fontSize: 14, height: 1.6),
      ),
    );
  }

  // ── ACTIVIDAD RECIENTE ─────────────────────────────────────────────────────
  Widget _buildActivityCard() {
    final activities = [
      _Activity('Comentó en "Conferencia de IA"', 'Hace 2h'),
      _Activity('Publicó una nueva foto', 'Hace 5h'),
      _Activity('Se unió a un nuevo grupo', 'Ayer'),
    ];

    return _SectionCard(
      title: 'Actividad Reciente',
      icon: Icons.bolt_rounded,
      action: GestureDetector(
        onTap: () {},
        child: const Text('Ver todo',
            style: TextStyle(
                color: Color(0xFF2DA679),
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      ),
      child: Column(
        children: activities
            .map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2DA679),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(a.text,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13)),
                        ),
                        Text(a.time,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  // ── BOTTOM NAV ────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(color: Color(0xFFE8F5F0), width: 2)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBtn(
                  icon: Icons.home_rounded,
                  label: 'Inicio',
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed('/feed')),
              _NavBtn(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: 'Mensajes',
                  onTap: () =>
                      Navigator.of(context).pushNamed('/messages')),
              _NavBtn(
                  icon: Icons.calendar_month_outlined,
                  label: 'Eventos',
                  onTap: () =>
                      Navigator.of(context).pushNamed('/events')),
              _NavBtn(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Tienda',
                  onTap: () =>
                      Navigator.of(context).pushNamed('/store')),
              _NavBtn(
                icon: Icons.person_rounded,
                label: 'Perfil',
                isActive: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── WIDGETS AUXILIARES ────────────────────────────────────────────────────────

class _GlassBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _GlassBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  color: Color(0xFF96D9C0), fontSize: 12)),
        ],
      ),
    );
  }
}

class _VertDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.5,
      height: 40,
      color: Colors.white.withOpacity(0.25),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Widget? action;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: const Color(0xFF96D9C0).withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF2DA679), size: 20),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      color: Color(0xFF103B40),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              if (action != null) ...[
                const Spacer(),
                action!,
              ],
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2DA679), Color(0xFF0F5944)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w500)),
              Text(value,
                  style: const TextStyle(
                      color: Color(0xFF103B40),
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Activity {
  final String text;
  final String time;
  const _Activity(this.text, this.time);
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isActive)
            Container(
              width: 32,
              height: 3,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2DA679),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF2DA679).withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon,
                color: isActive
                    ? const Color(0xFF2DA679)
                    : Colors.grey[500],
                size: 24),
          ),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight:
                      isActive ? FontWeight.w700 : FontWeight.normal,
                  color: isActive
                      ? const Color(0xFF2DA679)
                      : Colors.grey[500])),
        ],
      ),
    );
  }
}