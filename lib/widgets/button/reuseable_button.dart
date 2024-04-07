import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../const/colors/colors.dart';
import '../../const/style/styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? height;
  final double? width;
  final bool loading;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.height = 50,
      this.width = 300,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kOrangeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: loading
            ? Center(
                child: SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: kwhiteColor,
                  ),
                ),
              )
            : Text(
                text,
                style: kmyTS14(
                    color: kblackColor, size: 20.sp, weight: FontWeight.w600),
              ),
      ),
    );
  }
}
