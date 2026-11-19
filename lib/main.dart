import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raiser_amc/core/theme/app_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:raiser_amc/core/theme/app_colors.dart';
import 'package:raiser_amc/ui/authentication/view/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Raiser AMC',

          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            primaryColor: AppColors.primary,

            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
              secondary: AppColors.secondary,
              surface: AppColors.surface,
              error: AppColors.error,
            ),

            scaffoldBackgroundColor: AppColors.background,

            fontFamily: AppFonts.regular,

            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              centerTitle: false,
            ),

            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),

          home: LoginScreen(),
        );
      },
    );
  }
}
