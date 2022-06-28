import 'package:flutter/material.dart';

class CtaThemeData {
  final double? width;
  final double? height;
  final double? widthInWeb;
  final double? heightInWeb;
  final double? widthInMobile;
  final double? heightInMobile;
  final BoxConstraints? constraints;
  final TextStyle? textButtonStyle;
  final double? distanceBetweenIconText;
  final Color? backgroundColor;
  final double? borderRadius;
  final BoxBorder? border;

  const CtaThemeData({
    this.width,
    this.height,
    this.widthInWeb,
    this.widthInMobile,
    this.heightInWeb,
    this.heightInMobile,
    this.constraints,
    this.backgroundColor,
    this.distanceBetweenIconText,
    this.textButtonStyle,
    this.borderRadius,
    this.border,
  });
}
