class Validator {
  /// 邮箱正则
  static String regexEmail =
      r"^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$";

  /// 判断邮箱是否正确
  static bool validatorEmail(String value) {
    if (value.isEmpty) return false;
    return RegExp(regexEmail).hasMatch(value);
  }

  /// 密码正则
  static String regexPassword = r"^(?=.*[a-zA-Z])(?=.*\d).{6,}$";

  /// 判断密码是否正确
  static bool validatorPassword(String value) {
    if (value.isEmpty) return false;
    return RegExp(regexPassword).hasMatch(value);
  }
}
