import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback? onPressed;
  final double? height;
  final Color? backgroundColor;
  final Color? colorText;
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.loading = false,
    this.height,
    this.backgroundColor,
    this.colorText,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: loading,
      child: SizedBox(
        width: double.infinity,
        height: height ?? 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: loading
                ? AppColors.primary.withValues(alpha: .7)
                : backgroundColor ?? AppColors.primary,
            disabledBackgroundColor: AppColors.primary.withValues(alpha: .7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: loading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorText ?? Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
