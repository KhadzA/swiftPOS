import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(String productName, double price) {
    int index = _cartItems.indexWhere((item) => item['name'] == productName);
    if (index != -1) {
      _cartItems[index]['quantity']++;
    } else {
      _cartItems.add({
        'name': productName,
        'price': price,
        'quantity': 1,
      });
    }
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _cartItems[index]['quantity']++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity']--;
    } else {
      _cartItems.removeAt(index); // Remove item if quantity reaches 0
    }
    notifyListeners();
  }
}
