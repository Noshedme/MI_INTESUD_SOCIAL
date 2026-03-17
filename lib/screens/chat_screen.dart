import 'package:flutter/material.dart';
import 'dart:async';

// ── MODELOS ───────────────────────────────────────────────────────────────────
enum MessageStatus { sent, delivered, read }

class ChatMessage {
  final int id;
  final String text;
  final String timestamp;
  final bool isSent;
  final MessageStatus? status;

  ChatMessage({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isSent,
    this.status,
  });
}

class ChatUser {
  final String name;
  final String avatar;
  final bool isOnline;
  final String? lastSeen;

  const ChatUser({
    required this.name,
    required this.avatar,
    required this.isOnline,
    this.lastSeen,
  });
}

// ── DATOS MOCK ────────────────────────────────────────────────────────────────
const Map<int, ChatUser> chatUsers = {
  1: ChatUser(
    name: 'Juan Pérez',
    avatar: 'https://images.unsplash.com/photo-1762753674498-73ec49feafc4?w=200',
    isOnline: true,
  ),
  2: ChatUser(
    name: 'María García',
    avatar: 'https://images.unsplash.com/photo-1557353425-09253747c2bf?w=200',
    isOnline: true,
  ),
  3: ChatUser(
    name: 'Carlos Ruiz',
    avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
    isOnline: false,
    lastSeen: 'Hace 2 horas',
  ),
  4: ChatUser(
    name: 'Ana López',
    avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
    isOnline: true,
  ),
};

List<ChatMessage> buildInitialMessages() => [
      ChatMessage(
        id: 1,
        text: 'Hola, ¿cómo estás?',
        timestamp: '10:00',
        isSent: false,
      ),
      ChatMessage(
        id: 2,
        text: '¡Hola! Todo bien, ¿y tú?',
        timestamp: '10:02',
        isSent: true,
        status: MessageStatus.read,
      ),
      ChatMessage(
        id: 3,
        text: 'Muy bien, gracias. ¿Tienes los apuntes de la clase de hoy?',
        timestamp: '10:05',
        isSent: false,
      ),
      ChatMessage(
        id: 4,
        text: 'Sí, claro. Te los paso ahora mismo',
        timestamp: '10:06',
        isSent: true,
        status: MessageStatus.read,
      ),
      ChatMessage(
        id: 5,
        text: '¿Los necesitas en PDF o en Word?',
        timestamp: '10:07',
        isSent: true,
        status: MessageStatus.delivered,
      ),
    ];

// ── PANTALLA ──────────────────────────────────────────────────────────────────
class ChatScreen extends StatefulWidget {
  final int userId;
  const ChatScreen({super.key, this.userId = 1});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<ChatMessage> _messages;
  late ChatUser _chatUser;
  final TextEditingController _inputCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messages = buildInitialMessages();
    _chatUser = chatUsers[widget.userId] ?? chatUsers[1]!;
    _inputCtrl.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollCtrl.hasClients) {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  String _nowTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  void _sendMessage() {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        id: _messages.length + 1,
        text: text,
        timestamp: _nowTime(),
        isSent: true,
        status: MessageStatus.sent,
      ));
      _inputCtrl.clear();
      _isTyping = false;
    });

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);

    // Simular respuesta automática después de 2s
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _messages.add(ChatMessage(
          id: _messages.length + 1,
          text: '¡Perfecto! Gracias por el mensaje 👍',
          timestamp: _nowTime(),
          isSent: false,
        ));
      });
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    });
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final weekdays = [
      'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'
    ];
    final months = [
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
    final dateStr =
        '${weekdays[today.weekday - 1]}, ${today.day} de ${months[today.month - 1]}';

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Column(
        children: [
          // ── HEADER ────────────────────────────────────────────────
          _buildHeader(),

          // ── MENSAJES ──────────────────────────────────────────────
          Expanded(
            child: ListView(
              controller: _scrollCtrl,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              children: [
                // Separador de fecha
                _DateDivider(label: 'Hoy - $dateStr'),
                const SizedBox(height: 8),

                // Mensajes
                ..._messages.map((m) => _MessageBubble(
                      message: m,
                      chatUser: _chatUser,
                    )),

                // Indicador "escribiendo..."
                if (_isTyping)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 48),
                      child: _TypingIndicator(user: _chatUser),
                    ),
                  ),
              ],
            ),
          ),

          // ── INPUT ─────────────────────────────────────────────────
          _buildInput(),
        ],
      ),
    );
  }

  // ── HEADER ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top bar: atrás + acciones
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: Color(0xFF103B40)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  // Llamar
                  _HeaderActionBtn(
                    label: 'Llamar',
                    icon: Icons.phone_rounded,
                    bg: const Color(0xFFD0F0E4),
                    fg: const Color(0xFF103B40),
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  // Video
                  _HeaderActionBtn(
                    label: 'Video',
                    icon: Icons.videocam_rounded,
                    bg: const Color(0xFF2DA679),
                    fg: Colors.white,
                    onTap: () {},
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(Icons.more_vert_rounded,
                        color: Color(0xFF103B40)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // User info bar
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF103B40), Color(0xFF0F5944)],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFF96D9C0), width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundImage:
                              NetworkImage(_chatUser.avatar),
                          backgroundColor: const Color(0xFF96D9C0),
                        ),
                      ),
                      if (_chatUser.isOnline)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2DA679),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _chatUser.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          _chatUser.isOnline
                              ? '● En línea ahora'
                              : 'Última conexión: ${_chatUser.lastSeen ?? "Hace tiempo"}',
                          style: const TextStyle(
                              color: Color(0xFF96D9C0), fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
          ],
        ),
      ),
    );
  }

  // ── INPUT ─────────────────────────────────────────────────────────────────
  Widget _buildInput() {
    final hasText = _inputCtrl.text.trim().isNotEmpty;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border:
            Border(top: BorderSide(color: Color(0xFF96D9C0), width: 2)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -3)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          child: Column(
            children: [
              // Botones rápidos
              Row(
                children: [
                  _QuickBtn(
                      icon: Icons.camera_alt_rounded,
                      label: 'Foto',
                      onTap: () {}),
                  const SizedBox(width: 8),
                  _QuickBtn(
                      icon: Icons.photo_library_rounded,
                      label: 'Galería',
                      onTap: () {}),
                  const SizedBox(width: 8),
                  _QuickBtn(
                      icon: Icons.attach_file_rounded,
                      label: 'Archivo',
                      onTap: () {}),
                ],
              ),
              const SizedBox(height: 10),

              // Input + botón enviar
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Campo de texto
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: _focusNode.hasFocus
                              ? const Color(0xFF2DA679)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, bottom: 10),
                            child: GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Color(0xFF103B40),
                                  size: 22),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _inputCtrl,
                              focusNode: _focusNode,
                              maxLines: 4,
                              minLines: 1,
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => _sendMessage(),
                              style: const TextStyle(
                                  color: Color(0xFF103B40),
                                  fontSize: 14),
                              decoration: const InputDecoration(
                                hintText: 'Escribe tu mensaje aquí...',
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 14),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Botón enviar
                  GestureDetector(
                    onTap: hasText ? _sendMessage : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: hasText
                            ? const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF2DA679),
                                  Color(0xFF0F5944)
                                ],
                              )
                            : const LinearGradient(colors: [
                                Color(0xFFCCCCCC),
                                Color(0xFFBBBBBB)
                              ]),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: hasText
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF2DA679)
                                      .withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : [],
                      ),
                      child: const Icon(Icons.send_rounded,
                          color: Colors.white, size: 22),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── MESSAGE BUBBLE ────────────────────────────────────────────────────────────
