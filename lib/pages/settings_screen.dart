import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff103B40),
                  Color(0xff0F5944),
                  Color(0xff2DA679),
                ],
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Configuración",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Personaliza tu experiencia",
                      style: TextStyle(
                        color: Color(0xff96D9C0),
                        fontSize: 12,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                buildSectionTitle("Cuenta y Perfil"),
                buildTile(
                  icon: Icons.person,
                  title: "Editar Perfil",
                  subtitle: "Actualiza tu información personal",
                ),
                buildTile(
                  icon: Icons.lock,
                  title: "Cambiar Contraseña",
                  subtitle: "Actualiza tu contraseña de acceso",
                ),
                buildTile(
                  icon: Icons.shield,
                  title: "Privacidad y Seguridad",
                  subtitle: "Controla quién ve tu información",
                ),
                const SizedBox(height: 20),
                buildSectionTitle("Notificaciones"),
                buildTile(
                  icon: Icons.notifications,
                  title: "Preferencias de Notificaciones",
                  subtitle: "Gestiona qué notificaciones recibir",
                ),
                const SizedBox(height: 20),
                buildSectionTitle("Apariencia"),
                buildTile(
                  icon: Icons.palette,
                  title: "Tema de la Aplicación",
                  subtitle: "Claro, oscuro o automático",
                ),
                buildTile(
                  icon: Icons.language,
                  title: "Idioma",
                  subtitle: "Español (predeterminado)",
                ),
                const SizedBox(height: 20),
                buildSectionTitle("Ayuda y Soporte"),
                buildTile(
                  icon: Icons.help,
                  title: "Centro de Ayuda",
                  subtitle: "Preguntas frecuentes y tutoriales",
                ),
                buildTile(
                  icon: Icons.description,
                  title: "Términos y Condiciones",
                  subtitle: "Lee nuestras políticas",
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    title: const Text(
                      "Eliminar Cuenta",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text("Esta acción es permanente"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/welcome",
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Cerrar Sesión"),
                ),
                const SizedBox(height: 30),
                const Center(
                  child: Column(
                    children: [
                      Text(
                        "MI INTESUD SOCIAL",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Versión 1.0.0",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "© 2026 • 4 Semestre • Escuela Desarrollo de Software",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff103B40),
            Color(0xff0F5944),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xff2DA679),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xff103B40),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}