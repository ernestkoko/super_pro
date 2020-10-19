import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function addNewProduct;

  const CustomFloatingActionButton({Key key, @required this.addNewProduct}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => addNewProduct(context),
      ),
    );
  }
}
