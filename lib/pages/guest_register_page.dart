import 'package:flutter/material.dart';

class GuestRegisterPage extends StatefulWidget {
  const GuestRegisterPage({super.key});

  @override
  State<GuestRegisterPage> createState() => _GuestRegisterPageState();
}

class _GuestRegisterPageState extends State<GuestRegisterPage> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _schoolController = TextEditingController();

  String? _selectedCareer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A5235)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          children: [
            Image.asset('assets/images/logo1.png', width: 60, height: 60),
            const SizedBox(height: 15),
            const Text(
              "¡Regístrate como Invitado!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A5235)),
            ),
            const Text("Explora nuestra comunidad educativa", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 25),

            _buildPromoBanner(),
            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildTextField("Nombre *", "Juan", Icons.person_outline, _nameController)),
                      const SizedBox(width: 15),
                      Expanded(child: _buildTextField("Apellido *", "Pérez", Icons.person_outline, _lastNameController)),
                    ],
                  ),
                  _buildTextField("Cédula de Identidad *", "0999999999", Icons.badge_outlined, _idController),
                  
                  const Text("Carrera de Interés *", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1A5235))),
                  const SizedBox(height: 8),
                  _buildCareerDropdown(),
                  const SizedBox(height: 15),

                  _buildTextField("Colegio de Procedencia *", "Ej: Colegio Nacional", Icons.school_outlined, _schoolController),
                  _buildTextField("Correo Electrónico *", "correo@ejemplo.com", Icons.email_outlined, _emailController),
                  _buildTextField("Número de Celular *", "0999 999 999", Icons.phone_android_outlined, _phoneController),

                  const SizedBox(height: 20),

                  // BOTÓN ACTUALIZADO A "ENVIAR DATOS"
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Aquí puedes añadir un SnackBar para confirmar el envío
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Datos enviados correctamente")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A5235),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text("ENVIAR DATOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- MÉTODOS DE APOYO (BANNER, TEXTFIELD, DROPDOWN) SE MANTIENEN IGUAL ---
  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFF1A5235), borderRadius: BorderRadius.circular(15)),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, color: Colors.white, size: 18),
              SizedBox(width: 10),
              Text("¡PROMOCIÓN ESPECIAL!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          Text("Regístrate ahora y obtén 20% de descuento al matricularte", 
            style: TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1A5235))),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, color: Colors.grey, size: 20),
              filled: true,
              fillColor: const Color(0xFFF8FBF9),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: const Color(0xFFF8FBF9), borderRadius: BorderRadius.circular(12)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCareer,
          hint: const Text("Selecciona una carrera", style: TextStyle(color: Colors.grey, fontSize: 14)),
          isExpanded: true,
          items: ["Desarrollo de Software", "Contabilidad", "Enfermería", "Marketing"]
              .map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
          onChanged: (newValue) => setState(() => _selectedCareer = newValue),
        ),
      ),
    );
  }
}