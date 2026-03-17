import 'package:flutter/material.dart';

// ── MODELO ────────────────────────────────────────────────────────────────────
class FeedPost {
  final int id;
  final String authorName;
  final String authorAvatar;
  final String authorRole;
  final String content;
  final String? image;
  final String timestamp;
  int likes;
  final int comments;
  final int shares;
  bool isLiked;

  FeedPost({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.authorRole,
    required this.content,
    this.image,
    required this.timestamp,
    required this.likes,
    required this.comments,
    this.shares = 0,
    this.isLiked = false,
  });
}

// ── DATOS MOCK ────────────────────────────────────────────────────────────────
List<FeedPost> buildMockPosts() => [
      FeedPost(
        id: 1,
        authorName: 'Juan Pérez',
        authorAvatar:
            'https://images.unsplash.com/photo-1762753674498-73ec49feafc4?w=200',
        authorRole: 'AVISO OFICIAL • DOCENTE',
        content:
            'Eventos de Base de Datos implementarán Teoría de Base de Datos y eventos de modo.',
        timestamp: 'Hace 2 horas',
        likes: 150,
        comments: 23,
        shares: 12,
      ),
      FeedPost(
        id: 2,
        authorName: 'María García',
        authorAvatar:
            'https://images.unsplash.com/photo-1557353425-09253747c2bf?w=200',
        authorRole: 'Estudiante',
        content:
            '¡Increíble conferencia sobre Inteligencia Artificial hoy! Aprendí mucho sobre redes neuronales y su aplicación en el mundo real. #IA #Universidad',
        image:
            'https://images.unsplash.com/photo-1596256444371-3e4362eba65b?w=800',
        timestamp: 'Hace 5 horas',
        likes: 234,
        comments: 45,
        shares: 8,
        isLiked: true,
      ),
    ];

// ── PANTALLA ──────────────────────────────────────────────────────────────────
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  final List<FeedPost> _posts = buildMockPosts();
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabAnim;
  late Animation<double> _fabBounce;

  @override
  void initState() {
    super.initState();
    _fabAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _fabBounce = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _fabAnim, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fabAnim.dispose();
    super.dispose();
  }

  void _toggleLike(int id) {
    setState(() {
      final post = _posts.firstWhere((p) => p.id == id);
      post.isLiked = !post.isLiked;
      post.likes += post.isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  children: [
                    _buildCreatePost(),
                    const SizedBox(height: 8),
                    ..._posts.map((p) => _PostCard(
                          post: p,
                          onLike: () => _toggleLike(p.id),
                          onComment: () => Navigator.of(context)
                              .pushNamed('/comments', arguments: p.id),
                        )),
                  ],
                ),
              ),
            ],
          ),

          // FAB Tienda flotante con bounce
          Positioned(
            bottom: 90,
            right: 20,
            child: AnimatedBuilder(
              animation: _fabBounce,
              builder: (context, child) => Transform.translate(
                offset: Offset(0, _fabBounce.value),
                child: child,
              ),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/store'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2DA679), Color(0xFF0F5944)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border:
                        Border.all(color: Colors.white, width: 2),
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
                      Icon(Icons.shopping_bag_rounded,
                          color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        '¡Tienda!',
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
            ),
          ),
        ],
      ),
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
          BoxShadow(
              color: Colors.black26, blurRadius: 10, offset: Offset(0, 3)),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              // Logo + título + íconos
              Row(
                children: [
                  Image.asset('assets/images/Logo_app.png',
                      width: 52, height: 52, fit: BoxFit.contain),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('MI INTESUD SOCIAL',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      Text('Comunidad Institucional',
                          style: TextStyle(
                              color: Color(0xFF96D9C0), fontSize: 12)),
                    ],
                  ),
                  const Spacer(),
                  // Búsqueda
                  _HeaderIconBtn(
                    icon: Icons.search_rounded,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  // Notificaciones con badge
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _HeaderIconBtn(
                        icon: Icons.notifications_outlined,
                        onTap: () => Navigator.of(context).pushNamed('/notifications'),
                      ),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color(0xFF103B40), width: 2),
                          ),
                          child: const Center(
                            child: Text('3',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Barra de búsqueda
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2)),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText:
                        'Buscar publicaciones, personas, eventos...',
                    hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 13),
                    prefixIcon: Icon(Icons.search_rounded,
                        color: Color(0xFF103B40), size: 20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── CREAR POST ────────────────────────────────────────────────────────────
  Widget _buildCreatePost() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: const Color(0xFF96D9C0).withOpacity(0.4), width: 2),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar usuario actual
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color(0xFF96D9C0), width: 2),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2DA679), Color(0xFF0F5944)],
                  ),
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Text(
                    '¿Qué está pasando en la universidad?',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Tendencias
              _PostActionChip(
                icon: Icons.trending_up_rounded,
                label: 'Tendencias',
                onTap: () {},
              ),
              const SizedBox(width: 8),
              // Multimedia
              _PostActionChip(
                icon: Icons.add_photo_alternate_outlined,
                label: 'Multimedia',
                onTap: () {},
              ),
              const Spacer(),
              // Publicar
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2DA679), Color(0xFF0F5944)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color:
                              const Color(0xFF2DA679).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3)),
                    ],
                  ),
                  child: const Text('Publicar',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── BOTTOM NAV ────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(
                color: Color(0xFFE8F5F0), width: 2)),
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
                  isActive: true,
                  onTap: () {}),
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
                  icon: Icons.person_outline_rounded,
                  label: 'Perfil',
                  onTap: () =>
                      Navigator.of(context).pushNamed('/profile')),
            ],
          ),
        ),
      ),
    );
  }
}

