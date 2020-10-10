import 'package:email_validator/email_validator.dart';

abstract class StringValidator{
  bool isStringValid(String value);
  bool isEmailValid(String value);
}

class NonEmptyStringValidator implements StringValidator{
  //method that checks if the string is empty
  @override
  bool isStringValid(String value) {
    //returns true if the string is not empty else false
    return value.isNotEmpty;
  }

  //method that checks if the email is valid
  @override
  bool isEmailValid(String value) {
    //returns true if the email is valid
return EmailValidator.validate(value);
  }
}
class StringsValidators{
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidPasswordErrorText = 'Password can\'t be empty';
  final String invalidEmailErrorText = 'Email is not valid';
}