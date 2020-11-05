class Validator {
  static isPhoneNumber(phoneNumber) {
    String pattern = r"^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$";

    return new RegExp(pattern).hasMatch(phoneNumber);
  }

  static isEmail(email) {
    String pattern = r"^[a-z][a-z0-9_\.]{2,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$";

    return new RegExp(pattern).hasMatch(email);
  }

  static isName(String name) {
    if (name.trim().length <= 3) return false;
    return true;
  }

  static isPassword(String password) {
    if (password.trim().length <= 8) return false;
    return true;
  }
}
