import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key key,
    @required this.title,
    @required this.content,
    this.cancelActionText,
    @required this.defaultActionText,
  })  : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null),
        super(key: key);

  final Widget title;
  final String content;
  final String cancelActionText;
  final String defaultActionText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    //create an empty list of widgets
    final actions = <Widget>[];
    //add the cancel widget to the list of actions if it is not null
    if(cancelActionText != null) {
      actions.add(
        FlatButton(
          //onPress of the button does not dispose the dialog cos pop is set to false
          onPressed: () => Navigator.of(context).pop(false),
          //it takes in the cancel text that will be set later
          child: Text(cancelActionText),
        ),
      );
    }
    //add another button that will dispose the dialog when pressed
    actions.add(
      FlatButton(
        // pressing this button dismisses the dialog because the pop is set to true
        onPressed: () => Navigator.of(context).pop(true),
        //it takes the default action text that will be set later
        child: Text(defaultActionText),
      ),
    );
    //return the list of actions
    return actions;
  }

  /**
   * takes a context and returns a Future of type bool that will be used to know
   * when the dialog is to pop the topmost route or not
   */
  Future<bool> show(BuildContext context) async {
    //it uses the passed in context and returns the widget, this,CustomAlertDialog
    return await showDialog(context: context, child: this);
  }
}
