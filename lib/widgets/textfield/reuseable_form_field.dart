import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../const/colors/colors.dart';
import '../../const/style/styles.dart';

class ReusableFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;

  const ReusableFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 300.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: kblackColor,
          width: 1.w,
        ),
      ),
      child: TextFormField(
        clipBehavior: Clip.none,
        style:
            kmyTS14(color: kblackColor, size: 15.sp, weight: FontWeight.w400),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15.w),
            labelText: labelText,
            hintText: hintText,
            hintStyle: kmyTS14(
                color: kblackColor, size: 15.sp, weight: FontWeight.w400),
            border: InputBorder.none),
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obscureText!,
        onChanged: onChanged,
      ),
    );
  }
}
