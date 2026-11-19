import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:raiser_amc/core/theme/app_colors.dart';
import 'package:raiser_amc/core/theme/app_fonts.dart';
import 'package:raiser_amc/core/utils/custom_button.dart';
import 'package:raiser_amc/core/utils/custom_snackbar.dart';
import 'package:raiser_amc/core/utils/custom_text_field.dart';
import 'package:raiser_amc/core/utils/app_validators.dart';
import 'package:raiser_amc/ui/authentication/view/login_screen.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> otpFocusNodes = List.generate(4, (_) => FocusNode());

  bool isOtpStep = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();

    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final node in otpFocusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void continueToOtp() {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isOtpStep = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        otpFocusNodes[0].requestFocus();
      }
    });
  }

  void verifyOtp() {
    final otp = otpControllers.map((e) => e.text).join();

    if (otp.length != 4) {
      AppSnackbar.show(
        title: 'Invalid OTP',
        message: 'Please enter a valid 4 digit OTP',
        isSuccess: false,
      );
      return;
    }

    // TODO: Verify OTP API call here.

    AppSnackbar.show(
      title: 'OTP Verified',
      message: 'Your mobile number has been verified successfully.',
      isSuccess: true,
    );
  }

  Widget buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.7.h),
          decoration: BoxDecoration(
            color: !isOtpStep
                ? AppColors.primarySurface
                : AppColors.surfaceSecondary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: !isOtpStep ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Text(
            '1 Account',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: AppFonts.semiBold,
              color: !isOtpStep ? AppColors.primary : AppColors.textMuted,
            ),
          ),
        ),
        Container(
          width: 7.w,
          height: 1,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          color: AppColors.border,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.7.h),
          decoration: BoxDecoration(
            color: isOtpStep
                ? AppColors.primarySurface
                : AppColors.surfaceSecondary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isOtpStep ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Text(
            '2 Mobile OTP',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: AppFonts.semiBold,
              color: isOtpStep ? AppColors.primary : AppColors.textMuted,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOtpBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 13.w,
          height: 7.h,
          child: TextField(
            controller: otpControllers[index],
            focusNode: otpFocusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(
              fontSize: 20.sp,
              fontFamily: AppFonts.bold,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: AppColors.white,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                otpFocusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                otpFocusNodes[index - 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                SizedBox(height: 3.h),

                // Existing Header UI
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 25.w,
                        width: 25.w,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3978FF), Color(0xFF4F46E5)],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.25),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'R',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontFamily: AppFonts.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 2.5.h),

                      Text(
                        'Create Admin Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: AppFonts.bold,
                          color: AppColors.textPrimary,
                          letterSpacing: 1.2,
                        ),
                      ),

                      SizedBox(height: 0.5.h),

                      Text(
                        'Get started by Raiser AMC platform',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: AppFonts.regular,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 3.h),

                buildStepIndicator(),

                SizedBox(height: 3.h),

                if (!isOtpStep)
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'Full Name',
                          hintText: 'Enter your Full Name',
                          inputType: TextInputType.name,
                          prefixIcon: Icons.person_outline,
                          controller: nameController,
                          validator: AppValidators.validateName,
                        ),

                        SizedBox(height: 2.h),

                        CustomTextField(
                          label: 'Email Address',
                          hintText: 'Enter your email address',
                          inputType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          controller: emailController,
                          validator: AppValidators.validateEmail,
                        ),

                        SizedBox(height: 2.h),

                        CustomTextField(
                          label: 'Mobile Number (for SMS OTP)',
                          hintText: 'Enter your mobile number',
                          inputType: TextInputType.phone,
                          prefixIcon: Icons.phone_outlined,
                          controller: mobileController,
                          validator: AppValidators.validatePhoneNumber,
                        ),

                        SizedBox(height: 2.h),

                        CustomTextField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock_outline,
                          controller: passwordController,
                          isPassword: true,
                          validator: AppValidators.validatePassword,
                        ),
                      ],
                    ),
                  ),

                if (isOtpStep) ...[
                  SizedBox(height: 1.h),

                  Icon(
                    Icons.verified_user_outlined,
                    size: 35.sp,
                    color: AppColors.primary,
                  ),

                  SizedBox(height: 2.h),

                  Text(
                    'Mobile OTP Verification',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontFamily: AppFonts.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: 1.h),

                  Text(
                    'Enter the 4 digit OTP sent to',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: AppFonts.regular,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: 0.5.h),

                  Text(
                    '+91 ${mobileController.text}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: AppFonts.semiBold,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 3.h),

                  buildOtpBoxes(),

                  SizedBox(height: 2.h),

                  TextButton(
                    onPressed: () {
                      for (final controller in otpControllers) {
                        controller.clear();
                      }
                      otpFocusNodes[0].requestFocus();
                    },
                    child: Text(
                      'Resend OTP',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: AppFonts.semiBold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],

                SizedBox(height: 2.5.h),

                CustomButton(
                  text: isOtpStep ? 'Verify OTP' : 'OTP Verification',
                  width: double.infinity,
                  height: 5.5.h,
                  showArrow: true,
                  onPressed: isOtpStep ? verifyOtp : continueToOtp,
                ),

                if (isOtpStep)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isOtpStep = false;
                      });
                    },
                    child: Text(
                      'Back to Account Details',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: AppFonts.semiBold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                SizedBox(height: 2.h),

                SizedBox(height: 1.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: AppFonts.regular,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(()=> LoginScreen());
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: AppFonts.semiBold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
