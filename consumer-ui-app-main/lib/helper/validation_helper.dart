import '../const/constant.dart';
import '../model/enum.dart';

class ValidationHelper {
  static String validate(InputType inputType, dynamic value,
      {String errorMsg = ""}) {
    switch (inputType) {
      case InputType.text:
        if (value.isEmpty) {
          return errorMsg;
        }
        break;
      case InputType.number:
        if (value!.isEmpty) {
          return errorMsg;
        }
        break;
      case InputType.phone:
        if (value!.isEmpty) {
          return errorMsg;
        } else if (!mobileValidatorRegExp.hasMatch(value)) {
          return regexpNumberError;
        }
        break;
      case InputType.email:
        if (value!.isEmpty) {
          return errorMsg;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
        break;
      case InputType.password:
        if (value!.isEmpty) {
          return kPassNullError;
        }
        break;
      default:
    }
    return '';
  }
}
