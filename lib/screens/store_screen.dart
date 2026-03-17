import 'package:flutter/material.dart';

// ── MODELOS ───────────────────────────────────────────────────────────────────
class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;
  final String sellerName;
  final String sellerAvatar;
  final double rating;
  final int reviews;
  final int stock;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.sellerName,
    required this.sellerAvatar,
    required this.rating,
    required this.reviews,
    required this.stock,
    this.isFavorite = false,
  });
}

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

// ── DATOS ─────────────────────────────────────────────────────────────────────
List<Product> buildProducts() => [
      Product(
        id: 1,
        name: 'Polera Oficial INTESUD',
        description: 'Polera 100% algodón con logo institucional bordado',
        price: 12990,
        image: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500',
        category: 'clothing',
        sellerName: 'Centro de Alumnos',
        sellerAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
        rating: 4.8,
        reviews: 45,
        stock: 23,
      ),
      Product(
        id: 2,
        name: 'Tomatodo Térmico INTESUD',
        description: 'Botella térmica 500ml, mantiene temperatura 12hrs',
        price: 8990,
        image: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=500',
        category: 'accessories',
        sellerName: 'Centro de Alumnos',
        sellerAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
        rating: 4.9,
        reviews: 78,
        stock: 15,
        isFavorite: true,
      ),
      Product(
        id: 3,
        name: 'Pase Bus Mensual',
        description: 'Pase de transporte válido por 30 días',
        price: 25000,
        image: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=500',
        category: 'transport',
        sellerName: 'Administración',
        sellerAvatar: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=100',
        rating: 5.0,
        reviews: 120,
        stock: 50,
      ),
      Product(
        id: 4,
        name: 'Mochila INTESUD',
        description: 'Mochila resistente con compartimento para laptop',
        price: 19990,
        image: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
        category: 'accessories',
        sellerName: 'Centro de Alumnos',
        sellerAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
        rating: 4.7,
        reviews: 34,
        stock: 18,
      ),
      Product(
        id: 5,
        name: 'Cuaderno Institucional',
        description: 'Cuaderno universitario 100 hojas',
        price: 2990,
        image: 'https://images.unsplash.com/photo-1531346878377-a5be20888e57?w=500',
        category: 'stationery',
        sellerName: 'Librería INTESUD',
        sellerAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        rating: 4.5,
        reviews: 89,
        stock: 100,
      ),
      Product(
        id: 6,
        name: 'Buzo Deportivo INTESUD',
        description: 'Buzo oficial para educación física',
        price: 24990,
        image: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=500',
        category: 'clothing',
        sellerName: 'Centro de Alumnos',
        sellerAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
        rating: 4.6,
        reviews: 56,
        stock: 12,
      ),
      Product(
        id: 7,
        name: 'Gorra INTESUD',
        description: 'Gorra ajustable con logo bordado',
        price: 6990,
        image: 'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=500',
        category: 'accessories',
        sellerName: 'Centro de Alumnos',
        sellerAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
        rating: 4.4,
        reviews: 28,
        stock: 30,
      ),
      Product(
        id: 8,
        name: 'Pase Bus Semanal',
        description: 'Pase de transporte válido por 7 días',
        price: 8000,
        image: 'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=500',
        category: 'transport',
        sellerName: 'Administración',
        sellerAvatar: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=100',
        rating: 5.0,
        reviews: 95,
        stock: 50,
      ),
    ];

const List<Map<String, dynamic>> _categories = [
  {'id': 'all', 'name': 'Todo', 'icon': Icons.shopping_bag_rounded},
  {'id': 'clothing', 'name': 'Ropa', 'icon': Icons.checkroom_rounded},
  {'id': 'accessories', 'name': 'Accesorios', 'icon': Icons.star_rounded},
  {'id': 'transport', 'name': 'Transporte', 'icon': Icons.directions_bus_rounded},
  {'id': 'stationery', 'name': 'Útiles', 'icon': Icons.menu_book_rounded},
];

