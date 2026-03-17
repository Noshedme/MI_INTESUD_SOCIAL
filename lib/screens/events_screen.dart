import 'package:flutter/material.dart';

// ── MODELO ────────────────────────────────────────────────────────────────────
class Event {
  final int id;
  final int day;
  final String month;
  final String title;
  final String description;
  final String? location;
  final String? time;
  final String? category;
  final int? attendees;
  final Color categoryColor;

  const Event({
    required this.id,
    required this.day,
    required this.month,
    required this.title,
    required this.description,
    this.location,
    this.time,
    this.category,
    this.attendees,
    this.categoryColor = const Color(0xFF2DA679),
  });
}

// ── DATOS MOCK ────────────────────────────────────────────────────────────────
final List<Event> mockEvents = [
  const Event(
    id: 1,
    day: 20,
    month: 'OCT',
    title: 'Examen Final - Bases de Datos',
    description: 'Implementarán Teoría para el día 30 de Octubre. Traer material completo.',
    category: 'Académico',
    attendees: 45,
    categoryColor: Color(0xFF103B40),
  ),
  const Event(
    id: 2,
    day: 20,
    month: 'OCT',
    title: 'Seminario de Programación',
    description: 'Taller práctico sobre desarrollo web moderno con React y Node.js.',
    location: 'Laboratorio 3',
    time: '15:00 - 17:00',
    category: 'Taller',
    attendees: 30,
    categoryColor: Color(0xFF0F5944),
  ),
  const Event(
    id: 3,
    day: 25,
    month: 'OCT',
    title: 'Conferencia de IA',
    description: 'Seminario sobre Inteligencia Artificial y Machine Learning aplicado.',
    location: 'Auditorio Principal',
    time: '14:00 - 16:00',
    category: 'Conferencia',
    attendees: 120,
    categoryColor: Color(0xFF2DA679),
  ),
  const Event(
    id: 4,
    day: 28,
    month: 'OCT',
    title: 'Feria de Proyectos',
    description: 'Exposición de proyectos finales de todas las carreras del instituto.',
    location: 'Campus Central',
    time: '09:00 - 18:00',
    category: 'Evento',
    attendees: 200,
    categoryColor: Color(0xFF96D9C0),
  ),
];

