import 'package:flutter/cupertino.dart';

import 'package:flutter_navigator/screens/home_screen.dart';
import 'package:flutter_navigator/screens/product_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final delegate = MyRouterDelegate(
    pages: [
      MyPage((_) => const HomeScreen(), path: '/'),
      MyPage(
        (data) => ProductScreen(
          id: int.parse(data['id']!),
        ),
        path: '/product/:id', // <-- Dato dinamico
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      routerDelegate: delegate,
      routeInformationParser: MyRouteInformationParser(),
    );
  }
}

class MyPage {
  MyPage(this.builder, {required this.path});

  final Widget Function(Map<String, String> data) builder;
  final String path;
}

class MyRouterDelegate<T> extends RouterDelegate<Uri>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  MyRouterDelegate({
    required this.pages,
  }) {
    final initialPage = pages.firstWhere((element) => element.path == '/');
    _navigationPages = [
      CupertinoPage(
        name: '/',
        child: initialPage.builder({}),
      ),
    ];
  }

  final List<MyPage> pages;

  late List<Page> _navigationPages;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _navigationPages,
      onPopPage: (route, result) {
        if (route.didPop(result)) {
          _navigationPages.removeWhere(
            (element) => element.name == route.settings.name,
          );
          notifyListeners();
          return true;
        }
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(Uri configuration) async {
    final path = configuration.path;
    final data = <String, String>{};

    final index = pages.indexWhere(
      (element) {
        if (element.path == path) {
          return true;
        }

        if (element.path.contains('/:')) {
          final lastIndex = element.path.lastIndexOf('/:');
          final subString = element.path.substring(
            0,
            lastIndex,
          );

          if (path.startsWith(subString)) {
            final key =
                element.path.substring(lastIndex + 2, element.path.length);
            final value = path.substring(lastIndex + 1, path.length);

            data[key] = value;

            return true;
          }
        }
        return false;
      },
    );

    if (index != -1) {
      _navigationPages = [
        ..._navigationPages,
        CupertinoPage(
          name: path,
          child: pages[index].builder(data),
        ),
      ];
      notifyListeners();
    }
  }


  @override
  Uri? get currentConfiguration => Uri.parse(_navigationPages.last.name!);

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();
}

class MyRouteInformationParser extends RouteInformationParser<Uri> {
  @override
  Future<Uri> parseRouteInformation(RouteInformation routeInformation) async {
    return Uri.parse(routeInformation.location ?? '/');
  }

  @override
  RouteInformation restoreRouteInformation(Uri configuration) {
    return RouteInformation(location: configuration.toString());
  }
}
