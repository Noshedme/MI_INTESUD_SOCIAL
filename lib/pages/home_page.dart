import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Fondo gris claro de la captura
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                _buildPostInput(),
                const SizedBox(height: 20),
                _buildFeedCard(), // Tarjeta de Juan Pérez completa
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // 1. ENCABEZADO: Verde con bordes redondeados, buscador y TU LOGO
  Widget _buildHeader() {
    return Container(
      // Reducimos el padding vertical para evitar desbordamiento en la pantalla
      padding: const EdgeInsets.fromLTRB(16, 45, 16, 20),
      decoration: const BoxDecoration(
        color: Color(0xFF1A5235), // Verde institucional
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // --- AQUÍ ESTÁ TU LOGO DEL PANDA ---
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2), // Fondo sutil
                      borderRadius: BorderRadius.circular(10),
                      // Usamos DecorationImage para mostrar tu logo cuadrado
                      image: const DecorationImage(
                        image: AssetImage('assets/images/logo_panda.png'), // Ruta a tu imagen
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("MI INTESUD SOCIAL", 
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("Comunidad Institucional", 
                        style: TextStyle(color: Colors.white70, fontSize: 10)),
                    ],
                  ),
                ],
              ),
              const Stack(
                children: [
                  Icon(Icons.notifications_none, color: Colors.white, size: 28),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.red,
                      child: Text("3", style: TextStyle(color: Colors.white, fontSize: 8)),
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          TextField(
            decoration: InputDecoration(
              hintText: "Buscar publicaciones, personas, eventos...",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 2. INPUT DE POST: Con botones de Tendencias y Multimedia
  Widget _buildPostInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey, // Placeholder para tu foto
                radius: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F3F4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "¿Qué está pasando en la universidad?",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildSmallTag(Icons.trending_up, "Tendencias"),
                  const SizedBox(width: 6),
                  _buildSmallTag(Icons.add, "Multimedia"),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D7A58), // Verde del botón "Publicar"
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  minimumSize: const Size(0, 32), // Altura fija para el botón
                ),
                child: const Text("Publicar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 3. TARJETA DE FEED: Diseño de Juan Pérez con interacciones
  Widget _buildFeedCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE9F5F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.blueGrey, // Placeholder foto Juan Pérez
                radius: 20,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Juan Pérez", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text("AVISO OFICIAL • DOCENTE", 
                      style: TextStyle(fontSize: 9, color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                    Text("Hace 2 horas", style: TextStyle(fontSize: 9, color: Colors.grey)),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.more_horiz, color: Colors.grey, size: 20), onPressed: () {}),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Eventos de Base de Datos implementarán Teoría de Base de Datos y eventos de modo.",
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                const Icon(Icons.favorite_border, size: 14, color: Color(0xFF2D7A58)),
                const SizedBox(width: 4),
                const Text("150", style: TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(width: 12),
                const Text("23 comentarios", style: TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(width: 12),
                const Text("12 compartidos", style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          const Divider(height: 1),
          // Botones de Acción corregidos para evitar desbordamiento
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(Icons.favorite_border, "Me gusta"),
              _buildActionButton(Icons.chat_bubble_outline, "Comentar"),
              _buildActionButton(Icons.share_outlined, "Compartir"),
            ],
          ),
        ],
      ),
    );
  }

  // Widgets Auxiliares
  Widget _buildSmallTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F5F0), // Fondo verde suave
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: const Color(0xFF1A5235)),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Color(0xFF1A5235), fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Expanded( // Usamos Expanded para que los botones compartan el espacio y no se desborden horizontalmente
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 16, color: Colors.black54),
        label: Text(label, style: const TextStyle(color: Colors.black54, fontSize: 11)),
        style: TextButton.styleFrom(padding: EdgeInsets.zero), // Reducimos padding interno
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF1A5235), // Verde seleccionado
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      items: [
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            decoration: BoxDecoration(color: const Color(0xFFE9F5F0), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.home, size: 20), // Icono de inicio
          ),
          label: "Inicio",
        ),
        // CORRECCIÓN: 'Icons.chat_outline' no existe, usamos 'Icons.chat_bubble_outline'
        const BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline, size: 20), label: "Mensajes"),
        const BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined, size: 20), label: "Eventos"),
        const BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 20), label: "Perfil"),
      ],
    );
  }
}