// ── PANTALLA ──────────────────────────────────────────────────────────────────
class StoreScreen extends StatefulWidget {
  final bool isGuest;
  const StoreScreen({super.key, this.isGuest = false});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with SingleTickerProviderStateMixin {
  late List<Product> _products;
  final List<CartItem> _cart = [];
  String _selectedCategory = 'all';
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';
  bool _showCart = false;
  bool _showGuestWarning = false;

  late AnimationController _cartBadgeCtrl;
  late Animation<double> _cartBadgeAnim;

  @override
  void initState() {
    super.initState();
    _products = buildProducts();
    _searchCtrl.addListener(() => setState(() => _query = _searchCtrl.text));
    _cartBadgeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _cartBadgeAnim = Tween<double>(begin: 1, end: 1.4).animate(
        CurvedAnimation(parent: _cartBadgeCtrl, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _cartBadgeCtrl.dispose();
    super.dispose();
  }

  List<Product> get _filtered => _products.where((p) {
        final matchCat =
            _selectedCategory == 'all' || p.category == _selectedCategory;
        final matchSearch = p.name.toLowerCase().contains(_query.toLowerCase()) ||
            p.description.toLowerCase().contains(_query.toLowerCase());
        return matchCat && matchSearch;
      }).toList();

  int get _cartCount =>
      _cart.fold(0, (s, i) => s + i.quantity);

  double get _cartTotal =>
      _cart.fold(0, (s, i) => s + i.product.price * i.quantity);

  void _toggleFavorite(int id) {
    setState(() {
      final p = _products.firstWhere((p) => p.id == id);
      p.isFavorite = !p.isFavorite;
    });
  }

  void _addToCart(Product product) {
    if (widget.isGuest) {
      setState(() => _showGuestWarning = true);
      return;
    }
    setState(() {
      final existing =
          _cart.where((i) => i.product.id == product.id).toList();
      if (existing.isNotEmpty) {
        existing.first.quantity++;
      } else {
        _cart.add(CartItem(product: product));
      }
    });
    _cartBadgeCtrl.forward(from: 0);
  }

  void _updateQty(int id, int delta) {
    setState(() {
      final item = _cart.firstWhere((i) => i.product.id == id);
      item.quantity = (item.quantity + delta).clamp(0, 99);
      if (item.quantity == 0) _cart.removeWhere((i) => i.product.id == id);
    });
  }

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              _buildCategories(),
              Expanded(
                child: _filtered.isEmpty
                    ? _buildEmpty()
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                        children: [
                          if (widget.isGuest) _buildGuestBanner(),
                          _buildGrid(),
                        ],
                      ),
              ),
            ],
          ),

          // Carrito lateral
          if (_showCart) _buildCartOverlay(),

