import 'package:flutter/material.dart';
import '../screens/cart_screen.dart';
import '../screens/menu_screen.dart';
import '../screens/order_screen.dart';

class ServingScreen extends StatefulWidget {
  const ServingScreen({Key? key}) : super(key: key);

  @override
  _ServingScreenState createState() => _ServingScreenState();
}

class _ServingScreenState extends State<ServingScreen> {
  int _currentIndex = 2;

  void _onTabTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MenuScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrdersScreen()),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> servings = [
      {'name': 'Order 1', 'totalPrice': 100.00, 'account': 'Acc 1'},
      {'name': 'Order 2', 'totalPrice': 150.00, 'account': 'Acc 2'},
      {'name': 'Order 3', 'totalPrice': 200.00, 'account': 'Acc 3'},
      {'name': 'Order 4', 'totalPrice': 250.00, 'account': 'Acc 4'},
      {'name': 'Order 5', 'totalPrice': 300.00, 'account': 'Acc 5'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF12182B), // Background
      appBar: AppBar(
        title: const Text(
          'Serving',
          style: TextStyle(
            color: Colors.white, // Title color
          ),
        ),
        backgroundColor: const Color(0xFF12182B),
        iconTheme: const IconThemeData(
          color: Colors.white, // Back button color
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: servings.length,
        itemBuilder: (context, index) {
          final serving = servings[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color.fromARGB(255, 45, 51, 67), // Card background
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Order name
                    Text(
                      serving['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // Account, Price, and Check Button
                    Row(
                      children: [
                        // Price and Account
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\₱${serving['totalPrice'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              serving['account'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        // ✓ Button
                        IconButton(
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            // Functionality for serving will go here
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
}
