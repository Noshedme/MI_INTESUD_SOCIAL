import 'package:flutter/material.dart';

// ==========================================
// 1. EL "MOLDE" DE NUESTROS EVENTOS (Datos reales)
// ==========================================
class Evento {
  String dia;
  String mes;
  String etiqueta;
  int cantidadAsistentes; // Cambiado a número (int) para poder sumar y restar
  String titulo;
  String descripcion;
  bool confirmado; // Para saber si el usuario ya le dio al botón

  Evento({
    required this.dia,
    required this.mes,
    required this.etiqueta,
    required this.cantidadAsistentes,
    required this.titulo,
    required this.descripcion,
    this.confirmado = false, // Por defecto nadie ha confirmado aún
  });
}

// ==========================================
// 2. TU PANTALLA AHORA TIENE MEMORIA (StatefulWidget)
// ==========================================
class EventosScreen extends StatefulWidget {
  const EventosScreen({super.key});

  @override
  State<EventosScreen> createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  // 🎨 Colores institucionales
  final Color verdeOscuro = const Color(0xFF064B3B);
  final Color verdeClaro = const Color(0xFF268E65);
  final Color fondoGris = const Color(0xFFF4F6F5);

  // 📝 NUESTRA BASE DE DATOS LOCAL (Lista de eventos iniciales)
  List<Evento> misEventos = [
    Evento(
      dia: '20',
      mes: 'OCTUBRE',
      etiqueta: 'Académico',
      cantidadAsistentes: 45, // Ahora es un número matemático
      titulo: 'Examen Final - Bases de Datos',
      descripcion: 'Examen: Bases de Datos Implementarán Teoría para el día 30 de Octubre',
    ),
    Evento(
      dia: '20',
      mes: 'OCTUBRE',
      etiqueta: 'Taller',
      cantidadAsistentes: 30, // Ahora es un número matemático
      titulo: 'Seminario de Programación',
      descripcion: 'Taller práctico sobre desarrollo web moderno con React y Node.js',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondoGris,
      appBar: AppBar(
        backgroundColor: verdeOscuro,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Eventos', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text('${misEventos.length} próximos eventos', style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
            onPressed: () {},
          ),
          // 🚫 EL BOTÓN DE "+" FUE ELIMINADO DE AQUÍ
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _crearTarjetaSuperior(),
            const SizedBox(height: 20),
            
            // 🔄 MAGIA: Dibujamos las tarjetas automáticamente leyendo la lista
            ...misEventos.map((evento) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _crearTarjetaEvento(evento),
            )),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 🧩 WIDGETS Y FUNCIONES DE LA PANTALLA
  // ==========================================

  Widget _crearTarjetaSuperior() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: verdeOscuro,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white54, width: 1),
            ),
            child: const Column(
              children: [
                Text('6', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                Text('MAR', style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hoy es viernes', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Tienes ${misEventos.length} eventos programados este mes', style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // La tarjeta ahora recibe un OBJETO Evento con datos reales
  Widget _crearTarjetaEvento(Evento evento) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 70,
              decoration: BoxDecoration(
                color: verdeClaro,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(evento.dia, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(evento.mes, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(evento.etiqueta, style: const TextStyle(color: Colors.teal, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            // Mostramos el número actualizado seguido de la palabra "asistentes"
                            Text('${evento.cantidadAsistentes} asistentes', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(evento.titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 4),
                    Text(evento.descripcion, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // Si está confirmado se pone rojo oscuro (para cancelar), si no, es verde
                              backgroundColor: evento.confirmado ? Colors.red.shade400 : verdeClaro,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            // LÓGICA DE CONFIRMAR / CANCELAR ASISTENCIA
                            onPressed: () {
                              setState(() {
                                if (evento.confirmado) {
                                  // Si ya estaba confirmado, cancelamos y restamos 1
                                  evento.confirmado = false;
                                  evento.cantidadAsistentes--;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Asistencia cancelada ❌'), backgroundColor: Colors.red),
                                  );
                                } else {
                                  // Si no estaba confirmado, confirmamos y sumamos 1
                                  evento.confirmado = true;
                                  evento.cantidadAsistentes++;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('¡Asistencia confirmada para ${evento.titulo}! ✅'), backgroundColor: verdeOscuro),
                                  );
                                }
                              });
                            },
                            // El texto cambia dependiendo del estado
                            child: Text(
                              evento.confirmado ? 'Cancelar Asistencia' : 'Confirmar Asistencia', 
                              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: verdeClaro),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            _mostrarDetallesEvento(context, evento);
                          },
                          child: const Text('Detalles', style: TextStyle(color: Colors.black87, fontSize: 12)),
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
    );
  }

  // ==========================================
  // 🚀 FUNCIONES DE LOS BOTONES REALES
  // ==========================================

  // Muestra la ventana emergente con los detalles completos
  void _mostrarDetallesEvento(BuildContext context, Evento evento) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(evento.titulo, style: TextStyle(color: verdeOscuro, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('📅 Fecha: ${evento.dia} de ${evento.mes}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('👥 Participantes: ${evento.cantidadAsistentes}'),
                Text('🏷️ Tipo: ${evento.etiqueta}'),
                const SizedBox(height: 15),
                const Text('Descripción:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(evento.descripcion),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cerrar', style: TextStyle(color: verdeClaro, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}