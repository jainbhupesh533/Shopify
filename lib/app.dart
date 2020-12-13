import 'package:flutter/material.dart';
import './src/providers/orders.dart';
import './src/routes/cart_page.dart';
import './src/providers/products.dart';
import 'package:provider/provider.dart';
import './src/routes/products_overview_page.dart';
import './src/routes/product_detail_page.dart';
import './src/providers/cart.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
          // create: (ctx) => Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        // home: ProductsOverviewPage(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => ProductsOverviewPage(),
          ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
          CartPage.routeName: (ctx) => CartPage(),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (ctx) => ProductsOverviewPage(),
        ),
      ),
    );
  }
}
