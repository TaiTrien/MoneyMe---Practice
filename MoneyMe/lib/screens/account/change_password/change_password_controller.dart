import 'package:MoneyMe/api/user_api.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:flutter/cupertino.dart';

class ChangePasswordController {
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var retypedPasswordController = TextEditingController();

  dipose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    retypedPasswordController.dispose();
  }

  handleChangePassword(BuildContext context) async {
    String currentPassword = currentPasswordController.text.trim();
    String newPassword = newPasswordController.text.trim();

    var data = await UserApi.changePassword(currentPassword: currentPassword, newPassword: newPassword);
    if (data.code != 200) {
      Notify notify = Notify();
      return notify.error(message: data.apiMessagse);
    } else {
      Notify notify = Notify();
      notify.success(message: "Đổi mật khẩu thành công");
      Navigator.pop(context);
    }
  }

  get newPassword => newPasswordController.text.trim();
  get isValid => isValid;
}
