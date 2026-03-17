import 'package:flutter/material.dart';

// ── MODELO DE POST ────────────────────────────────────────────────────────────
class Post {
  final int id;
  final String authorName;
  final String authorAvatar;
  final String authorRole;
  final bool isInstitutional;
  final String content;
  final String timestamp;
  final int likes;
  final int comments;
  final String? image;
  final bool isBlocked;

  const Post({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.authorRole,
    required this.isInstitutional,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.comments,
    this.image,
    this.isBlocked = false,
  });
}

// ── DATOS MOCK ────────────────────────────────────────────────────────────────
const List<Post> mockPosts = [
  Post(
    id: 1,
    authorName: 'INTESUD Oficial',
    authorAvatar: 'https://images.unsplash.com/photo-1560179707-f14e90ef3623?w=100',
    authorRole: 'Cuenta Institucional',
    isInstitutional: true,
    content: '🎓 ¡MATRÍCULA ABIERTA 2026! Aprovecha nuestro 20% de descuento en todas las carreras. Forma parte de la mejor institución educativa del sur. ¡No te quedes sin tu cupo!',
    timestamp: 'Hace 1 hora',
    likes: 342,
    comments: 89,
    image: 'assets/images/anuncio.jpg',
  ),
  Post(
    id: 2,
    authorName: 'Marketing INTESUD',
    authorAvatar: 'https://images.unsplash.com/photo-1557804506-669a67965ba0?w=100',
    authorRole: 'Departamento de Marketing',
    isInstitutional: true,
    content: '📢 ¿Sabías que el 95% de nuestros graduados consigue empleo en menos de 6 meses? Conoce historias de éxito de nuestros ex-alumnos y descubre por qué INTESUD es tu mejor opción.',
    timestamp: 'Hace 3 horas',
    likes: 215,
    comments: 45,
  ),
  Post(
    id: 3,
    authorName: 'Desarrollo de Software',
    authorAvatar: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=100',
    authorRole: 'Carrera de Desarrollo de Software',
    isInstitutional: true,
    content: '💻 Aprende las tecnologías más demandadas del mercado: React, Node.js, Python, y más. Nuestros laboratorios cuentan con equipamiento de última generación. ¡Ven a visitarnos!',
    timestamp: 'Hace 5 horas',
    likes: 189,
    comments: 34,
    image: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
  ),
  Post(
    id: 4,
    authorName: 'Enfermería INTESUD',
    authorAvatar: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=100',
    authorRole: 'Carrera de Enfermería',
    isInstitutional: true,
    content: '👨‍⚕️ La carrera de Enfermería te prepara con práctica real en hospitales y clínicas desde el primer semestre. Convenios con las mejores instituciones de salud del país.',
    timestamp: 'Hace 7 horas',
    likes: 167,
    comments: 28,
  ),
  Post(
    id: 5,
    authorName: 'María González',
    authorAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
    authorRole: 'Estudiante de 4to Semestre',
    isInstitutional: false,
    content: 'Hoy tuvimos un proyecto increíble en el laboratorio... [CONTENIDO BLOQUEADO]',
    timestamp: 'Hace 2 horas',
    likes: 0,
    comments: 0,
    isBlocked: true,
  ),
  Post(
    id: 6,
    authorName: 'Gastronomía INTESUD',
    authorAvatar: 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=100',
    authorRole: 'Carrera de Gastronomía',
    isInstitutional: true,
    content: '🍳 Nuestros estudiantes aprenden de chefs reconocidos internacionalmente. Cocinas profesionales, ingredientes premium y pasantías en los mejores restaurantes.',
    timestamp: 'Hace 9 horas',
    likes: 203,
    comments: 52,
  ),
  Post(
    id: 7,
    authorName: 'Carlos Méndez',
    authorAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
    authorRole: 'Estudiante de 2do Semestre',
    isInstitutional: false,
    content: 'La vida universitaria es increíble... [CONTENIDO BLOQUEADO]',
    timestamp: 'Hace 4 horas',
    likes: 0,
    comments: 0,
    isBlocked: true,
  ),
  Post(
    id: 8,
    authorName: 'Marketing Digital INTESUD',
    authorAvatar: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=100',
    authorRole: 'Carrera de Marketing Digital',
    isInstitutional: true,
    content: '📱 Aprende a crear estrategias digitales exitosas. SEO, SEM, Social Media, Analytics y más. El futuro del marketing está aquí y tú puedes ser parte de él.',
    timestamp: 'Hace 11 horas',
    likes: 178,
    comments: 41,
  ),
];