class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final ChatUser chatUser;

  const _MessageBubble(
      {required this.message, required this.chatUser});

  String _statusLabel(MessageStatus s) {
    switch (s) {
      case MessageStatus.sent:
        return 'Enviado';
      case MessageStatus.delivered:
        return 'Entregado';
      case MessageStatus.read:
        return 'Leído';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSent = message.isSent;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar solo en mensajes recibidos
          if (!isSent) ...[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: const Color(0xFF96D9C0), width: 2),
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(chatUser.avatar),
                backgroundColor: const Color(0xFF96D9C0),
              ),
            ),
            const SizedBox(width: 8),
          ],

          // Burbuja
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            child: Column(
              crossAxisAlignment: isSent
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Burbuja de mensaje
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: isSent
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF2DA679),
                              Color(0xFF0F5944)
                            ],
                          )
                        : null,
                    color: isSent ? null : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isSent ? 20 : 4),
                      bottomRight: Radius.circular(isSent ? 4 : 20),
                    ),
                    border: isSent
                        ? null
                        : Border.all(
                            color: const Color(0xFF96D9C0),
                            width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color:
                          isSent ? Colors.white : const Color(0xFF103B40),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),

                // Hora + estado
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSent) ...[
                        if (message.status != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: message.status == MessageStatus.read
                                  ? const Color(0xFF2DA679)
                                  : const Color(0xFFE0E0E0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _statusLabel(message.status!),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: message.status == MessageStatus.read
                                    ? Colors.white
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        message.timestamp,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (isSent) const SizedBox(width: 4),
        ],
      ),
    );
  }
}

// ── DATE DIVIDER ──────────────────────────────────────────────────────────────
class _DateDivider extends StatelessWidget {
  final String label;
  const _DateDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: const Color(0xFF96D9C0), width: 1.5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 1)),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
              color: Color(0xFF103B40),
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

// ── TYPING INDICATOR ──────────────────────────────────────────────────────────
class _TypingIndicator extends StatefulWidget {
  final ChatUser user;
  const _TypingIndicator({required this.user});

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _dots;
  late List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _dots = List.generate(
        3,
        (_) => AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 400)));
    _anims = _dots
        .map((c) =>
            Tween<double>(begin: 0, end: -6).animate(
                CurvedAnimation(parent: c, curve: Curves.easeInOut)))
        .toList();
    for (int i = 0; i < _dots.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150),
          () => _dots[i].repeat(reverse: true));
    }
  }

  @override
  void dispose() {
    for (final d in _dots) d.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(20),
        ),
        border: Border.all(color: const Color(0xFF96D9C0), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          3,
          (i) => AnimatedBuilder(
            animation: _anims[i],
            builder: (_, __) => Transform.translate(
              offset: Offset(0, _anims[i].value),
              child: Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: const BoxDecoration(
                  color: Color(0xFF2DA679),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── WIDGETS AUXILIARES ────────────────────────────────────────────────────────
class _HeaderActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;

  const _HeaderActionBtn({
    required this.label,
    required this.icon,
    required this.bg,
    required this.fg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: fg),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyle(
                    color: fg,
                    fontWeight: FontWeight.w600,
                    fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _QuickBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickBtn(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF103B40)),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    color: Color(0xFF103B40),
                    fontWeight: FontWeight.w500,
                    fontSize: 13)),
          ],
        ),
      ),
    );
  }
}