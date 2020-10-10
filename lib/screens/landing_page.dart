import 'package:flutter/material.dart';

import './sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10.0,right: 10.0),
        child: SignInChangeNotifier.create(context),
      ),
    );
  }
}