// ── PANTALLA PRINCIPAL ────────────────────────────────────────────────────────
class FeedGuestScreen extends StatefulWidget {
  const FeedGuestScreen({super.key});

  @override
  State<FeedGuestScreen> createState() => _FeedGuestScreenState();
}

class _FeedGuestScreenState extends State<FeedGuestScreen> {
  bool _showDiscountBanner = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Stack(
        children: [
          Column(
            children: [
              // ── HEADER ────────────────────────────────────────────────
              _buildHeader(),

              // ── CONTENIDO SCROLLABLE ───────────────────────────────────
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 100),
                  children: [
                    if (_showDiscountBanner) _buildDiscountBanner(),
                    _buildGuestBanner(),
                    ...List.generate(mockPosts.length, (index) {
                      return Column(
                        children: [
                          _PostCard(post: mockPosts[index]),
                          if ((index + 1) % 3 == 0) _buildCtaBanner(),
                        ],
                      );
                    }),
                    _buildFinalCta(),
                  ],
                ),
              ),
            ],
          ),

          // ── FAB CONTÁCTANOS ───────────────────────────────────────────
          Positioned(
            bottom: 100,
            right: 20,
            child: _buildContactFab(),
          ),
        ],
      ),

      // ── BOTTOM NAV ─────────────────────────────────────────────────────
      bottomNavigationBar: _buildBottomNav(),
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
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Image.asset('assets/images/Logo_app.png',
                  width: 56, height: 56, fit: BoxFit.contain),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('MI INTESUD',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Row(
                    children: const [
                      Icon(Icons.visibility, color: Color(0xFF96D9C0), size: 12),
                      SizedBox(width: 4),
                      Text('Modo Invitado',
                          style: TextStyle(
                              color: Color(0xFF96D9C0), fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              // Botón Login
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/login'),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Icon(Icons.login_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pushNamed('/register'),
                icon: const Icon(Icons.school_rounded, size: 16),
                label: const Text('Registrarse',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF103B40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── FAB CONTÁCTANOS ───────────────────────────────────────────────────────
  Widget _buildContactFab() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, value, child) => Transform.scale(
        scale: value,
        child: child,
      ),
      child: GestureDetector(
        onTap: () => _showContactDialog(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2DA679), Color(0xFF0F5944)],
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2DA679).withOpacity(0.5),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.headset_mic_rounded, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                '¡Contáctanos!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContactDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Ícono
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2DA679), Color(0xFF0F5944)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.headset_mic_rounded,
                  color: Colors.white, size: 30),
            ),
            const SizedBox(height: 14),

            const Text(
              '¿Cómo podemos ayudarte?',
              style: TextStyle(
                color: Color(0xFF103B40),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Elige una opción para contactarnos',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Opciones
            _ContactOption(
              icon: Icons.phone_rounded,
              label: 'Llamar a Admisiones',
              subtitle: '+593 99 000 0000',
              color: const Color(0xFF2DA679),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 10),
            _ContactOption(
              icon: Icons.email_rounded,
              label: 'Enviar un correo',
              subtitle: 'admisiones@intesud.edu',
              color: const Color(0xFF0F5944),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 10),
            _ContactOption(
              icon: Icons.chat_rounded,
              label: 'Chat en vivo',
              subtitle: 'Disponible Lun - Vie 8:00 - 17:00',
              color: const Color(0xFF103B40),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ── BANNER DESCUENTO ──────────────────────────────────────────────────────
  Widget _buildDiscountBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2DA679), Color(0xFF0F5944), Color(0xFF103B40)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF103B40).withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 6)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Icon(Icons.discount_rounded,
                    color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.auto_awesome,
                            color: Color(0xFFFFD700), size: 18),
                        SizedBox(width: 6),
                        Text('¡PROMOCIÓN EXCLUSIVA!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            color: Color(0xFF96D9C0), fontSize: 13),
                        children: [
                          TextSpan(text: 'Regístrate AHORA y obtén '),
                          TextSpan(
                            text: '20% DE DESCUENTO',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          TextSpan(
                              text: ' en tu matrícula. ¡Oferta por tiempo limitado!'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/register'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF103B40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                      ),
                      child: const Text('¡Quiero mi descuento!',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _showDiscountBanner = false),
                child: const Icon(Icons.close, color: Colors.white60, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── BANNER INVITADO ───────────────────────────────────────────────────────
  Widget _buildGuestBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF103B40), Color(0xFF0F5944), Color(0xFF2DA679)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Icon(Icons.visibility, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Explorando como Invitado',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                    const SizedBox(height: 8),
                    const Text(
                      'Aquí puedes ver publicaciones de nuestras carreras, eventos institucionales e información de marketing. Para ver contenido de estudiantes, regístrate.',
                      style: TextStyle(
                          color: Color(0xFF96D9C0), fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '⚠️ Funciones limitadas: No puedes comprar en la tienda ni ver contenido de estudiantes',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/register'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF103B40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          child: const Text('Registrarme Ahora',
                              style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2DA679),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            side: BorderSide(
                                color: Colors.white.withOpacity(0.3)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          child: const Text('Ya soy estudiante',
                              style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── CTA INTERMEDIO ────────────────────────────────────────────────────────
  Widget _buildCtaBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2DA679), Color(0xFF0F5944), Color(0xFF103B40)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Icon(Icons.trending_up_rounded,
                    color: Colors.white, size: 32),
              ),
              const SizedBox(height: 16),
              const Text('¡Inscríbete Ya!',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
              const SizedBox(height: 4),
              const Text('20% de DESCUENTO en tu Matrícula',
                  style: TextStyle(
                      color: Color(0xFF96D9C0),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              const SizedBox(height: 4),
              const Text('Únete a miles de estudiantes exitosos',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF103B40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                ),
                child: const Text('Matricularme Ahora',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── CTA FINAL ─────────────────────────────────────────────────────────────
  Widget _buildFinalCta() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF103B40), Color(0xFF0F5944), Color(0xFF2DA679)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 16,
                offset: const Offset(0, 6)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Icon(Icons.school_rounded,
                    color: Colors.white, size: 32),
              ),
              const SizedBox(height: 16),
              const Text('¿Listo para Comenzar?',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26)),
              const SizedBox(height: 8),
              const Text(
                'Regístrate como invitado y explora todo lo que INTESUD tiene para ofrecerte',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF96D9C0), fontSize: 15),
              ),
              const SizedBox(height: 8),
              const Text('¡No olvides tu 20% de descuento especial!',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/register'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF103B40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                    ),
                    child: const Text('Registrarme Gratis',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2DA679),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      side:
                          BorderSide(color: Colors.white.withOpacity(0.3)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                    ),
                    child: const Text('Ya soy Estudiante',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── BOTTOM NAV ────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 2)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Inicio',
                isActive: true,
                onTap: () {},
              ),
              _NavItem(
                icon: Icons.shopping_bag_outlined,
                label: 'Tienda',
                isActive: false,
                badge: Icons.visibility,
                onTap: () => Navigator.of(context).pushNamed('/store'),
              ),
              _NavItem(
                icon: Icons.calendar_month_outlined,
                label: 'Eventos',
                isActive: false,
                onTap: () => Navigator.of(context).pushNamed('/events'),
              ),
              _NavItem(
                icon: Icons.person_outline_rounded,
                label: 'Perfil',
                isActive: false,
                badge: Icons.lock,
                onTap: () => Navigator.of(context).pushNamed('/register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── POST CARD ─────────────────────────────────────────────────────────────────
class _PostCard extends StatefulWidget {
  final Post post;
  const _PostCard({required this.post});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: post.isBlocked
                    ? const Color(0xFFE0E0E0)
                    : const Color(0xFF96D9C0).withOpacity(0.4),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 3)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header del post
                Opacity(
                  opacity: post.isBlocked ? 0.5 : 1.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: NetworkImage(post.authorAvatar),
                          backgroundColor: const Color(0xFF96D9C0),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(post.authorName,
                                      style: const TextStyle(
                                          color: Color(0xFF103B40),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  if (post.isInstitutional) ...[
                                    const SizedBox(width: 6),
                                    const Icon(Icons.verified_rounded,
                                        color: Color(0xFF2DA679), size: 18),
                                  ],
                                ],
                              ),
                              Text(post.authorRole,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              Text(post.timestamp,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Contenido
                if (!post.isBlocked)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: Text(post.content,
                        style: const TextStyle(
                            color: Color(0xFF103B40),
                            fontSize: 14,
                            height: 1.5)),
                  ),

                // Imagen
                if (post.image != null && !post.isBlocked)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: post.image!.startsWith('assets/')
                          ? Image.asset(
                              post.image!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              post.image!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),

                // Acciones
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Color(0xFFF0F0F0), width: 2)),
                  ),
                  child: Opacity(
                    opacity: post.isBlocked ? 0.3 : 1.0,
                    child: Row(
                      children: [
                        _ActionButton(
                          icon: _liked && !post.isBlocked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          label: post.isBlocked
                              ? '0'
                              : '${post.likes + (_liked ? 1 : 0)}',
                          color: _liked && !post.isBlocked
                              ? Colors.red
                              : Colors.grey,
                          onTap: post.isBlocked
                              ? null
                              : () => setState(() => _liked = !_liked),
                        ),
                        _ActionButton(
                          icon: Icons.chat_bubble_outline_rounded,
                          label: post.isBlocked ? '0' : '${post.comments}',
                          color: Colors.grey,
                          onTap: post.isBlocked ? null : () {},
                        ),
                        _ActionButton(
                          icon: Icons.share_outlined,
                          label: '',
                          color: Colors.grey,
                          onTap: post.isBlocked ? null : () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Overlay bloqueado
          if (post.isBlocked)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.0),
                        Colors.white.withOpacity(0.85),
                        Colors.white.withOpacity(0.97),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Ícono de candado
          if (post.isBlocked)
            Positioned.fill(
              child: Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF103B40), Color(0xFF0F5944)],
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4)),
                    ],
                  ),
                  child: const Icon(Icons.lock_rounded,
                      color: Colors.white, size: 32),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── ACTION BUTTON ─────────────────────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 22),
              if (label.isNotEmpty) ...[
                const SizedBox(width: 6),
                Text(label,
                    style: TextStyle(color: color, fontSize: 13)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── CONTACT OPTION ───────────────────────────────────────────────────────────
class _ContactOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ContactOption({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}

// ── NAV ITEM ──────────────────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final IconData? badge;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF2DA679).withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: isActive
                      ? const Color(0xFF2DA679)
                      : Colors.grey,
                  size: 24,
                ),
              ),
              if (badge != null)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(badge, size: 10, color: Colors.grey),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight:
                  isActive ? FontWeight.w600 : FontWeight.normal,
              color: isActive ? const Color(0xFF2DA679) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}