import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(
      {@required this.addNewProduct, @required this.goToSettingsPage});

  final Function addNewProduct;
  final Function goToSettingsPage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
         const DrawerHeader(
          child: Icon(
            Icons.email,
          ),
        ),
         _buildListTile(
            context: context,
            onTap: addNewProduct,
            icon: Icons.add,
            title: 'Add Product'),
        _buildListTile(
            context: context,
            onTap:
                //navigate to the settings page
                goToSettingsPage,
            icon: Icons.settings,
            title: 'Settings'),
        _buildListTile(
            context: context,
            onTap: null,
            icon: Icons.info_rounded,
            title: 'Item3'),
      ],
    ));
  }

  Widget _buildListTile(
      {BuildContext context, Function onTap, IconData icon, String title}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).accentColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).hintColor,
        ),
      ),
      onTap:()=> onTap(context),
    );
  }
}
