import 'package:flutter/cupertino.dart';
import 'package:flutter_navigator/routes/routes.dart';
import 'package:flutter_navigator/screens/home_screen.dart';
import 'package:flutter_navigator/screens/product_screen.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    Routes.home: (context) => const HomeScreen(),
    Routes.product: (context) => ProductScreen(
          id: ModalRoute.of(context)!.settings.arguments as int,
        ),
  };
}
