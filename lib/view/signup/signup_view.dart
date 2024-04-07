import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagerapp/controller/signup/sign_up_controller.dart';
import 'package:taskmanagerapp/validation/validation.dart';
import '../../const/colors/colors.dart';
import '../../const/strings/strings.dart';
import '../../const/style/styles.dart';
import '../../const/utils/utils.dart';
import '../../widgets/button/reuseable_button.dart';
import '../../widgets/textfield/reuseable_form_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    final signUpProvider = Provider.of<SignupController>(context);
    return Form(
      key: formkey,
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
                controller: signUpProvider.emailController,
                hintText: kEmailText,
                validator: passwordValidator,
              ),
              Gap(25.h),
              ReusableFormField(
                controller: signUpProvider.passwordController,
                validator: passwordValidator,
                hintText: kPasswordText,
              ),
              Gap(25.h),
              CustomButton(
                  loading: signUpProvider.isLoading,
                  height: 50.h,
                  width: 300.w,
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      if (signUpProvider.emailController.text.isNotEmpty ||
                          signUpProvider.passwordController.text.isNotEmpty) {
                        signUpProvider.setIsLoading(true);
                        signUpProvider.register(
                            signUpProvider.emailController.text.trim(),
                            signUpProvider.passwordController.text.trim(),
                            context);
                      }
                      signUpProvider.setIsLoading(false);
                    } else {
                      Utils.toastMessage('user not found');
                    }
                  },
                  text: kRegisterText)
            ],
          ),
        ),
      ),
    );
  }
}
