import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagerapp/controller/login/login_controller.dart';
import 'package:taskmanagerapp/controller/signup/sign_up_controller.dart';
import 'package:taskmanagerapp/controller/splash/splash_controller.dart';
import 'package:taskmanagerapp/controller/task/task_controller.dart';
import 'const/colors/colors.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark),
    );

    return ScreenUtilInit(
        ensureScreenSize: true,
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => SplashController()),
              ChangeNotifierProvider(create: (_) => LoginController()),
              ChangeNotifierProvider(create: (_) => SignupController()),
              ChangeNotifierProvider(create: (_) => TaskController()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: kwhiteColor,
                useMaterial3: true,
              ),
              onGenerateRoute: Routes.onGenerateRoute,
              initialRoute: '/',
            ),
          );
        });
  }
}
