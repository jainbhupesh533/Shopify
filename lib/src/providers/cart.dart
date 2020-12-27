import 'package:flutter/foundation.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;


class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  // String authToken;
  // String userId;

  Map<String, CartItem> _items = {};

  // void update(String tokenValue, String id)  {
  //   authToken = tokenValue;
  //   userId = id
  //   notifyListeners();
  // }

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItems(String productId, double price, String title) {
    // print(productId);
    // int quantity;
    // final url =
    //     'https://shopify-535b9-default-rtdb.firebaseio.com/carts/$userId.json?auth=$authToken';
    // final timeStamp = DateTime.now();
    // try {
    //   // if (!url.contains(productId)) {
    //     if(res.body)
    //     final res = await http.post(
    //       url,
    //       body: json.encode({
    //         'id': productId,
    //         'title': title,
    //         'price': price,
    //         'quantity': 1,
    //       }),
    //     );
    //   // } else {
    //   //   final resUpdate = await http.patch(
    //   //     url,
    //   //     body: json.encode({
    //   //       'id': timeStamp.toIso8601String(),
    //   //       'title': title,
    //   //       'price': price * quantity,
    //   //       'quantity': quantity + 1,
    //   //     }),
    //   //   );
    //   //   // quantity++;
    //   // }
    // } catch (error) {
    //   print(error);
    // }
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity - 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1)
      removeQuantity(productId);
    else {
      removeItem(productId);
    }
    // notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
