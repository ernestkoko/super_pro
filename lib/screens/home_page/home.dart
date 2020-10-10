import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Container(
          child: Text("Home Page"),
        ),
      ),
    );
  }
}
