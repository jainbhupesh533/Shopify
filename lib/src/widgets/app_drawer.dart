import 'package:flutter/material.dart';
import '../routes/orders_page.dart';
import '../routes/user_products_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget buildListTile(IconData icons, String title, String routeName) {
      return ListTile(
        leading: Icon(icons),
        title: Text(title),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(routeName);
        },
      );
    }

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Shoplify'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          buildListTile(Icons.shop, 'Shop', '/'),
          Divider(),
          buildListTile(Icons.payment, 'Orders', OrdersPage.routeName),
          Divider(),
          buildListTile(
              Icons.edit, 'Manage Products', UserProductsPage.routeName),
          // ListTile(
          //   leading: Icon(Icons.payment),
          //   title: Text('Orders'),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed(OrdersPage.routeName);
          //   },
          // ),
        ],
      ),
    );
  }
}
