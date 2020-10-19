import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_pro/screens/home_page/home.dart';
import 'package:super_pro/screens/new_product/new_product_page.dart';
import 'package:super_pro/screens/settings/setting_page.dart';
import 'package:super_pro/services/auth.dart';

import './screens/landing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'SuperPro',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          // the default landing route
          '/': (context) => LandingPage(),
          HomePage.routeName: (context) => HomePage(),
          NewProductPage.routeName: (context) => NewProductPage(),
          SettingsPage.routeName:(context) => SettingsPage(),
        },
      ),
    );
  }
}
