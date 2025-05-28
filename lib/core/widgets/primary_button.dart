import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double height;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor = const Color(0xFFFFA000),
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.borderRadius = 10,
    this.padding = const EdgeInsets.only(bottom: 30.0),
    this.width,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: fontSize, color: textColor),
          ),
        ),
      ),
    );
  }
}