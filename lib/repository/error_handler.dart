import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';

class AppErrorHandler {
  error({required var response, required dynamic jsonResponse}) {
    if (response.statusCode == 200) {
      //success
      toastHelper.toastWithTitleAndColor(
          jsonResponse["message"].toString(), greenColor);
      return true;
    } else if (response.statusCode == 400) {
      //Error
      toastHelper.toastWithTitleAndColor(
          jsonResponse["message"].toString(), redColor);
      // print('Error~~~~~~~~~' + jsonResponse["message"].toString());
      return false;
    } else {
      //Something went wrong
      toastHelper.toastWithTitleAndColor('Something went wrong!', redColor);
      return false;
    }
  }
}
