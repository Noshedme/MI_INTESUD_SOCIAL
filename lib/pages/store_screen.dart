import 'package:flutter/material.dart';
import 'package:mi_intesud_social/screens/profile_screen.dart';
import 'package:mi_intesud_social/screens/home_screen.dart';
import 'package:mi_intesud_social/pages/eventos_screen.dart';

class StoreScreen extends StatefulWidget {
  final String username;

  const StoreScreen({
    super.key,
    required this.username,
  });

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String selectedCategory = "Todo";

  final List<Map<String, dynamic>> products = [
    {
      "name": "Polera Oficial INTESUD",
      "description": "Polera 100% algodón con logo institucional bordado",
      "price": 12990,
      "category": "Ropa",
      "image":
          "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500",
      "seller": "Centro de Alumnos",
      "rating": 4.8,
      "reviews": 45,
      "stock": 15
    },
    {
      "name": "Tomatodo Térmico INTESUD",
      "description": "Botella térmica 500ml, mantiene temperatura 12hrs",
      "price": 8990,
      "category": "Accesorios",
      "image":
          "https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=500",
      "seller": "Centro de Alumnos",
      "rating": 4.9,
      "reviews": 78,
      "stock": 10
    },
  ];

  final List<String> categories = ["Todo", "Ropa", "Accesorios", "Útiles"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _header(),
                _categories(),
                _productList(),
                const SizedBox(height: 100),
              ],
            ),
          ),
          _bottomNav()
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF103B40),
            Color(0xFF0F5944),
            Color(0xFF2DA679),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/Logo_app.png",
                    height: 60,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.store, color: Colors.white, size: 50),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TIENDA INTESUD",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Productos Oficiales",
                        style: TextStyle(
                          color: Color(0xFF96D9C0),
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.shopping_cart, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Buscar productos...",
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _categories() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final bool active = categories[index] == selectedCategory;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = categories[index];
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? const Color(0xFF2DA679) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF96D9C0)),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: active ? Colors.white : const Color(0xFF103B40),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _productList() {
    final filteredProducts = selectedCategory == "Todo"
        ? products
        : products.where((p) => p["category"] == selectedCategory).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: filteredProducts.map((p) => _productCard(p)).toList(),
      ),
    );
  }

  Widget _productCard(Map product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            child: Image.network(
              product["image"],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product["name"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF103B40),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product["description"],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product["price"]}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F5944),
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2DA679),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text("Agregar"),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomNav() {
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
                  builder: (context) => HomeScreen(username: widget.username),
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
            _navItem(Icons.store, "Tienda", true, () {}),
            _navItem(Icons.person, "Perfil", false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(username: widget.username),
                ),
              );
            }),
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
          Icon(icon, color: isActive ? const Color(0xFF2DA679) : Colors.grey),
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
}