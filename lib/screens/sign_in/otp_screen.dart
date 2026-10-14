import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/screens/sign_up/invitation_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/core/widgets/voc_components.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({super.key, this.phoneNumber = '+91  98765 43210'});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  Timer? _timer;
  int _resendSeconds = 30;
  bool _canResend = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    setState(() {
      _resendSeconds = 30;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() {
          _resendSeconds--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Pinput Themes based on VOC Design Tokens
    final defaultPinTheme = PinTheme(
      width: 58.w,
      height: 56.h,
      textStyle: GoogleFonts.plusJakartaSans(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2.w),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.primaryDark, width: 1.6.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.primaryDark, width: 1.2.w),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.inputError, width: 1.5.w),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldLight,
        body: SafeArea(
          child: Column(
            children: [
              // Screen Header with Back & Help
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: VocScreenHeader(
                  title: 'Verification',
                  onBackTap: () => Navigator.of(context).maybePop(),
                  onHelpTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'For help, contact Vishal Optical support at support@vishaloptical.com',
                          style: GoogleFonts.plusJakartaSans(fontSize: 12.sp),
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 8.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),

                      // Brand Header (Logo + Company Name)
                      const VocBrandingHeader(
                        companyName: 'Vishal Optical Co.',
                        subtitle: 'Lens ordering',
                      ),

                      SizedBox(height: 28.h),

                      // Heading Title
                      Text(
                        'Enter 4-digit code',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Subtitle with Phone Number
                      RichText(
                        text: TextSpan(
                          text: 'We sent a verification code to ',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(
                              text: widget.phoneNumber,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 4.h),

                      // Edit phone number button
                      InkWell(
                        onTap: () => Navigator.of(context).maybePop(),
                        borderRadius: BorderRadius.circular(4.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.edit_outlined,
                                size: 13.sp,
                                color: AppColors.primaryDark,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Change mobile number',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryDark,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // OTP Input (Pinput)
                      Center(
                        child: Pinput(
                          controller: _pinController,
                          focusNode: _pinFocusNode,
                          length: 4,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          errorPinTheme: errorPinTheme,
                          forceErrorState: _hasError,
                          separatorBuilder: (index) => SizedBox(width: 14.w),
                          onChanged: (value) {
                            if (_hasError) {
                              setState(() {
                                _hasError = false;
                              });
                            }
                          },
                          onCompleted: (pin) {
                            // _onVerify();
                          },
                        ),
                      ),

                      if (_hasError) ...[
                        SizedBox(height: 8.h),
                        Center(
                          child: Text(
                            'Please enter valid 4-digit OTP code',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.inputError,
                            ),
                          ),
                        ),
                      ],

                      SizedBox(height: 28.h),

                      // Verify & Continue Button
                      VocButton(
                        text: 'Verify & Continue',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => InvitationScreen(),
                            ),
                          );
                        },
                        variant: VocButtonVariant.primaryDark,
                      ),

                      SizedBox(height: 20.h),

                      // Resend Code Section
                      Center(
                        child: _canResend
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Didn't receive code? ",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12.5.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: _startResendTimer,
                                    borderRadius: BorderRadius.circular(4.r),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 2.h,
                                      ),
                                      child: Text(
                                        'Resend OTP',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryDark,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    size: 14.sp,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    'Resend code in 00:${_resendSeconds.toString().padLeft(2, '0')}',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12.5.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                      ),

                      SizedBox(height: 32.h),

                      // Security Info Banner (VOC Token Design)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.infoCardBg,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFFBFDBFE),
                            width: 1.w,
                          ),
                        ),
                        padding: EdgeInsets.all(14.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              size: 18.sp,
                              color: AppColors.infoIcon,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Secure 2-Factor Login',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12.5.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    'For account security, never share your OTP with anyone, including Vishal Optical representatives.',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textSecondary,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
