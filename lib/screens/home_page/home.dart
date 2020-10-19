import 'package:flutter/material.dart';
import 'package:super_pro/common_widgets/custom_floating_action_button.dart';
import 'package:super_pro/common_widgets/drawer.dart';
import 'package:super_pro/common_widgets/drawer.dart';
import 'package:super_pro/screens/new_product/new_product_page.dart';
import 'package:super_pro/screens/settings/setting_page.dart';

enum MenuType { Settings, Logout }

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          PopupMenuButton<MenuType>(
              onSelected: (selected) {
                setState(() {
                  //check for the type of selection and then navigate to
                  // the appropriate screen
                  if (selected == MenuType.Settings) {
                    _goToSettingsPage(context);
                  } else if (selected == MenuType.Logout) {
                    final snack = SnackBar(
                      content: Text('Not implemented yet!'),
                    );
                    setState(() {
                      Scaffold.of(context).showSnackBar(snack);
                    });
                  }
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<MenuType>>[
                    PopupMenuItem(
                        value: MenuType.Settings, child: Text('Settings')),
                    PopupMenuItem(
                      value: MenuType.Settings,
                      child: Text(
                        "Logout",
                      ),
                    ),
                  ]),
        ],
      ),

      //create a side drawer
      drawer: CustomDrawer(
        addNewProduct: _addNewProduct,
        goToSettingsPage: _goToSettingsPage,
      ),
      body: HomeBody(),
      //add a floating action button
      floatingActionButton: CustomFloatingActionButton(addNewProduct: _addNewProduct,),
    );
  }

//add new product button
  _addNewProduct(BuildContext context) {
    print('NewProduct: Clicked2');

    Navigator.pushNamed(context, NewProductPage.routeName);
  }

  //got to settings button
  _goToSettingsPage(BuildContext context) {
    Navigator.of(context).pushNamed(SettingsPage.routeName);
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          elevation: 6.0,
          child: Row(
            children: [
              Icon(
                Icons.ac_unit_outlined,
                size: 50.0,
              ),
              Column(
                children: [
                  Text(
                    'Product Name',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Manufacturer',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text('Body2'),
      ],
    );
  }
}
