import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import '../res/app_colors.dart';
import '../res/app_dimensions.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double height;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.black,
    this.borderRadius = AppDimensions.radiusMedium,
    this.height = AppDimensions.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                title,
                style: text14(color: textColor, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}

class CustomContainerButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double width;

  const CustomContainerButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.black,
    this.borderRadius = AppDimensions.radiusMedium,
    this.height = AppDimensions.buttonHeight,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        //  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  title,
                  style: text11(color: textColor, fontWeight: FontWeight.w600),
                ),
        ),
      ),
    );
  }
}

Widget elevatedButton({
  required String text,
  VoidCallback? onPressed,
  required Color background,
  required Color textColor,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: background, // ✅ button background
      foregroundColor: textColor, // ✅ text/icon color
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    child: Text(
      text,
      style: text14(
        fontWeight: FontWeight.w600,
        color: textColor,
      ).copyWith(height: 1.1),
    ),
  );
}

Widget customOutlineButton({
  required String text,
  required VoidCallback onPressed,
  Color borderColor = AppColors.buttonText,
  Color textColor = AppColors.textPrimary,
  double borderRadius = 20,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
}) {
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: borderColor, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: padding,
    ),
    child: Text(
      text,
      style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
    ),
  );
}

Widget customIconButton({
  required IconData icon,
  VoidCallback? onPressed,
  Color backgroundColor = Colors.white,
  Color iconColor = Colors.black,
  double size = 40,
  double iconSize = 20,
  double borderRadius = 12,
}) {
  return IconButton(
    padding: EdgeInsets.all(0),
    onPressed: onPressed, // can be null
    icon: Icon(icon),
    iconSize: iconSize,
    color: iconColor,
  );
}

class CustomElevatedIconButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double iconSize;
  final EdgeInsets padding;

  const CustomElevatedIconButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = AppColors.secondary,
    this.textColor = AppColors.white,
    this.borderRadius = AppDimensions.radiusExtraLarge,
    this.iconSize = 18,
    this.padding = const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: iconSize, color: textColor),
      label: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 2,
      ),
    );
  }
}

Widget textButton(String text, VoidCallback onTap) {
  return TextButton(
    onPressed: onTap,
    child: Text(text, style: text13(fontWeight: FontWeight.w600)),
  );
}