          // Modal invitado
          if (_showGuestWarning) _buildGuestWarningModal(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── HEADER ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF103B40), Color(0xFF0F5944), Color(0xFF2DA679)],
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/images/Logo_app.png',
                      width: 50, height: 50, fit: BoxFit.contain),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('TIENDA INTESUD',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      Text(
                        widget.isGuest
                            ? 'Solo Visualización - Invitado'
                            : 'Productos Oficiales',
                        style: const TextStyle(
                            color: Color(0xFF96D9C0), fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Carrito con badge
                  GestureDetector(
                    onTap: () => setState(() => _showCart = true),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2)),
                          ),
                          child: const Icon(Icons.shopping_cart_rounded,
                              color: Colors.white, size: 22),
                        ),
                        if (_cartCount > 0)
                          Positioned(
                            top: -6,
                            right: -6,
                            child: ScaleTransition(
                              scale: _cartBadgeAnim,
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color(0xFF103B40),
                                      width: 2),
                                ),
                                child: Center(
                                  child: Text('$_cartCount',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Barra búsqueda
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2)),
                  ],
                ),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Buscar productos...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    prefixIcon: Icon(Icons.search_rounded,
                        color: Color(0xFF103B40), size: 20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── CATEGORÍAS ────────────────────────────────────────────────────────────
  Widget _buildCategories() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _categories.map((cat) {
            final isActive = _selectedCategory == cat['id'];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () =>
                    setState(() => _selectedCategory = cat['id'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: isActive
                        ? const LinearGradient(
                            colors: [Color(0xFF2DA679), Color(0xFF0F5944)])
                        : null,
                    color: isActive ? null : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isActive
                          ? const Color(0xFF2DA679)
                          : const Color(0xFFE0E0E0),
                      width: 1.5,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                                color: const Color(0xFF2DA679).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3))
                          ]
                        : [],
                  ),
                  child: Row(
                    children: [
                      Icon(cat['icon'] as IconData,
                          size: 16,
                          color:
                              isActive ? Colors.white : const Color(0xFF103B40)),
                      const SizedBox(width: 6),
                      Text(cat['name'] as String,
                          style: TextStyle(
                              color: isActive
                                  ? Colors.white
                                  : const Color(0xFF103B40),
                              fontWeight: FontWeight.w600,
                              fontSize: 13)),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── BANNER INVITADO ───────────────────────────────────────────────────────
  Widget _buildGuestBanner() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF103B40), Color(0xFF0F5944), Color(0xFF2DA679)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF103B40).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: const Icon(Icons.lock_rounded,
                  color: Colors.white, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Vista de Invitado - Solo Visualización',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  const SizedBox(height: 4),
                  const Text(
                    'Puedes explorar los productos pero no realizar compras.',
                    style: TextStyle(
                        color: Color(0xFF96D9C0), fontSize: 12, height: 1.4),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/register'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.school_rounded,
                              color: Color(0xFF103B40), size: 16),
                          SizedBox(width: 6),
                          Text('Registrarme Ahora',
                              style: TextStyle(
                                  color: Color(0xFF103B40),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── GRID PRODUCTOS ────────────────────────────────────────────────────────
  Widget _buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.62,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _filtered.length,
      itemBuilder: (_, i) => _ProductCard(
        product: _filtered[i],
        isGuest: widget.isGuest,
        onFavorite: () => _toggleFavorite(_filtered[i].id),
        onAddToCart: () => _addToCart(_filtered[i]),
        formatPrice: _formatPrice,
      ),
    );
  }

  // ── EMPTY ─────────────────────────────────────────────────────────────────
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_bag_outlined,
              size: 72, color: Color(0xFF96D9C0)),
          const SizedBox(height: 16),
          const Text('No se encontraron productos',
              style: TextStyle(
                  color: Color(0xFF103B40),
                  fontWeight: FontWeight.bold,
                  fontSize: 17)),
          const SizedBox(height: 6),
          const Text('Intenta con otra búsqueda o categoría',
              style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  // ── CARRITO LATERAL ───────────────────────────────────────────────────────
  Widget _buildCartOverlay() {
    return GestureDetector(
      onTap: () => setState(() => _showCart = false),
      child: Container(
        color: Colors.black54,
        child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {}, // evita cerrar al tocar dentro
            child: Container(
              width: MediaQuery.of(context).size.width * 0.88,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  bottomLeft: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  // Header carrito
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF103B40),
                          Color(0xFF0F5944),
                          Color(0xFF2DA679)
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(
                        20,
                        MediaQuery.of(context).padding.top + 16,
                        20,
                        20),
                    child: Row(
                      children: [
                        const Text('Tu Carrito',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        const Spacer(),
                        Text('$_cartCount producto${_cartCount != 1 ? 's' : ''}',
                            style: const TextStyle(
                                color: Color(0xFF96D9C0), fontSize: 13)),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => setState(() => _showCart = false),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.close_rounded,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Items
                  Expanded(
                    child: _cart.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.shopping_cart_outlined,
                                    size: 64, color: Color(0xFF96D9C0)),
                                SizedBox(height: 12),
                                Text('Carrito vacío',
                                    style: TextStyle(
                                        color: Color(0xFF103B40),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                SizedBox(height: 4),
                                Text('Agrega productos para comenzar',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _cart.length,
                            itemBuilder: (_, i) =>
                                _CartItemCard(
                                  item: _cart[i],
                                  onUpdate: (delta) =>
                                      _updateQty(_cart[i].product.id, delta),
                                  onRemove: () => setState(() => _cart
                                      .removeWhere(
                                          (c) => c.product.id == _cart[i].product.id)),
                                  formatPrice: _formatPrice,
                                ),
                          ),
                  ),

                  // Footer carrito
                  if (_cart.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Color(0xFFE8F5F0), width: 2)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total:',
                                  style: TextStyle(
                                      color: Color(0xFF103B40),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text(_formatPrice(_cartTotal),
                                  style: const TextStyle(
                                      color: Color(0xFF0F5944),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24)),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2DA679),
                                    Color(0xFF0F5944)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                    Icons.shopping_cart_checkout_rounded,
                                    color: Colors.white,
                                    size: 20),
                                label: const Text('Realizar Pedido',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: OutlinedButton(
                              onPressed: () =>
                                  setState(() => _showCart = false),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF103B40),
                                side: const BorderSide(
                                    color: Color(0xFFE0E0E0), width: 1.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                              ),
                              child: const Text('Seguir Comprando',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── MODAL INVITADO ────────────────────────────────────────────────────────
  Widget _buildGuestWarningModal() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 24,
                    offset: const Offset(0, 8))
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF103B40), Color(0xFF0F5944)],
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(Icons.lock_rounded,
                      color: Colors.white, size: 34),
                ),
                const SizedBox(height: 16),
                const Text('Función Bloqueada',
                    style: TextStyle(
                        color: Color(0xFF103B40),
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                const SizedBox(height: 8),
                const Text(
                  'Los invitados pueden visualizar productos pero no realizar compras.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF2DA679).withOpacity(0.1),
                        const Color(0xFF0F5944).withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text('¡INSCRÍBETE YA!',
                          style: TextStyle(
                              color: Color(0xFF0F5944),
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      const SizedBox(height: 4),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          children: [
                            TextSpan(text: 'Obtén '),
                            TextSpan(
                              text: '20% de descuento',
                              style: TextStyle(
                                  color: Color(0xFF2DA679),
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text:
                                    ' en tu matrícula y acceso completo a la tienda'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFF2DA679), Color(0xFF0F5944)]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/register'),
                      icon: const Icon(Icons.school_rounded,
                          color: Colors.white, size: 18),
                      label: const Text('Registrarme Ahora',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: OutlinedButton(
                    onPressed: () =>
                        setState(() => _showGuestWarning = false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF103B40),
                      side: const BorderSide(
                          color: Color(0xFFE0E0E0), width: 1.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Seguir Explorando',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── BOTTOM NAV ────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border:
            Border(top: BorderSide(color: Color(0xFFE8F5F0), width: 2)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBtn(
                icon: Icons.home_rounded,
                label: 'Inicio',
                onTap: () => Navigator.of(context).pushReplacementNamed(
                    widget.isGuest ? '/feed-guest' : '/feed'),
              ),
              _NavBtn(
                icon: Icons.calendar_month_outlined,
                label: 'Eventos',
                onTap: () =>
                    Navigator.of(context).pushNamed('/events'),
              ),
              _NavBtn(
                icon: Icons.shopping_bag_rounded,
                label: 'Tienda',
                isActive: true,
                onTap: () {},
              ),
              _NavBtn(
                icon: Icons.person_outline_rounded,
                label: 'Perfil',
                onTap: () =>
                    Navigator.of(context).pushNamed('/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── PRODUCT CARD ──────────────────────────────────────────────────────────────
class _ProductCard extends StatelessWidget {
  final Product product;
  final bool isGuest;
  final VoidCallback onFavorite;
  final VoidCallback onAddToCart;
  final String Function(double) formatPrice;

  const _ProductCard({
    required this.product,
    required this.isGuest,
    required this.onFavorite,
    required this.onAddToCart,
    required this.formatPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border:
            Border.all(color: const Color(0xFF96D9C0).withOpacity(0.25), width: 1.5),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20)),
                child: Image.network(
                  product.image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Favorito
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onFavorite,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4)
                      ],
                    ),
                    child: Icon(
                      product.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 18,
                      color: product.isFavorite
                          ? Colors.red
                          : const Color(0xFF103B40),
                    ),
                  ),
                ),
              ),
              // Badge stock bajo
              if (product.stock < 20)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('¡Últimas ${product.stock}!',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),

          // Info
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Seller
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(product.sellerAvatar),
                      backgroundColor: const Color(0xFF96D9C0),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(product.sellerName,
                          style: const TextStyle(
                              color: Color(0xFF0F5944),
                              fontSize: 10),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Nombre
                Text(product.name,
                    style: const TextStyle(
                        color: Color(0xFF103B40),
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),

                // Descripción
                Text(product.description,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),

                // Rating
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 14, color: Color(0xFFFFC107)),
                    const SizedBox(width: 3),
                    Text('${product.rating}',
                        style: const TextStyle(
                            color: Color(0xFF103B40),
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    const SizedBox(width: 3),
                    Text('(${product.reviews})',
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 8),

                // Precio + botón
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatPrice(product.price),
                        style: const TextStyle(
                            color: Color(0xFF0F5944),
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    GestureDetector(
                      onTap: onAddToCart,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          gradient: isGuest
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFFCCCCCC),
                                    Color(0xFFBBBBBB)
                                  ])
                              : const LinearGradient(
                                  colors: [
                                    Color(0xFF2DA679),
                                    Color(0xFF0F5944)
                                  ]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isGuest
                                  ? Icons.lock_rounded
                                  : Icons.add_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isGuest ? 'Bloqueado' : 'Agregar',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── CART ITEM CARD ────────────────────────────────────────────────────────────
class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final void Function(int) onUpdate;
  final VoidCallback onRemove;
  final String Function(double) formatPrice;

  const _CartItemCard({
    required this.item,
    required this.onUpdate,
    required this.onRemove,
    required this.formatPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: const Color(0xFF96D9C0).withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(item.product.image,
                  width: 72, height: 72, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.name,
                      style: const TextStyle(
                          color: Color(0xFF103B40),
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                      overflow: TextOverflow.ellipsis),
                  Text(formatPrice(item.product.price),
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Contador
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xFF96D9C0).withOpacity(0.5)),
                        ),
                        child: Row(
                          children: [
                            _QtyBtn(
                                icon: Icons.remove_rounded,
                                onTap: () => onUpdate(-1)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('${item.quantity}',
                                  style: const TextStyle(
                                      color: Color(0xFF103B40),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                            ),
                            _QtyBtn(
                                icon: Icons.add_rounded,
                                onTap: () => onUpdate(1)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Eliminar
                      GestureDetector(
                        onTap: onRemove,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.close_rounded,
                              color: Colors.red, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF2DA679), Color(0xFF0F5944)]),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}

// ── NAV BTN ───────────────────────────────────────────────────────────────────
class _NavBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isActive)
            Container(
              width: 32,
              height: 3,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                  color: const Color(0xFF2DA679),
                  borderRadius: BorderRadius.circular(2)),
            ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF2DA679).withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon,
                color: isActive
                    ? const Color(0xFF2DA679)
                    : Colors.grey[500],
                size: 24),
          ),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight:
                      isActive ? FontWeight.w700 : FontWeight.normal,
                  color: isActive
                      ? const Color(0xFF2DA679)
                      : Colors.grey[500])),
        ],
      ),
    );
  }
}