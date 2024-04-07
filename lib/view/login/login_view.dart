import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagerapp/controller/login/login_controller.dart';
import 'package:taskmanagerapp/validation/validation.dart';
import '../../const/colors/colors.dart';
import '../../const/strings/strings.dart';
import '../../const/style/styles.dart';
import '../../const/utils/utils.dart';
import '../../widgets/button/reuseable_button.dart';
import '../../widgets/textfield/reuseable_form_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
    final loginProvider = Provider.of<LoginController>(context);
    return Form(
      key: loginFormKey,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Gap(79.h),
              Text(
                kWELCOMEText,
                style: kmyTS14(
                    color: kblackColor, size: 32.sp, weight: FontWeight.w600),
              ),
              Gap(70.h),
              ReusableFormField(
                controller: loginProvider.emailController,
                hintText: kEmailText,
                validator: passwordValidator,
              ),
              Gap(25.h),
              ReusableFormField(
                controller: loginProvider.passwordController,
                validator: passwordValidator,
                hintText: kPasswordText,
              ),
              Gap(25.h),
              CustomButton(
                  loading: loginProvider.isLoading,
                  height: 50.h,
                  width: 300.w,
                  onPressed: () async {
                    if (loginFormKey.currentState!.validate()) {
                      if (loginProvider.emailController.text.isNotEmpty ||
                          loginProvider.passwordController.text.isNotEmpty) {
                        loginProvider.setIsLoading(true);
                        loginProvider.login(
                            loginProvider.emailController.text.trim(),
                            loginProvider.passwordController.text.trim(),
                            context);
                      }
                      loginProvider.setIsLoading(false);
                    } else {
                      Utils.toastMessage('user not found');
                    }
                  },
                  text: kLoginText),
            ],
          ),
        ),
      ),
    );
  }
}
