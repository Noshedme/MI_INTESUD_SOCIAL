import 'package:flutter/material.dart';
import 'package:mi_intesud_social/screens/store_screen.dart';
import 'package:mi_intesud_social/screens/home_screen.dart';
import 'package:mi_intesud_social/screens/settings_screen.dart';
import 'package:mi_intesud_social/screens/edit_profile_screen.dart';
import 'package:mi_intesud_social/pages/eventos_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 20),
                _buildContent(),
                const SizedBox(height: 100),
              ],
            ),
          ),
          _buildBottomNav(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF103B40),
            Color(0xFF0F5944),
            Color(0xFF2DA679),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconButton(Icons.arrow_back, () {
                  Navigator.pop(context);
                }),
                const Text(
                  "Mi Perfil",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _iconButton(Icons.settings, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              const CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1638953052562-21e347a142bf?w=500",
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2DA679),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            "María López",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Estudiante de Gastronomía",
            style: TextStyle(color: Color(0xFF96D9C0)),
          ),
          const SizedBox(height: 5),
          Text(
            "@$username",
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _StatItem("156", "Publicaciones"),
              _StatItem("892", "Seguidores"),
              _StatItem("234", "Siguiendo"),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF103B40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                    child: const Text("Editar Perfil"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Compartir"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _infoCard(),
          const SizedBox(height: 15),
          _bioCard(),
        ],
      ),
    );
  }

  Widget _infoCard() {
    return _cardContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Información Personal",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF103B40),
            ),
          ),
          SizedBox(height: 15),
          _InfoRow(Icons.email, "maria.lopez@intesud.edu"),
          _InfoRow(Icons.phone, "+593 99 123 4567"),
          _InfoRow(Icons.location_on, "Quito, Ecuador"),
          _InfoRow(Icons.calendar_month, "Miembro desde Enero 2024"),
        ],
      ),
    );
  }

  Widget _bioCard() {
    return _cardContainer(
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sobre mí",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF103B40),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Apasionada por la gastronomía y la innovación culinaria. Estudiante dedicada en INTESUD.",
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _cardContainer(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, "Inicio", false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(username: username),
                ),
              );
            }),
            _navItem(Icons.event, "Eventos", false, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventosScreen(),
                ),
              );
            }),
            _navItem(Icons.message, "Mensajes", false, () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Mensajes próximamente")),
              );
            }),
            _navItem(Icons.store, "Tienda", false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreScreen(username: username),
                ),
              );
            }),
            _navItem(Icons.person, "Perfil", true, () {}),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF2DA679) : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? const Color(0xFF2DA679) : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;

  const _StatItem(this.number, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF96D9C0),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2DA679), size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}