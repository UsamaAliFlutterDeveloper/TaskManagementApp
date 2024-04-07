import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagerapp/const/colors/colors.dart';
import 'package:taskmanagerapp/const/style/styles.dart';
import 'package:taskmanagerapp/controller/splash/splash_controller.dart';

import '../../const/strings/strings.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashController>(context).navigateToView(context);
    return Scaffold(
      backgroundColor: kOrangeColor,
      body: Center(
        child: Text(
          kTaskManagerAppText,
          style: kmyTS14(
            color: kwhiteColor,
            size: 24.sp,
            weight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
