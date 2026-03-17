import 'package:flutter/material.dart';

// ── MODELO ────────────────────────────────────────────────────────────────────
class Comment {
  final int id;
  final String authorName;
  final String authorAvatar;
  final String content;
  final String timestamp;
  int likes;
  bool isLiked;

  Comment({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.content,
    required this.timestamp,
    required this.likes,
    this.isLiked = false,
  });
}

// ── DATOS MOCK ────────────────────────────────────────────────────────────────
List<Comment> buildMockComments() => [
      Comment(
        id: 1,
        authorName: 'Carlos Ruiz',
        authorAvatar:
            'https://images.unsplash.com/photo-1762753674498-73ec49feafc4?w=200',
        content: '¡Excelente información! Muy útil para todos.',
        timestamp: 'Hace 1 hora',
        likes: 12,
      ),
      Comment(
        id: 2,
        authorName: 'Ana López',
        authorAvatar:
            'https://images.unsplash.com/photo-1638953052562-21e347a142bf?w=200',
        content: 'Gracias por compartir. ¿Habrá más eventos similares?',
        timestamp: 'Hace 30 min',
        likes: 8,
        isLiked: true,
      ),
      Comment(
        id: 3,
        authorName: 'Pedro Sánchez',
        authorAvatar:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
        content: 'Me interesa mucho este tema, espero poder asistir',
        timestamp: 'Hace 15 min',
        likes: 5,
      ),
    ];

