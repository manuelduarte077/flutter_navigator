import 'package:flutter/cupertino.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Product Details', style: TextStyle(fontSize: 24)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product $id', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              child: const Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
