import 'package:flutter/material.dart';

class GuestStorePage extends StatefulWidget {
  const GuestStorePage({super.key});

  @override
  State<GuestStorePage> createState() => _GuestStorePageState();
}

class _GuestStorePageState extends State<GuestStorePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStoreHeader(),
        _buildCategoryFilters(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildGuestInfoBanner(),
              const SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.62,
                children: [
                  _buildLockedProductItem("Polera Oficial INTESUD", "12.990", "assets/images/polera.jpg", "4.8 (45)"),
                  _buildLockedProductItem("Tomatodo Térmico", "8.990", "assets/images/tomatodo.jpg", "4.9 (78)"),
                  _buildLockedProductItem("Pase Bus Mensual", "25.000", "assets/images/pasebusmensual.jpg", "5.0 (120)"),
                  _buildLockedProductItem("Mochila INTESUD", "19.990", "assets/images/mochilaintesud.webp", "4.7 (34)"),
                  _buildLockedProductItem("Cuaderno Institucional", "2.990", "assets/images/cuadernoinstitucional.webp", "4.5 (89)"),
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

  // Header de la Tienda
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

  // Banner Informativo de Invitado
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
          const Row(
            children: [
              Icon(Icons.lock_outline, color: Colors.white, size: 24),
              SizedBox(width: 15),
              Expanded(
                child: Text("Vista de Invitado - Solo Visualización", 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text("Puedes explorar todos nuestros productos pero no realizar compras.",
            style: TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1A5235),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text("Registrarme Ahora", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  // Widget para cada producto con el botón de "Bloqueado"
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
              child: Image.asset(img, fit: BoxFit.cover, width: double.infinity,
                errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, color: Colors.grey))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text("\$$price", style: const TextStyle(color: Color(0xFF1A5235), fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, size: 12, color: Colors.blueGrey.shade400),
                      const SizedBox(width: 4),
                      const Text("Bloqueado", style: TextStyle(color: Colors.blueGrey, fontSize: 10, fontWeight: FontWeight.bold)),
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
        children: ["Todo", "Ropa", "Accesorios", "Transporte", "Útiles"].map((label) => _buildChip(label, label == "Todo")).toList(),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1A5235) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}