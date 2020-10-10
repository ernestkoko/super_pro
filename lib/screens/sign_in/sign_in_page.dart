import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_pro/common_widgets/alaert_dialog.dart';
import 'package:super_pro/screens/home_page/home.dart';
import 'package:super_pro/screens/sign_in/sign_in_model.dart';
import 'package:super_pro/services/auth.dart';

import '../../common_widgets/CustomRaisedButton.dart';

class SignInChangeNotifier extends StatefulWidget {
  const SignInChangeNotifier({Key key, this.model});

  final SignInModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<SignInModel>(
      create: (context) => SignInModel(auth: auth),
      child: Consumer<SignInModel>(
        builder: (context, model, _) => SignInChangeNotifier(
          model: model,
        ),
      ),
    );
  }

  @override
  _SignInChangeNotifierState createState() => _SignInChangeNotifierState();
}

class _SignInChangeNotifierState extends State<SignInChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  //get a common model
  SignInModel get model => widget.model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: _buildChildren(),
    );
  }

  //return a list of widgets
  List<Widget> _buildChildren() {
    return <Widget>[
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextFields(),
      SizedBox(height: 8.0),
      CustomRaisedButton(
        color: Theme.of(context).accentColor,
        buttonText: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(model.secondaryButtonText),
        onPressed: _toggleFormType,
      ),
    ];
  }

  Widget _buildEmailTextField() {
    return TextField(
      focusNode: _emailFocus,
      controller: _emailController,
      enabled: model.isLoading == false,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'example@test.com',
        errorText: model.emailErrorText,
      ),
      onChanged: model.updateEmail,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }

  TextField _buildPasswordTextFields() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocus,
      enabled: model.isLoading == false,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: model.updatePassword,
    );
  }

  //toggle formType
  void _toggleFormType() {
    model.toggleFormType();
    //clear the texts on the email and password fields after toggling the form
    _passwordController.clear();
    _emailController.clear();
  }

  Future<void> _submit() async {
    try {
      //try to submit
      await model.submit();
      //check if the signIn is successful
      if(model.signInSuccessful){
        // allow the user access to the next page of the app
       // print("Sign in is:${model.signInSuccessful}");
Navigator.pushReplacementNamed(context, HomePage.routeName);
      }
    } catch (e) {
      print(e.message);
      final alert = AlertDialog(
        title: Text('Alas!!'),
        content: Text(e.message),
        actions: [Text('OK')],
      );
      //show the dialog
      CustomAlertDialog(
        title: Text("${model.primaryButtonText} unsuccessful"),
        content: e.message,
        defaultActionText: 'Ok',
      ).show(context);
    }
  }
}
