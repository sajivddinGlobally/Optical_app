import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/core/widgets/optical_logo.dart';

// =============================================================================
// 1. BUTTON VARIANTS (VOC Design System)
// =============================================================================
enum VocButtonVariant {
  primaryDark,
  secondaryDark,
  lightGrey,
  outlined,
  disabled,
  danger,
}

class VocButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final VocButtonVariant variant;
  final double? width;
  final double? height;
  final Widget? prefixIcon;

  const VocButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = VocButtonVariant.primaryDark,
    this.width,
    this.height,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case VocButtonVariant.primaryDark:
        bgColor = AppColors.primaryDark;
        textColor = Colors.white;
        break;
      case VocButtonVariant.secondaryDark:
        bgColor = const Color(0xFF1E293B);
        textColor = Colors.white;
        break;
      case VocButtonVariant.lightGrey:
        bgColor = const Color(0xFFEEF2F6);
        textColor = const Color(0xFF1E293B);
        break;
      case VocButtonVariant.outlined:
        bgColor = Colors.white;
        textColor = const Color(0xFF1E293B);
        borderSide = BorderSide(color: const Color(0xFFCBD5E1), width: 1.w);
        break;
      case VocButtonVariant.disabled:
        bgColor = const Color(0xFFF1F5F9);
        textColor = const Color(0xFF94A3B8);
        break;
      case VocButtonVariant.danger:
        bgColor = AppColors.danger;
        textColor = Colors.white;
        break;
    }

    final isClickable =
        variant != VocButtonVariant.disabled && onPressed != null;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 46.h,
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          onTap: isClickable ? onPressed : null,
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: borderSide != BorderSide.none
                  ? Border.fromBorderSide(borderSide)
                  : null,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) ...[prefixIcon!, SizedBox(width: 8.w)],
                Text(
                  text,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    letterSpacing: -0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 2. SCREEN HEADER (< Screen Title ... Help)
// =============================================================================
class VocScreenHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;
  final VoidCallback? onHelpTap;
  final String helpText;

  const VocScreenHeader({
    super.key,
    required this.title,
    this.onBackTap,
    this.onHelpTap,
    this.helpText = 'Help',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: onBackTap ?? () => Navigator.of(context).maybePop(),
                borderRadius: BorderRadius.circular(20.r),
                child: Padding(
                  padding: EdgeInsets.all(6.w),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: onHelpTap,
            borderRadius: BorderRadius.circular(6.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Text(
                helpText,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF475569),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 3. INPUT FIELD (Default, Focused, Error)
// =============================================================================
class VocInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool hasError;
  final String? errorMessage;
  final bool isFocused;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;

  const VocInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.hasError = false,
    this.errorMessage,
    this.isFocused = false,
    this.focusNode,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    double borderWidth = 1.0;

    if (hasError) {
      borderColor = AppColors.inputError;
      borderWidth = 1.3;
    } else if (isFocused) {
      borderColor = AppColors.primaryDark;
      borderWidth = 1.3;
    } else {
      borderColor = const Color(0xFFCBD5E1);
      borderWidth = 1.0;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: borderColor, width: borderWidth.w),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5.sp,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                color: const Color(0xFF94A3B8),
                fontWeight: FontWeight.w400,
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        if (hasError && errorMessage != null) ...[
          SizedBox(height: 4.h),
          Text(
            errorMessage!,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.inputError,
            ),
          ),
        ],
      ],
    );
  }
}

// =============================================================================
// 4. CHIPS (Right eye / Left eye selector)
// =============================================================================
class VocEyeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const VocEyeChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primaryDark : Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryDark
                  : const Color(0xFFCBD5E1),
              width: 1.w,
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF334155),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 5. STATUS BADGES (Green, Yellow, Red, Blue, Slate, Purple)
// =============================================================================
enum VocBadgeVariant { green, yellow, red, blue, slate, purple }

