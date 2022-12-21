import 'package:flutter/cupertino.dart';
import 'package:flutter_navigator/screens/home_screen.dart';
import 'package:flutter_navigator/screens/product_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int? productId;

  void setProductId(int id) {
    setState(() {
      productId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: Navigator(
        pages: [
          const CupertinoPage(
            child: HomeScreen(),
          ),
          if (productId != null)
            CupertinoPage(
              child: ProductScreen(
                id: productId!,
              ),
            ),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            productId = null;
            return true;
          }
          return false;
        },
      ),
    );
  }
}