// ── POST CARD ─────────────────────────────────────────────────────────────────
class _PostCard extends StatelessWidget {
  final FeedPost post;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const _PostCard({
    required this.post,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: const Color(0xFFE8E8E8), width: 1.5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── HEADER DEL POST ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color(0xFF96D9C0), width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage:
                          NetworkImage(post.authorAvatar),
                      backgroundColor: const Color(0xFF96D9C0),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.authorName,
                            style: const TextStyle(
                                color: Color(0xFF103B40),
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        Text(post.authorRole,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                        Text(post.timestamp,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.more_horiz_rounded,
                        color: Colors.grey, size: 20),
                  ),
                ],
              ),
            ),

            // ── CONTENIDO ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Text(
                post.content,
                style: const TextStyle(
                    color: Color(0xFF103B40),
                    fontSize: 14,
                    height: 1.5),
              ),
            ),

            // ── IMAGEN ───────────────────────────────────────────
            if (post.image != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    post.image!,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            // ── STATS ────────────────────────────────────────────
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.favorite_rounded,
                      size: 15, color: Color(0xFF2DA679)),
                  const SizedBox(width: 4),
                  Text('${post.likes}',
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 12)),
                  const SizedBox(width: 12),
                  Text('${post.comments} comentarios',
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 12)),
                  const SizedBox(width: 12),
                  Text('${post.shares} compartidos',
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),

            // ── ACCIONES ─────────────────────────────────────────
            Container(
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Color(0xFFF2F2F2), width: 2)),
              ),
              child: Row(
                children: [
                  _ActionBtn(
                    icon: post.isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    label: 'Me gusta',
                    isActive: post.isLiked,
                    onTap: onLike,
                  ),
                  _ActionBtn(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Comentar',
                    onTap: onComment,
                  ),
                  _ActionBtn(
                    icon: Icons.share_outlined,
                    label: 'Compartir',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── WIDGETS AUXILIARES ────────────────────────────────────────────────────────
class _HeaderIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HeaderIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _PostActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _PostActionChip(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF96D9C0).withOpacity(0.25),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF103B40)),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    color: Color(0xFF103B40),
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF2DA679).withOpacity(0.08)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 20,
                  color: isActive
                      ? const Color(0xFF2DA679)
                      : Colors.grey[600]),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isActive
                          ? const Color(0xFF2DA679)
                          : Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
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
                  fontWeight: isActive
                      ? FontWeight.w700
                      : FontWeight.normal,
                  color: isActive
                      ? const Color(0xFF2DA679)
                      : Colors.grey[500])),
        ],
      ),
    );
  }
}