import 'package:flutter/material.dart';

class EventosScreen extends StatelessWidget {
  const EventosScreen({super.key});

  // 🎨 Colores exactos de tu diseño institucional
  final Color verdeOscuro = const Color(0xFF064B3B);
  final Color verdeClaro = const Color(0xFF268E65);
  final Color fondoGris = const Color(0xFFF4F6F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondoGris,
      appBar: AppBar(
        backgroundColor: verdeOscuro,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Aquí luego tus compañeros le pondrán la acción de volver
          },
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Eventos', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text('4 próximos eventos', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _crearTarjetaSuperior(),
            const SizedBox(height: 20),
            // Aquí llamamos a nuestra plantilla para crear el primer evento
            _crearTarjetaEvento(
              dia: '20',
              mes: 'OCTUBRE',
              etiqueta: 'Académico',
              asistentes: '45 asistentes',
              titulo: 'Examen Final - Bases de Datos',
              descripcion: 'Examen: Bases de Datos Implementarán Teoría para el día 30 de Octubre',
            ),
            const SizedBox(height: 16),
            // Segundo evento
            _crearTarjetaEvento(
              dia: '20',
              mes: 'OCTUBRE',
              etiqueta: 'Taller',
              asistentes: '30 asistentes',
              titulo: 'Seminario de Programación',
              descripcion: 'Taller práctico sobre desarrollo web moderno con React y Node.js',
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 🧩 WIDGETS PERSONALIZADOS (TUS PIEZAS DE LEGO)
  // ==========================================

  // 1. Tarjeta principal "Hoy es viernes"
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
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hoy es viernes', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Tienes 4 eventos programados este mes', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. Plantilla para las tarjetas de cada evento
  Widget _crearTarjetaEvento({
    required String dia,
    required String mes,
    required String etiqueta,
    required String asistentes,
    required String titulo,
    required String descripcion,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Para alinear arriba
        children: [
          // Franja verde lateral con la fecha
          Container(
            width: 70,
            decoration: BoxDecoration(
              color: verdeClaro,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente
              children: [
                const SizedBox(height: 10), // Empujar un poco hacia abajo para centrar mejor
                Text(dia, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                Text(mes, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 60), // Espacio extra para que la franja baje hasta los botones
              ],
            ),
          ),
          
          // Contenido derecho de la tarjeta
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fila de etiqueta y asistentes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(etiqueta, style: const TextStyle(color: Colors.teal, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(asistentes, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Título y descripción
                  Text(titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text(descripcion, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 16),
                  
                  // Botones inferiores
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: verdeClaro,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {},
                          child: const Text('Confirmar Asistencia', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: verdeClaro),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {},
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
    );
  }
}