// ── PANTALLA ──────────────────────────────────────────────────────────────────
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _headerAnim;
  late Animation<double> _fadeIn;
  int? _confirmedEvent;

  @override
  void initState() {
    super.initState();
    _headerAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _fadeIn = CurvedAnimation(parent: _headerAnim, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _headerAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final weekdays = [
      'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'
    ];
    final months = [
      'ENE', 'FEB', 'MAR', 'ABR', 'MAY', 'JUN',
      'JUL', 'AGO', 'SEP', 'OCT', 'NOV', 'DIC'
    ];
    final todayWeekday = weekdays[now.weekday - 1];
    final todayMonth = months[now.month - 1];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // ── HEADER ────────────────────────────────────────────────
          _buildHeader(),

          Expanded(
            child: FadeTransition(
              opacity: _fadeIn,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                children: [
                  // Tarjeta de hoy
                  _buildTodayCard(now, todayWeekday, todayMonth),
                  const SizedBox(height: 20),

                  // Título sección
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 22,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2DA679),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Próximos Eventos',
                        style: TextStyle(
                          color: Color(0xFF103B40),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${mockEvents.length} eventos',
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Lista de eventos
                  ...mockEvents.map((e) => _EventCard(
                        event: e,
                        isConfirmed: _confirmedEvent == e.id,
                        onConfirm: () => setState(() {
                          _confirmedEvent =
                              _confirmedEvent == e.id ? null : e.id;
                        }),
                      )),
                ],
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
          child: Row(
            children: [
              // Botón atrás
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Eventos',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    Text(
                      '${mockEvents.length} próximos eventos',
                      style: const TextStyle(
                          color: Color(0xFF96D9C0), fontSize: 13),
                    ),
                  ],
                ),
              ),
              // Filtro
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: const Icon(Icons.tune_rounded,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 8),
              // Agregar
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF2DA679),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2)),
                  ],
                ),
                child: const Icon(Icons.add_rounded,
                    color: Colors.white, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── TARJETA HOY ───────────────────────────────────────────────────────────
  Widget _buildTodayCard(DateTime now, String weekday, String month) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF103B40), Color(0xFF0F5944)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF103B40).withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 6)),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -10,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF96D9C0).withOpacity(0.12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Fecha
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Colors.white.withOpacity(0.25)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${now.day}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      Text(
                        month,
                        style: const TextStyle(
                            color: Color(0xFF96D9C0), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hoy es $weekday',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Tienes ${mockEvents.length} eventos programados este mes',
                        style: const TextStyle(
                            color: Color(0xFF96D9C0),
                            fontSize: 13,
                            height: 1.4),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: List.generate(
                          mockEvents.length > 4 ? 4 : mockEvents.length,
                          (i) => Container(
                            width: 28,
                            height: 28,
                            margin: EdgeInsets.only(right: i < 3 ? 6 : 0),
                            decoration: BoxDecoration(
                              color: mockEvents[i].categoryColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                '${mockEvents[i].day}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
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

  // ── BOTTOM NAV ────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(color: Color(0xFFE8E8E8), width: 1.5)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
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
                      .pushReplacementNamed('/feed-guest')),
              _NavBtn(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: 'Mensajes',
                  onTap: () =>
                      Navigator.of(context).pushNamed('/messages')),
              _NavBtn(
                icon: Icons.calendar_month_rounded,
                label: 'Eventos',
                isActive: true,
                onTap: () {},
              ),
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

// ── EVENT CARD ────────────────────────────────────────────────────────────────
class _EventCard extends StatefulWidget {
  final Event event;
  final bool isConfirmed;
  final VoidCallback onConfirm;

  const _EventCard({
    required this.event,
    required this.isConfirmed,
    required this.onConfirm,
  });

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.event;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTapDown: (_) => _anim.forward(),
        onTapUp: (_) => _anim.reverse(),
        onTapCancel: () => _anim.reverse(),
        child: ScaleTransition(
          scale: _scale,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: widget.isConfirmed
                    ? const Color(0xFF2DA679)
                    : const Color(0xFFE8E8E8),
                width: widget.isConfirmed ? 2 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.isConfirmed
                      ? const Color(0xFF2DA679).withOpacity(0.15)
                      : Colors.black.withOpacity(0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── FECHA (columna izquierda) ──────────────────────
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        e.categoryColor,
                        e.categoryColor.withOpacity(0.75),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(22),
                      bottomLeft: Radius.circular(22),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${e.day}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        e.month,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── CONTENIDO ─────────────────────────────────────
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge + asistentes
                        Row(
                          children: [
                            if (e.category != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color:
                                      e.categoryColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  e.category!,
                                  style: TextStyle(
                                    color: e.categoryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            if (e.attendees != null) ...[
                              const SizedBox(width: 8),
                              Icon(Icons.people_outline_rounded,
                                  size: 13, color: Colors.grey[400]),
                              const SizedBox(width: 3),
                              Text(
                                '${e.attendees}',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 11),
                              ),
                            ],
                            const Spacer(),
                            // Confirmado check
                            if (widget.isConfirmed)
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2DA679)
                                      .withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                    Icons.check_circle_rounded,
                                    color: Color(0xFF2DA679),
                                    size: 16),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Título
                        Text(
                          e.title,
                          style: const TextStyle(
                            color: Color(0xFF103B40),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Descripción
                        Text(
                          e.description,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Hora y lugar
                        if (e.time != null)
                          _InfoRow(
                              icon: Icons.access_time_rounded,
                              text: e.time!),
                        if (e.location != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: _InfoRow(
                                icon: Icons.location_on_outlined,
                                text: e.location!),
                          ),

                        const SizedBox(height: 12),

                        // Botones
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: widget.onConfirm,
                                child: AnimatedContainer(
                                  duration:
                                      const Duration(milliseconds: 250),
                                  height: 38,
                                  decoration: BoxDecoration(
                                    gradient: widget.isConfirmed
                                        ? const LinearGradient(colors: [
                                            Color(0xFF0F5944),
                                            Color(0xFF103B40)
                                          ])
                                        : const LinearGradient(colors: [
                                            Color(0xFF2DA679),
                                            Color(0xFF0F5944)
                                          ]),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF2DA679)
                                            .withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.isConfirmed
                                          ? '✓ Confirmado'
                                          : 'Confirmar Asistencia',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: const Color(0xFF2DA679),
                                    width: 1.5),
                              ),
                              child: const Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFF103B40),
                                size: 20,
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
          ),
        ),
      ),
    );
  }
}

// ── INFO ROW ──────────────────────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF2DA679)),
        const SizedBox(width: 6),
        Text(text,
            style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
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
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight:
                  isActive ? FontWeight.w700 : FontWeight.normal,
              color:
                  isActive ? const Color(0xFF2DA679) : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}