class VocStatusBadge extends StatelessWidget {
  final String label;
  final VocBadgeVariant variant;
  final bool showDot;

  const VocStatusBadge({
    super.key,
    required this.label,
    this.variant = VocBadgeVariant.green,
    this.showDot = true,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color dotColor;
    Color textColor;

    switch (variant) {
      case VocBadgeVariant.green:
        bgColor = AppColors.badgeGreenBg;
        dotColor = AppColors.badgeGreenDot;
        textColor = AppColors.badgeGreenText;
        break;
      case VocBadgeVariant.yellow:
        bgColor = AppColors.badgeYellowBg;
        dotColor = AppColors.badgeYellowDot;
        textColor = AppColors.badgeYellowText;
        break;
      case VocBadgeVariant.red:
        bgColor = AppColors.badgeRedBg;
        dotColor = AppColors.badgeRedDot;
        textColor = AppColors.badgeRedText;
        break;
      case VocBadgeVariant.blue:
        bgColor = AppColors.badgeBlueBg;
        dotColor = AppColors.badgeBlueDot;
        textColor = AppColors.badgeBlueText;
        break;
      case VocBadgeVariant.purple:
        bgColor = AppColors.badgePurpleBg;
        dotColor = AppColors.badgePurpleDot;
        textColor = AppColors.badgePurpleText;
        break;
      case VocBadgeVariant.slate:
        bgColor = AppColors.badgeSlateBg;
        dotColor = AppColors.badgeSlateDot;
        textColor = AppColors.badgeSlateText;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.5.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 5.w),
          ],
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 6. TOGGLE SWITCH
// =============================================================================
class VocToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const VocToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 44.w,
        height: 24.h,
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: value ? AppColors.primaryDark : const Color(0xFFE2E8F0),
        ),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20.w,
          height: 20.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 7. SPH (Sphere) / POWER FIELD STEPPER
// =============================================================================
class VocPowerStepper extends StatelessWidget {
  final String label;
  final double value;
  final double step;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const VocPowerStepper({
    super.key,
    this.label = 'SPH (Sphere)',
    required this.value,
    this.step = 0.25,
    this.min = -20.00,
    this.max = 20.00,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final formattedValue = value >= 0
        ? '+${value.toStringAsFixed(2)}'
        : value.toStringAsFixed(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64748B),
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Decrement Button [-]
              _buildStepperButton(
                icon: Icons.remove,
                onTap: value - step >= min
                    ? () => onChanged(
                        double.parse((value - step).toStringAsFixed(2)),
                      )
                    : null,
              ),

              // Value Display
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  formattedValue,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              // Increment Button [+]
              _buildStepperButton(
                icon: Icons.add,
                onTap: value + step <= max
                    ? () => onChanged(
                        double.parse((value + step).toStringAsFixed(2)),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepperButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6.r),
        child: Container(
          width: 28.w,
          height: 28.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
          ),
          child: Icon(
            icon,
            size: 15.sp,
            color: onTap != null
                ? AppColors.textPrimary
                : const Color(0xFF94A3B8),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 8. LIST ROW (Icon box, Row title, Supporting text, Chevron)
// =============================================================================
class VocListRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String supportingText;
  final VoidCallback? onTap;

  const VocListRow({
    super.key,
    required this.icon,
    required this.title,
    required this.supportingText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
        child: Row(
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 20.sp, color: const Color(0xFF475569)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    supportingText,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 18.sp,
              color: const Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 9. BRANDING HEADER (Vishal Optical Co. / Lens ordering)
// =============================================================================
class VocBrandingHeader extends StatelessWidget {
  final String companyName;
  final String subtitle;

  const VocBrandingHeader({
    super.key,
    this.companyName = 'Vishal Optical Co.',
    this.subtitle = 'Lens ordering',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38.w,
          height: 38.w,
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          child: const OpticalLogoWidget(
            width: 22,
            height: 12,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              companyName,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              subtitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
