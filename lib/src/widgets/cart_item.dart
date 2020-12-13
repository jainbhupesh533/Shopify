import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context,listen: false);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('₹$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \₹${price * quantity}'),
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text(
                    '$quantity X',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                  if (quantity > 1)
                    IconButton(
                      icon: Icon(Icons.delete),
                      // iconSize: 20,
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        cart.removeQuantity(productId);
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
