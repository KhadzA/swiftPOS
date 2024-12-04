import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../screens/cart_screen.dart';
import '../screens/order_screen.dart';
import '../screens/serving_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<Map<String, dynamic>> _products = [
    {'name': 'Fruit Soda 1', 'price': 5.0, 'category': 'FRUIT SODA'},
    {'name': 'Fruit Soda 2', 'price': 6.0, 'category': 'FRUIT SODA'},
    {'name': 'Cold Brew 1', 'price': 7.0, 'category': 'COLD BREW'},
    {'name': 'Cold Brew 2', 'price': 8.0, 'category': 'COLD BREW'},
    {'name': 'Fruit Yogurt 1', 'price': 4.0, 'category': 'FRUIT YOGURT'},
    {'name': 'Fruit Yogurt 2', 'price': 5.5, 'category': 'FRUIT YOGURT'},
  ];

  String _selectedCategory = 'ALL'; // Default

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OrdersScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ServingScreen()),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = _selectedCategory == 'ALL'
        ? _products
        : _products
            .where((product) => product['category'] == _selectedCategory)
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF12182B), // Background
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(
            color: Colors.white, // Title color
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
        backgroundColor: const Color(0xFF12182B),
        iconTheme: const IconThemeData(
          color: Colors.white, // Back button color
        ),
      ),
      body: Column(
        children: [
          // Bar Chart Placeholder
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFD9C79F),
              ),
              child: const Center(
                child: Text(
                  'BAR CHART (DIKO ALAM)',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Categories Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryCard('ALL'),
                _buildCategoryCard('FRUIT SODA'),
                _buildCategoryCard('COLD BREW'),
                _buildCategoryCard('FRUIT YOGURT'),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                String productName = filteredProducts[index]['name'];
                double productPrice = filteredProducts[index]['price'];

                return GestureDetector(
                  onTap: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(productName, productPrice);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$productName added to cart!')),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: const Color.fromARGB(
                        255, 45, 51, 67), // Dark blue card background
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.fastfood,
                            size: 40,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            productName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\₱${productPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFD9C79F),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'ORDER',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            label: 'SERVING',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: _selectedCategory == title
            ? const Color(0xFFD9A64F)
            : const Color(0xFFD9C79F),
        child: SizedBox(
          width: 80,
          height: 80,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
