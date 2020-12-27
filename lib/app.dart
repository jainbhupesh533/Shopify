import 'package:flutter/material.dart';
import './import.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(),
          update: (ctx, auth, prevProd) => prevProd
            ..update(
              auth.token,
              auth.userId,
              prevProd == null ? [] : prevProd.items,
            ),
          // create: (ctx) => Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(),
          update: (ctx, auth, prevOrders) => prevOrders
            ..update(
              auth.token,
              auth.userId,
              prevOrders == null ? [] : prevOrders.orders,
            ),
          // value: Orders(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsOverviewPage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashPage()
                          : AuthPage(),
                ),
          // initialRoute: '/',
          routes: {
            // 'ProductsDe: (ctx) => ProductsOverviewPage(),
            ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
            CartPage.routeName: (ctx) => CartPage(),
            OrdersPage.routeName: (ctx) => OrdersPage(),
            UserProductsPage.routeName: (ctx) => UserProductsPage(),
            EditProductPage.routeName: (ctx) => EditProductPage(),
          },
          onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (ctx) => ProductsOverviewPage(),
          ),
        ),
      ),
    );
  }
}
