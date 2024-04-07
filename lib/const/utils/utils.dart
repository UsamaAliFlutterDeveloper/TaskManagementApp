import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanagerapp/const/colors/colors.dart';

class Utils {
  static Future<void> toastMessage(String msg, {bgColor = kOrangeColor}) async {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: bgColor,
      textColor: kwhiteColor,
      fontSize: 14.sp,
    );
  }
}
