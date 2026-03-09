import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String nombre;
  final String email;
  final String rol;

  const HomePage({
    super.key,
    required this.nombre,
    required this.email,
    required this.rol,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MI INTESUD SOCIAL"),
        backgroundColor: const Color(0xFF467B79),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.person,
                size: 80,
                color: Color(0xFF467B79),
              ),

              const SizedBox(height: 20),

              Text(
                "Bienvenido $nombre",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Correo: $email",
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 5),

              Text(
                "Rol: $rol",
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF467B79),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cerrar sesión"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}