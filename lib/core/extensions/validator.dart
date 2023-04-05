class Validator {
  static String? validateName(String? value) {
    if (value!.isEmpty || value.length < 5) {
      return "لا يجب أن يكون الاسم فارغ";
    }
    return null;
  }

  static String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      return "لا يمكن أن يكون فارغا";
    }
    return null;
  }

  static String? validateMobile(String? value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "يجب ألا يكون الهاتف فارغ";
    } else if (value.length != 11) {
      return "يجب أن يتكون رقم الهاتف من 11 رقم";
    } else if (!regExp.hasMatch(value)) {
      return "يجب أن يتكون رقم الهاتف من 11 رقم";
    }
    return null;
  }

  static String? validateMobileNotRequared(String? value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.length != 11) {
      return "يجب أن يتكون رقم الهاتف من 11 رقم";
    } else if (!regExp.hasMatch(value!)) {
      return "يجب أن يتكون رقم الهاتف من 11 رقم";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "يجب ألا تكون كلمة المرور فارغة";
    } else if (value.length < 6) {
      return "يجب أن تتكون كلمة المرور من 6 أرقام على الأقل";
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return "يجب ألا يكون الهاتف فارغ";
    } else if (value.length < 10) {
      return "يجب أن يتكون رقم الهاتف من 11 رقم";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "يجب ألا يكون البريد الإلكتروني فارغ";
    } else if (!regExp.hasMatch(value)) {
      return "يرجى إدخال بريد إلكتروني الصحيح";
    } else {
      return null;
    }
  }

  static String? validateEmailCorrect(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "يجب ألا يكون البريد الإلكتروني فارغ";
    } else {
      if (!regExp.hasMatch(value)) {
        return "يرجى إدخال بريد إلكتروني الصحيح";
      }
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value!.isEmpty || value.length < 5) {
      return "العنوان لا يمكن أن يكون فارغا";
    }
    return null;
  }
}
