import 'package:flutter/material.dart';

// This is used for particual routes but if we want to use the same property on every page then we follow different approach
class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
    WidgetBuilder builder,
    RouteSettings settings,
  }) : super(
          builder: builder,
          settings: settings,
        );
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.name == '/') {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
    // return super
    //     .buildTransitions(context, animation, secondaryAnimation, child);
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder{
  @override
  Widget buildTransitions<T>(
    PageRoute<T>  route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == '/') {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
    // return super
    //     .buildTransitions(context, animation, secondaryAnimation, child);
  }
}