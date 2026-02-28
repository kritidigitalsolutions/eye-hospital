import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../res/app_colors.dart';
import '../res/app_dimensions.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isNumberOnly;
  final Color filledColor;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isNumberOnly = false,
    this.filledColor = AppColors.primary,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: text16(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      controller: controller,
      keyboardType: isNumberOnly ? TextInputType.number : keyboardType,
      validator: validator,
      maxLength: maxLength,

      inputFormatters: isNumberOnly
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      decoration: InputDecoration(
        counterText: "",
        hintText: hintText,
        hintStyle: text14(
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: filledColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class OtpTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final int index; // ← naya add karo
  final Function(String) onChanged;
  final Function(int) onBackspace; // ← naya callback

  const OtpTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.index,
    required this.onChanged,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        autofocus: index == 0, // pehla box auto focus
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
        // Backspace ko yahan se pakdo (better than RawKeyboardListener in most cases)
        onEditingComplete: () {
          // optional: next field pe ja sakta hai
        },
        // Key event ko override kar rahe hain
        onSubmitted: (value) {
          // Enter press hone par next ya submit
        },
      ),
    );
  }
}

class CustomTextFieldWithBorder extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isNumberOnly;
  final bool readOnly;
  final Color filledColor;
  final IconData? prefixIcon;
  final double borderRadius;
  final VoidCallback? onTap;
  final int? maxLength;
  final int? maxLine;
  final ValueChanged<String>? onChanged;

  const CustomTextFieldWithBorder({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.readOnly = false,
    this.isNumberOnly = false,
    this.filledColor = AppColors.white,
    this.borderRadius = AppDimensions.radiusMedium,
    this.maxLine = 1,
    this.maxLength,
    this.onTap,
    this.prefixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onChanged: onChanged,
      maxLines: maxLine,
      style: text16(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      controller: controller,
      keyboardType: isNumberOnly ? TextInputType.number : keyboardType,
      validator: validator,
      maxLength: maxLength,
      onTap: onTap,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: isNumberOnly
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        counterText: "",
        hintText: hintText,
        hintStyle: text14(
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: filledColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColors.textPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
