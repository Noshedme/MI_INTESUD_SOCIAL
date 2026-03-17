import 'package:flutter/material.dart';

// ── MODELO ────────────────────────────────────────────────────────────────────
class Conversation {
  final int id;
  final String userName;
  final String userAvatar;
  final bool isOnline;
  final String lastMessage;
  final String timestamp;
  final bool unread;
  final int unreadCount;

  const Conversation({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.isOnline,
    required this.lastMessage,
    required this.timestamp,
    required this.unread,
    required this.unreadCount,
  });
}

// ── DATOS MOCK ────────────────────────────────────────────────────────────────
const List<Conversation> mockConversations = [
  Conversation(
    id: 1,
    userName: 'Juan Pérez',
    userAvatar: 'https://images.unsplash.com/photo-1762753674498-73ec49feafc4?w=200',
    isOnline: true,
    lastMessage: 'Hola, ¿tienes los apuntes de la clase de hoy?',
    timestamp: '10:30',
    unread: true,
    unreadCount: 3,
  ),
  Conversation(
    id: 2,
    userName: 'María García',
    userAvatar: 'https://images.unsplash.com/photo-1557353425-09253747c2bf?w=200',
    isOnline: true,
    lastMessage: 'Perfecto, nos vemos mañana entonces',
    timestamp: '09:15',
    unread: false,
    unreadCount: 0,
  ),
  Conversation(
    id: 3,
    userName: 'Carlos Ruiz',
    userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
    isOnline: false,
    lastMessage: 'Gracias por la ayuda con el proyecto',
    timestamp: 'Ayer',
    unread: false,
    unreadCount: 0,
  ),
  Conversation(
    id: 4,
    userName: 'Ana López',
    userAvatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
    isOnline: true,
    lastMessage: '¿Vamos a formar grupo para el trabajo?',
    timestamp: 'Ayer',
    unread: true,
    unreadCount: 1,
  ),
  Conversation(
    id: 5,
    userName: 'Pedro Sánchez',
    userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
    isOnline: false,
    lastMessage: 'Ok, entendido 👍',
    timestamp: '2 días',
    unread: false,
    unreadCount: 0,
  ),
];

// ── PANTALLA ──────────────────────────────────────────────────────────────────
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
    _fadeAnim =
        CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _searchCtrl.addListener(
        () => setState(() => _query = _searchCtrl.text));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  List<Conversation> get _filtered => mockConversations
      .where((c) =>
          c.userName.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  int get _totalUnread =>
      mockConversations.fold(0, (s, c) => s + c.unreadCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: _filtered.isEmpty
                  ? _buildEmpty()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      itemCount: _filtered.length,
                      itemBuilder: (_, i) => _ConversationCard(
                        conversation: _filtered[i],
                        onTap: () => Navigator.of(context).pushNamed(
                          '/chat',
                          arguments: _filtered[i].id,
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

  // ── HEADER ──────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF103B40), Color(0xFF0F5944)],
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black26, blurRadius: 10, offset: Offset(0, 3)),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
          child: Column(
            children: [
              Row(
                children: [
                  // Atrás
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 16),
                  // Título
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Mensajes',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        if (_totalUnread > 0)
                          Text(
                            '$_totalUnread conversaciones nuevas',
                            style: const TextStyle(
                                color: Color(0xFF96D9C0), fontSize: 13),
                          ),
                      ],
                    ),
                  ),
                  // Nuevo mensaje
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2DA679),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 2)),
                        ],
                      ),
                      child: const Icon(Icons.edit_rounded,
                          color: Colors.white, size: 22),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Barra de búsqueda
              Container(
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
                child: TextField(
                  controller: _searchCtrl,
                  style: const TextStyle(
                      color: Color(0xFF103B40), fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Buscar en conversaciones...',
                    hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 14),
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

  // ── EMPTY STATE ──────────────────────────────────────────────────────────
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF96D9C0), Color(0xFF2DA679)],
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Icon(Icons.mail_outline_rounded,
                color: Colors.white, size: 44),
          ),
          const SizedBox(height: 20),
          Text(
            _query.isNotEmpty
                ? 'No se encontraron conversaciones'
                : 'No tienes mensajes aún',
            style: const TextStyle(
                color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ── BOTTOM NAV ───────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border:
            Border(top: BorderSide(color: Color(0xFFE8E8E8), width: 1.5)),
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
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed('/feed')),
              _NavBtn(
                  icon: Icons.chat_bubble_rounded,
                  label: 'Mensajes',
                  isActive: true,
                  onTap: () {}),
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

// ── CONVERSATION CARD ─────────────────────────────────────────────────────────
class _ConversationCard extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const _ConversationCard(
      {required this.conversation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: conversation.unread
                  ? const Color(0xFF96D9C0).withOpacity(0.6)
                  : const Color(0xFFEEEEEE),
              width: conversation.unread ? 2 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: conversation.unread
                    ? const Color(0xFF2DA679).withOpacity(0.08)
                    : Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Fondo verde sutil en no leídos
              if (conversation.unreadCount > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          const Color(0xFF2DA679).withOpacity(0.12),
                          Colors.transparent,
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(80),
                      ),
                    ),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar + online indicator
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: conversation.isOnline
                                  ? const Color(0xFF96D9C0)
                                  : const Color(0xFFE0E0E0),
                              width: 3,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(conversation.userAvatar),
                            backgroundColor: const Color(0xFF96D9C0),
                          ),
                        ),
                        if (conversation.isOnline)
                          Positioned(
                            bottom: -1,
                            right: -1,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2DA679),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 2.5),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 14),

                    // Info conversación
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nombre + hora
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  conversation.userName,
                                  style: TextStyle(
                                    color: const Color(0xFF103B40),
                                    fontWeight: conversation.unread
                                        ? FontWeight.bold
                                        : FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  conversation.timestamp,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: conversation.unread
                                        ? const Color(0xFF2DA679)
                                        : Colors.grey,
                                    fontWeight: conversation.unread
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Último mensaje
                          Text(
                            conversation.lastMessage,
                            style: TextStyle(
                              color: conversation.unread
                                  ? const Color(0xFF103B40)
                                  : Colors.grey,
                              fontSize: 13,
                              fontWeight: conversation.unread
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 8),

                          // Badge mensajes nuevos
                          if (conversation.unreadCount > 0)
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF2DA679),
                                        Color(0xFF0F5944)
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF2DA679)
                                            .withOpacity(0.3),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${conversation.unreadCount} ${conversation.unreadCount == 1 ? 'mensaje nuevo' : 'mensajes nuevos'}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
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
}

// ── NAV BTN ───────────────────────────────────────────────────────────────────
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
                    : Colors.grey[500],
              )),
        ],
      ),
    );
  }
}