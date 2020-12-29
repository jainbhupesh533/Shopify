import 'package:flutter/material.dart';
import '../routes/orders_page.dart';
import '../routes/user_products_page.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

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
            title: const Text('Shoplify'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          buildListTile(Icons.shop, 'Shop', '/'),
          Divider(),
          buildListTile(Icons.payment, 'Orders', OrdersPage.routeName),
          Divider(),
          buildListTile(
              Icons.edit, 'Manage Products', UserProductsPage.routeName),
          Divider(),
          ListTile(
            leading:const Icon(Icons.exit_to_app),
            title: const Text('Log Out'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logOut();
            },
          ),
        ],
      ),
    );
  }
}
