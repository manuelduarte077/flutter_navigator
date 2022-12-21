import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_navigator/app/app.dart';
import 'package:flutter_navigator/models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _list = <Product>[];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 20; i++) {
      final faker = Faker();
      _list.add(
        Product(
          id: i,
          name: faker.food.dish(),
          image: faker.image.image(
            keywords: ['food'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Home', style: TextStyle(fontSize: 24)),
      ),
      child: ListView.separated(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final product = _list[index];
          return GestureDetector(
            onTap: () {
              final myAppState =
                  context.findRootAncestorStateOfType<MyAppState>();
              myAppState?.setProductId(product.id);
            },
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.systemGrey4,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
