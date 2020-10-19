import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewProductPage extends StatelessWidget {
  static const routeName = 'new-product-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),
      ),
      body: Center(
        child: Text('New Product'),
      ),
    );
  }
}
