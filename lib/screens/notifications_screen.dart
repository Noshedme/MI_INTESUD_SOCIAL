import 'package:flutter/material.dart';

// ── MODELO ────────────────────────────────────────────────────────────────────
enum NotificationType { like, comment, message, event, institutional }

class AppNotification {
  final int id;
  final NotificationType type;
  final String title;
  final String body;
  final String timestamp;
  final String avatar;
  bool isRead;

  AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.avatar,
    this.isRead = false,
  });
}

// ── DATOS MOCK ────────────────────────────────────────────────────────────────
List<AppNotification> buildNotifications() => [
      AppNotification(
        id: 1,
        type: NotificationType.institutional,
        title: 'INTESUD Oficial',
        body: '📢 Nueva convocatoria para becas 2026. ¡No te pierdas esta oportunidad!',
        timestamp: 'Hace 5 min',
        avatar: 'https://images.unsplash.com/photo-1560179707-f14e90ef3623?w=100',
        isRead: false,
      ),
      AppNotification(
        id: 2,
        type: NotificationType.like,
        title: 'Juan Pérez y 12 más',
        body: 'Le dieron Me gusta a tu publicación "Proyecto final de semestre 🎓"',
        timestamp: 'Hace 20 min',
        avatar: 'https://images.unsplash.com/photo-1762753674498-73ec49feafc4?w=100',
        isRead: false,
      ),
      AppNotification(
        id: 3,
        type: NotificationType.comment,
        title: 'María García',
        body: 'Comentó en tu publicación: "¡Excelente trabajo! Quedó increíble 👏"',
        timestamp: 'Hace 1 hora',
        avatar: 'https://images.unsplash.com/photo-1557353425-09253747c2bf?w=100',
        isRead: false,
      ),
      AppNotification(
        id: 4,
        type: NotificationType.message,
        title: 'Carlos Ruiz',
        body: 'Te envió un mensaje: "Hola, ¿tienes los apuntes de hoy?"',
        timestamp: 'Hace 2 horas',
        avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
        isRead: true,
      ),
      AppNotification(
        id: 5,
        type: NotificationType.event,
        title: 'Evento próximo',
        body: '🗓️ "Conferencia de IA" comienza mañana a las 14:00 en el Auditorio Principal.',
        timestamp: 'Hace 3 horas',
        avatar: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=100',
        isRead: true,
      ),
      AppNotification(
        id: 6,
        type: NotificationType.like,
        title: 'Ana López',
        body: 'Le dio Me gusta a tu comentario en "Seminario de Programación"',
        timestamp: 'Hace 5 horas',
        avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
        isRead: true,
      ),
      AppNotification(
        id: 7,
        type: NotificationType.institutional,
        title: 'Administración INTESUD',
        body: '⚠️ Recuerda que el pago de matrícula vence el 30 de este mes.',
        timestamp: 'Ayer',
        avatar: 'https://images.unsplash.com/photo-1560179707-f14e90ef3623?w=100',
        isRead: true,
      ),
      AppNotification(
        id: 8,
        type: NotificationType.comment,
        title: 'Pedro Sánchez',
        body: 'Respondió tu comentario: "Totalmente de acuerdo contigo!"',
        timestamp: 'Ayer',
        avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        isRead: true,
      ),
      AppNotification(
        id: 9,
        type: NotificationType.event,
        title: 'Feria de Proyectos',
        body: '🎪 Quedan 3 días para la Feria de Proyectos. ¡Confirma tu asistencia!',
        timestamp: 'Hace 2 días',
        avatar: 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=100',
        isRead: true,
      ),
      AppNotification(
        id: 10,
        type: NotificationType.message,
        title: 'Ana López',
        body: 'Te envió un mensaje: "¿Vamos a formar grupo para el trabajo?"',
        timestamp: 'Hace 2 días',
        avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
        isRead: true,
      ),
    ];

