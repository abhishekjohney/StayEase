import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class LoginStyles {
  static InputDecoration getTextFieldDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppStyles.body2,
      prefixIcon: Icon(prefixIcon, color: AppStyles.textSecondaryColor),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppStyles.cardColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppStyles.spacing16,
        vertical: AppStyles.spacing16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        borderSide: const BorderSide(color: AppStyles.secondaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        borderSide:
            BorderSide(color: AppStyles.secondaryColor.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        borderSide: const BorderSide(color: AppStyles.primaryColor),
      ),
    );
  }

  static InputDecoration getDropdownDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppStyles.body2,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppStyles.spacing16,
        vertical: AppStyles.spacing12,
      ),
      filled: true,
      fillColor: AppStyles.cardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        borderSide: const BorderSide(color: AppStyles.secondaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        borderSide:
            BorderSide(color: AppStyles.secondaryColor.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        borderSide: const BorderSide(color: AppStyles.primaryColor),
      ),
    );
  }

  static ButtonStyle getButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppStyles.primaryColor,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: AppStyles.getResponsivePadding(context),
        vertical: AppStyles.spacing16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
      ),
      minimumSize: const Size(double.infinity, 48),
    );
  }

  static BoxDecoration socialButtonDecoration = BoxDecoration(
    color: AppStyles.cardColor,
    borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
    border: Border.all(color: AppStyles.secondaryColor.withOpacity(0.2)),
  );
}
