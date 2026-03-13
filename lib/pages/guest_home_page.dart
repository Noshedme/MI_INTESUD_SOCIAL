import 'package:flutter/material.dart';
import 'guest_store_page.dart'; // Importación actualizada

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  // Índice para controlar la navegación inferior (0: Inicio, 1: Tienda)
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Lista de pantallas disponibles
    final List<Widget> _pages = [
      _buildHomeContent(), // Contenido del Muro Social
      const GuestStorePage(),   // Contenido de la Tienda (Nombre actualizado)
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      // Muestra la pantalla según el índice seleccionado
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- CONTENIDO DEL MURO SOCIAL (INICIO) ---
  Widget _buildHomeContent() {
    return Column(
      children: [
        _buildGuestHeader(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              _buildPromoBanner(),
              const SizedBox(height: 15),
              _buildExploringBanner(),
              const SizedBox(height: 25),
              _buildOfficialPost(), 
              const SizedBox(height: 15),
              _buildSoftwarePost(), 
              const SizedBox(height: 15),
              _buildLockedPost(),   
              const SizedBox(height: 20),
              _buildRegisterCTA(),  
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  // 1. CABECERA (LOGO PANDA + REGISTRARSE)
  Widget _buildGuestHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: const BoxDecoration(
        color: Color(0xFF1A5235),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/logo1.png', width: 35, height: 35),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("MI INTESUD", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
                  Text("👁 Modo Invitado", 
                    style: TextStyle(color: Colors.white70, fontSize: 10)),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1A5235),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text("Registrarse", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // 2. BANNER PROMOCIÓN EXCLUSIVA (20%)
  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFA8D5BA).withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const Text("✨ ¡PROMOCIÓN EXCLUSIVA!", 
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A5235), letterSpacing: 1.1)),
          const SizedBox(height: 5),
          const Text("Regístrate AHORA y obtén 20% DE DESCUENTO en tu matrícula. ¡Oferta por tiempo limitado!", 
            textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black87)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(horizontal: 25),
            ),
            child: const Text("¡Quiero mi descuento!", style: TextStyle(fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }

  // 3. BANNER EXPLORANDO COMO INVITADO (DEGRADADO VERDE)
  Widget _buildExploringBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A5235), Color(0xFF2D7A58)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.visibility, color: Colors.white, size: 28),
              SizedBox(width: 15),
              Text("Explorando como Invitado", 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const SizedBox(height: 12),
          const Text("Aquí puedes ver publicaciones de nuestras carreras, eventos institucionales e información de marketing.", 
            style: TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 8),
          const Text("⚠️ Funciones limitadas: No puedes comprar en la tienda ni ver contenido de estudiantes.", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1A5235),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Registrarme Ahora", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Ya soy estudiante", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSoftwarePost() {
    return _baseCard(
      title: "Desarrollo de Software",
      subtitle: "Carrera de Desarrollo de Software",
      content: "💻 Aprende las tecnologías más demandadas del mercado: React, Node.js, Python, y más. Nuestros laboratorios cuentan con equipamiento de última generación. ¡Ven a visitarnos!",
      image: "assets/images/computadora.webp",
      avatarImage: "assets/images/desarrollodesoftware.png",
      isLocked: false,
    );
  }

  Widget _buildLockedPost() {
    return _baseCard(
      title: "María González",
      subtitle: "Estudiante de 4to Semestre",
      content: "Privado.",
      avatarImage: "assets/images/mariagonzales.webp",
      isLocked: true,
    );
  }

  Widget _buildRegisterCTA() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A5235), Color(0xFF0D2B1C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const Icon(Icons.school_outlined, color: Colors.white, size: 45),
          const SizedBox(height: 15),
          const Text("¿Listo para Comenzar?", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 8),
          const Text("Regístrate como invitado y explora todo lo que INTESUD tiene para ofrecerte.", 
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 10),
          const Text("¡No olvides tu 20% de descuento especial!", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text("Registrarme Gratis", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2D7A58), width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text("Ya soy Estudiante", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _baseCard({required String title, required String subtitle, required String content, String? image, String? avatarImage, bool isLocked = false}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFE1E8E5), 
                radius: 20,
                backgroundImage: avatarImage != null ? AssetImage(avatarImage) : null,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
              const Spacer(),
              const Icon(Icons.verified_outlined, color: Color(0xFF1A5235), size: 18),
            ],
          ),
          const SizedBox(height: 15),
          Text(content, style: const TextStyle(fontSize: 12.5, color: Colors.black87, height: 1.4)),
          const SizedBox(height: 15),
          if (isLocked)
            Container(
              height: 150, width: double.infinity,
              decoration: BoxDecoration(color: const Color(0xFFF8FBF9), borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.lock_outline, size: 45, color: Color(0xFF1A5235)),
            )
          else if (image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(image, fit: BoxFit.cover, width: double.infinity),
            ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _postAction(Icons.favorite_border, "189"),
              _postAction(Icons.chat_bubble_outline, "34"),
              const Icon(Icons.share_outlined, size: 20, color: Colors.grey),
            ],
          )
        ],
      ),
    );
  }

  Widget _postAction(IconData icon, String count) {
    return Row(children: [Icon(icon, size: 20, color: Colors.grey), const SizedBox(width: 6), Text(count, style: const TextStyle(color: Colors.grey, fontSize: 12))]);
  }

  Widget _buildOfficialPost() {
    return _baseCard(
      title: "INTESUD Oficial", 
      subtitle: "Cuenta Institucional", 
      content: "🎓 ¡MATRÍCULA ABIERTA 2026! Aprovecha nuestro 20% de descuento en todas las carreras. Forma parte de la mejor institución educativa del sur. ¡No te quedes sin tu cupo!",
      avatarImage: "assets/images/intesudoficial.webp",
    );
  }

  // --- BARRA DE NAVEGACIÓN INFERIOR ---
  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        // El perfil (índice 3) no redirige a nada
        if (index == 3) return;

        setState(() {
          _currentIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF1A5235),
      unselectedItemColor: Colors.grey,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_filled), 
          label: "Inicio"
        ),
        
        // TIENDA CON OJO PEQUEÑO ARRIBA
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              const Icon(Icons.shopping_bag_outlined),
              Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.remove_red_eye, size: 10, color: Colors.grey[700]),
              ),
            ],
          ),
          label: "Tienda",
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined), 
          label: "Eventos"
        ),

        // PERFIL CON CANDADO PEQUEÑO ARRIBA
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              const Icon(Icons.person_outline),
              Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.lock, size: 10, color: Colors.red[900]),
              ),
            ],
          ),
          label: "Perfil",
        ),
      ],
    );
  }
}