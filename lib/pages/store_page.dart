import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    // Nota: No usamos Scaffold para mantener el menú inferior del HomePage
    return Column(
      children: [
        _buildStoreHeader(),
        _buildCategoryFilters(),
        Expanded(
          child: ListView( // Usamos ListView para poder poner el banner arriba del grid
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildGuestInfoBanner(), // El banner de "Vista de Invitado"
              const SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true, // Importante dentro de ListView
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.62, // Ajustado para el nuevo botón de "Bloqueado"
                children: [
                  _buildLockedProductItem("Polera Oficial INTESUD", "12.990", "assets/images/polera.jpg", "4.8 (45)"),
                  _buildLockedProductItem("Tomatodo Térmico", "8.990", "assets/images/tomatodo.jpg", "4.9 (78)"),
                  _buildLockedProductItem("Pase Bus Mensual", "25.000", "assets/images/paisaje.jpg", "5.0 (120)"),
                  _buildLockedProductItem("Mochila INTESUD", "19.990", "assets/images/mochilaintesud.webp", "4.7 (34)"),
                  _buildLockedProductItem("Cuaderno Institucional", "2.990", "assets/images/logo1.jpeg", "4.5 (89)"),
                  _buildLockedProductItem("Buzo Deportivo", "24.990", "assets/images/Buzosdeportivos.webp", "4.6 (56)"),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  // 1. HEADER CON SUBTÍTULO DE INVITADO
  Widget _buildStoreHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      decoration: const BoxDecoration(
        color: Color(0xFF1A5235),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/logo1.png', width: 35, height: 35),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("TIENDA INTESUD", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      Text("Solo Visualización - Invitado", style: TextStyle(color: Colors.white70, fontSize: 10)),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.shopping_cart_outlined, color: Colors.white70, size: 28),
            ],
          ),
          const SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              hintText: "Buscar productos...",
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  // 2. BANNER DE INFORMACIÓN DE INVITADO (IDÉNTICO A TU EJEMPLO)
  Widget _buildGuestInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2D7A58), Color(0xFF1A5235)]),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.lock_outline, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Text("Vista de Invitado - Solo Visualización", 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text("Puedes explorar todos nuestros productos pero no realizar compras. Regístrate para acceder a la tienda completa.",
            style: TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
            child: const Row(
              children: [
                Icon(Icons.stars, color: Colors.orange, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text("¡INSCRÍBETE Y MATRÍCULATE YA! Obtén 20% de descuento en este momento", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1A5235),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              minimumSize: const Size(150, 35),
            ),
            child: const Text("Registrarme Ahora", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  // 3. TARJETA DE PRODUCTO CON BOTÓN BLOQUEADO
  Widget _buildLockedProductItem(String name, String price, String img, String rating) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(img, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                const Text("Centro de Alumnos", style: TextStyle(color: Colors.grey, fontSize: 9)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 12),
                    const SizedBox(width: 4),
                    Text(rating, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Text("\$$price", style: const TextStyle(color: Color(0xFF1A5235), fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 8),
                // BOTÓN BLOQUEADO (GRIS CON CANDADO)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, size: 14, color: Colors.blueGrey.shade600),
                      const SizedBox(width: 8),
                      Text("Bloqueado", style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 11, fontWeight: FontWeight.bold)),
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

  Widget _buildCategoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      child: Row(
        children: [
          _buildChip("Todo", true, Icons.grid_view),
          _buildChip("Ropa", false, Icons.checkroom),
          _buildChip("Accesorios", false, Icons.star_border),
          _buildChip("Transporte", false, Icons.directions_bus),
          _buildChip("Útiles", false, Icons.edit_note),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1A5235) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: isSelected ? Colors.white : const Color(0xFF1A5235)),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}