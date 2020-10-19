import 'package:flutter/foundation.dart';
import 'package:super_pro/services/auth.dart';
import 'package:super_pro/utility/validators.dart';

enum SignInFormType { signIn, register }

class SignInModel with StringsValidators, ChangeNotifier {
  SignInModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.signInFormType = SignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
    this.signInSuccessful,
  });

  final AuthBase auth;
  String email;
  String password;
  SignInFormType signInFormType;
  bool isLoading;
  bool submitted;
  bool signInSuccessful;

  //the text that will e displayed on the sign in button
  String get primaryButtonText {
    //returns 'Sign In' is the formType is signIn else it returns 'Register'
    return signInFormType == SignInFormType.signIn ? 'Sign In' : 'Register';
  }

  String get secondaryButtonText {
    //if the formType is signIn
    return signInFormType == SignInFormType.signIn
        //returns 'Need an account? Register'
        ? 'Need an account? Register'
        //else returns 'Have and account? Sign in'
        : 'Have and account? Sign in';
  }

  //a method that checks if the form can be submitted
  bool get canSubmit {
    //returns true if the email, password are valid and isLoading is false
    return emailValidator.isEmailValid(email) &&
        passwordValidator.isStringValid(password) &&
        !isLoading;
  }

  //method that gets the password error text
  String get passwordErrorText {
    //bool that returns true if submitted is true and the password is not valid
    bool showError = submitted && !passwordValidator.isStringValid(password);
    //if showError is true it returns the invalidPasswordErrorText else it
    //returns null
    return showError ? invalidPasswordErrorText : null;
  }

  //method that gets the email error text
  String get emailErrorText {
    //bool that returns true if submitted is true and email is not valid
    bool showError = submitted && !emailValidator.isEmailValid(email);
    //if showError is true, return email error text else return null
    return showError ? invalidEmailErrorText : null;
  }

//method that toggles the form type
  void toggleFormType() {
    final formType = this.signInFormType == SignInFormType.signIn
        ? SignInFormType.register
        : SignInFormType.signIn;
    //update the form values
    updateWith(
      email: '',
      password: '',
      isLoading: false,
      submitted: false,
      formType: formType,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  //method used to update the entire class
  void updateWith(
      {String email,
      String password,
      SignInFormType formType,
      bool submitted,
      bool isLoading,
      bool signInSuccessful}) {
    //uses the new value if given else it uses the default value
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.signInFormType = formType ?? this.signInFormType;
    this.submitted = submitted ?? this.submitted;
    this.isLoading = isLoading ?? this.isLoading;
    this.signInSuccessful = signInSuccessful ?? this.signInSuccessful;
    //notify the system that things have changed
    notifyListeners();
  }

  //submit method that will be triggered when the submit button is clicked
  Future<void> submit() async {
    //set submitted and isLoading to true a
    updateWith(submitted: true, isLoading: true);
    //check if the type if signIn
    //try the code if the sign in or registration will succeed
    try {
      if (signInFormType == SignInFormType.signIn) {
        print('SignIn: clicked');
        //sign the user in
        await auth.signInWithEmailAndPassword(email, password);
        //set the signInSuccessful to true if the user was able to sign in
        updateWith(signInSuccessful: true);
      } else {
        print('Register: clicked');
        //register the user
        await auth.createUserWithEmailAndPassword(email, password);
        //update the isLoading to false, FormType to Sign in, password and
        // email to ''
        updateWith(
            isLoading: false,
            formType: SignInFormType.signIn,
            password: '',
            email: '');
      }
    } catch (e) {
      print('Error:${e.message}');
      //if it fails, reset isLoading to false
      updateWith(isLoading: false);
      //rethrow the error to the calling method

      rethrow;
    }
  }
}