// ── HELPERS ───────────────────────────────────────────────────────────────────
extension NotificationTypeExt on NotificationType {
  IconData get icon {
    switch (this) {
      case NotificationType.like:
        return Icons.favorite_rounded;
      case NotificationType.comment:
        return Icons.chat_bubble_rounded;
      case NotificationType.message:
        return Icons.mail_rounded;
      case NotificationType.event:
        return Icons.calendar_month_rounded;
      case NotificationType.institutional:
        return Icons.campaign_rounded;
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.like:
        return Colors.red;
      case NotificationType.comment:
        return const Color(0xFF2DA679);
      case NotificationType.message:
        return const Color(0xFF103B40);
      case NotificationType.event:
        return const Color(0xFF0F5944);
      case NotificationType.institutional:
        return const Color(0xFF96D9C0);
    }
  }

  String get label {
    switch (this) {
      case NotificationType.like:
        return 'Me gusta';
      case NotificationType.comment:
        return 'Comentario';
      case NotificationType.message:
        return 'Mensaje';
      case NotificationType.event:
        return 'Evento';
      case NotificationType.institutional:
        return 'Aviso';
    }
  }
}

// ── PANTALLA ──────────────────────────────────────────────────────────────────
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late List<AppNotification> _notifications;
  late TabController _tabCtrl;
  String _selectedFilter = 'all';

  final List<Map<String, dynamic>> _filters = [
    {'id': 'all', 'label': 'Todas'},
    {'id': 'unread', 'label': 'No leídas'},
    {'id': 'like', 'label': 'Likes'},
    {'id': 'comment', 'label': 'Comentarios'},
    {'id': 'message', 'label': 'Mensajes'},
    {'id': 'event', 'label': 'Eventos'},
    {'id': 'institutional', 'label': 'Avisos'},
  ];

  @override
  void initState() {
    super.initState();
    _notifications = buildNotifications();
    _tabCtrl = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  int get _unreadCount =>
      _notifications.where((n) => !n.isRead).length;

  List<AppNotification> get _filtered {
    switch (_selectedFilter) {
      case 'unread':
        return _notifications.where((n) => !n.isRead).toList();
      case 'like':
        return _notifications
            .where((n) => n.type == NotificationType.like)
            .toList();
      case 'comment':
        return _notifications
            .where((n) => n.type == NotificationType.comment)
            .toList();
      case 'message':
        return _notifications
            .where((n) => n.type == NotificationType.message)
            .toList();
      case 'event':
        return _notifications
            .where((n) => n.type == NotificationType.event)
            .toList();
      case 'institutional':
        return _notifications
            .where((n) => n.type == NotificationType.institutional)
            .toList();
      default:
        return _notifications;
    }
  }

  void _markAllRead() {
    setState(() {
      for (final n in _notifications) {
        n.isRead = true;
      }
    });
  }

  void _markRead(int id) {
    setState(() {
      _notifications.firstWhere((n) => n.id == id).isRead = true;
    });
  }

  void _deleteNotification(int id) {
    setState(() {
      _notifications.removeWhere((n) => n.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildHeader(),
          _buildFilters(),
          Expanded(
            child: _filtered.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) {
                      final notif = _filtered[i];
                      return _NotificationCard(
                        notification: notif,
                        onTap: () {
                          _markRead(notif.id);
                          _handleTap(notif);
                        },
                        onDismiss: () => _deleteNotification(notif.id),
                      );
                    },
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
              color: Colors.black26, blurRadius: 10, offset: Offset(0, 3)),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Row(
                children: [
                  // Atrás
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Notificaciones',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Text(
                          _unreadCount > 0
                              ? '$_unreadCount sin leer'
                              : 'Todo al día ✓',
                          style: const TextStyle(
                              color: Color(0xFF96D9C0), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  // Marcar todas como leídas
                  if (_unreadCount > 0)
                    GestureDetector(
                      onTap: _markAllRead,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.2)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.done_all_rounded,
                                color: Color(0xFF96D9C0), size: 16),
                            SizedBox(width: 6),
                            Text('Leer todo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              // Resumen de no leídas
              if (_unreadCount > 0) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                            Icons.notifications_active_rounded,
                            color: Colors.white,
                            size: 18),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Tienes $_unreadCount notificaciones nuevas',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ── FILTROS ───────────────────────────────────────────────────────────────
  Widget _buildFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _filters.map((f) {
            final isActive = _selectedFilter == f['id'];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () =>
                    setState(() => _selectedFilter = f['id'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isActive
                        ? const LinearGradient(colors: [
                            Color(0xFF2DA679),
                            Color(0xFF0F5944)
                          ])
                        : null,
                    color: isActive ? null : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isActive
                          ? const Color(0xFF2DA679)
                          : const Color(0xFFE0E0E0),
                      width: 1.5,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                                color: const Color(0xFF2DA679)
                                    .withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2))
                          ]
                        : [],
                  ),
                  child: Row(
                    children: [
                      Text(
                        f['label'] as String,
                        style: TextStyle(
                            color: isActive
                                ? Colors.white
                                : Colors.grey[600],
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                      // Badge contador para "No leídas"
                      if (f['id'] == 'unread' && _unreadCount > 0) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.white.withOpacity(0.3)
                                : Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$_unreadCount',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── EMPTY ─────────────────────────────────────────────────────────────────
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF96D9C0).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_off_outlined,
                color: Color(0xFF2DA679), size: 36),
          ),
          const SizedBox(height: 16),
          const Text('Sin notificaciones',
              style: TextStyle(
                  color: Color(0xFF103B40),
                  fontWeight: FontWeight.bold,
                  fontSize: 17)),
          const SizedBox(height: 6),
          const Text('No tienes notificaciones en esta categoría',
              style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  // ── NAVEGACIÓN POR TIPO ───────────────────────────────────────────────────
  void _handleTap(AppNotification notif) {
    switch (notif.type) {
      case NotificationType.message:
        Navigator.of(context).pushNamed('/messages');
        break;
      case NotificationType.event:
        Navigator.of(context).pushNamed('/events');
        break;
      case NotificationType.comment:
        Navigator.of(context)
            .pushNamed('/comments', arguments: 1);
        break;
      case NotificationType.like:
      case NotificationType.institutional:
        Navigator.of(context).pushNamed('/feed');
        break;
    }
  }
}

// ── NOTIFICATION CARD ─────────────────────────────────────────────────────────
class _NotificationCard extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final n = notification;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Dismissible(
        key: Key('notif_${n.id}'),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDismiss(),
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.delete_rounded,
              color: Colors.white, size: 26),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: n.isRead
                  ? Colors.white
                  : const Color(0xFFEFF9F5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: n.isRead
                    ? const Color(0xFFEEEEEE)
                    : const Color(0xFF96D9C0).withOpacity(0.5),
                width: n.isRead ? 1 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: n.isRead
                      ? Colors.black.withOpacity(0.04)
                      : const Color(0xFF2DA679).withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar con badge de tipo
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: n.isRead
                                ? const Color(0xFFE0E0E0)
                                : n.type.color.withOpacity(0.4),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundImage: NetworkImage(n.avatar),
                          backgroundColor: const Color(0xFF96D9C0),
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        right: -2,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: n.type.color,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white, width: 2),
                          ),
                          child: Icon(n.type.icon,
                              color: Colors.white, size: 11),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),

                  // Contenido
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título + badge tipo
                        Row(
                          children: [
                            Expanded(
                              child: Text(n.title,
                                  style: TextStyle(
                                    color: const Color(0xFF103B40),
                                    fontWeight: n.isRead
                                        ? FontWeight.w600
                                        : FontWeight.bold,
                                    fontSize: 14,
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: n.type.color.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(n.type.label,
                                  style: TextStyle(
                                      color: n.type.color,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Cuerpo
                        Text(n.body,
                            style: TextStyle(
                              color: n.isRead
                                  ? Colors.grey
                                  : const Color(0xFF103B40),
                              fontSize: 13,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 6),

                        // Tiempo + punto no leído
                        Row(
                          children: [
                            const Icon(Icons.access_time_rounded,
                                size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(n.timestamp,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 11)),
                            const Spacer(),
                            if (!n.isRead)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2DA679),
                                  shape: BoxShape.circle,
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
          ),
        ),
      ),
    );
  }
}