// ── PANTALLA ──────────────────────────────────────────────────────────────────
class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final List<Comment> _comments = buildMockComments();
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleLike(int id) {
    setState(() {
      final c = _comments.firstWhere((c) => c.id == id);
      c.isLiked = !c.isLiked;
      c.likes += c.isLiked ? 1 : -1;
    });
  }

  void _addComment() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _comments.add(Comment(
        id: _comments.length + 1,
        authorName: 'Tú',
        authorAvatar:
            'https://images.unsplash.com/photo-1557353425-09253747c2bf?w=200',
        content: text,
        timestamp: 'Justo ahora',
        likes: 0,
      ));
      _inputController.clear();
    });

    // Scroll al final
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // ── HEADER ──────────────────────────────────────────────
          _buildHeader(),

          // ── POST ORIGINAL ────────────────────────────────────────
          _buildOriginalPost(),

          // ── COMENTARIOS ──────────────────────────────────────────
          Expanded(
            child: _comments.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    itemCount: _comments.length,
                    itemBuilder: (context, i) =>
                        _CommentCard(
                          comment: _comments[i],
                          onLike: () => _toggleLike(_comments[i].id),
                        ),
                  ),
          ),

          // ── INPUT COMENTARIO ─────────────────────────────────────
          _buildCommentInput(),
        ],
      ),
    );
  }

  // ── HEADER ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF103B40), Color(0xFF0F5944)],
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
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Comentarios',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text(
                    '${_comments.length} comentarios en esta publicación',
                    style: const TextStyle(
                        color: Color(0xFF96D9C0), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── POST ORIGINAL ─────────────────────────────────────────────────────────
  Widget _buildOriginalPost() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFF96D9C0), width: 3),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Autor
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color(0xFF96D9C0), width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1762753674498-73ec49feafc4?w=200'),
                    backgroundColor: Color(0xFF96D9C0),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Juan Pérez',
                        style: TextStyle(
                            color: Color(0xFF103B40),
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text('AVISO OFICIAL • DOCENTE',
                        style:
                            TextStyle(color: Colors.grey, fontSize: 12)),
                    Text('Hace 2 horas',
                        style:
                            TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Contenido
            const Text(
              'Eventos de Base de Datos implementarán Teoría de Base de Datos y eventos de modo.',
              style: TextStyle(
                  color: Color(0xFF103B40), fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 14),

            // Stats
            Row(
              children: [
                _StatChip(
                    icon: Icons.favorite_rounded,
                    label: '150 Me gusta'),
                const SizedBox(width: 16),
                _StatChip(
                    icon: Icons.chat_bubble_rounded,
                    label: '${_comments.length} Comentarios'),
                const SizedBox(width: 16),
                _StatChip(
                    icon: Icons.share_rounded, label: '12 Compartidos'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── EMPTY STATE ───────────────────────────────────────────────────────────
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF96D9C0).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chat_bubble_outline_rounded,
                color: Color(0xFF2DA679), size: 32),
          ),
          const SizedBox(height: 16),
          const Text('Sé el primero en comentar',
              style: TextStyle(
                  color: Color(0xFF103B40),
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const SizedBox(height: 6),
          const Text('Comparte tu opinión sobre esta publicación',
              style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  // ── INPUT COMENTARIO ──────────────────────────────────────────────────────
  Widget _buildCommentInput() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(color: Color(0xFFD0F0E4), width: 2)),
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
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Avatar del usuario
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color(0xFF96D9C0), width: 2),
                ),
                child: const CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1638953052562-21e347a142bf?w=200'),
                  backgroundColor: Color(0xFF96D9C0),
                ),
              ),
              const SizedBox(width: 10),

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
                      // Emoji btn
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 10),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.emoji_emotions_outlined,
                              color: Colors.grey, size: 22),
                        ),
                      ),
                      // Input
                      Expanded(
                        child: TextField(
                          controller: _inputController,
                          focusNode: _focusNode,
                          maxLines: 4,
                          minLines: 1,
                          onChanged: (_) => setState(() {}),
                          onSubmitted: (_) => _addComment(),
                          style: const TextStyle(
                              color: Color(0xFF103B40), fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'Escribe un comentario...',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
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
                onTap: _inputController.text.trim().isNotEmpty
                    ? _addComment
                    : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: _inputController.text.trim().isNotEmpty
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF2DA679),
                              Color(0xFF0F5944),
                            ],
                          )
                        : const LinearGradient(
                            colors: [Color(0xFFCCCCCC), Color(0xFFBBBBBB)]),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _inputController.text.trim().isNotEmpty
                        ? [
                            BoxShadow(
                              color: const Color(0xFF2DA679).withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            )
                          ]
                        : [],
                  ),
                  child: const Icon(Icons.send_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── COMMENT CARD ──────────────────────────────────────────────────────────────
class _CommentCard extends StatelessWidget {
  final Comment comment;
  final VoidCallback onLike;

  const _CommentCard({required this.comment, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: const Color(0xFF96D9C0), width: 2),
            ),
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(comment.authorAvatar),
              backgroundColor: const Color(0xFF96D9C0),
            ),
          ),
          const SizedBox(width: 10),

          // Contenido
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Burbuja
                Container(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2)),
                    ],
                    border: Border.all(
                        color: const Color(0xFFF0F0F0), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.authorName,
                        style: const TextStyle(
                            color: Color(0xFF103B40),
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        comment.content,
                        style: const TextStyle(
                            color: Color(0xFF103B40),
                            fontSize: 13,
                            height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),

                // Acciones bajo la burbuja
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      Text(comment.timestamp,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 11)),
                      const SizedBox(width: 16),

                      // Like
                      GestureDetector(
                        onTap: onLike,
                        child: Row(
                          children: [
                            Icon(
                              comment.isLiked
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 15,
                              color: comment.isLiked
                                  ? const Color(0xFF2DA679)
                                  : Colors.grey,
                            ),
                            if (comment.likes > 0) ...[
                              const SizedBox(width: 3),
                              Text(
                                '${comment.likes}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: comment.isLiked
                                        ? const Color(0xFF2DA679)
                                        : Colors.grey),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Responder
                      GestureDetector(
                        onTap: () {},
                        child: const Text('Responder',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── STAT CHIP ─────────────────────────────────────────────────────────────────
class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: const Color(0xFF2DA679)),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}