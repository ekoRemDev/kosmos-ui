import 'package:flutter/material.dart';

class SettingsCelluleThemeData {
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double? radius;
  final Color? iconBackgroundColor;
  final BoxConstraints? constraints;
  final double? imageWidth;
  final double? imageHeight;

  final Color? backgroundColor;
  final Color? activeBackgroundColor;
  final Color? activeIconBackgroundColor;
  final Color? overlayColor;
  final MaterialStateProperty<OutlinedBorder?>? shape;

  final double? horizontalPadding;
  final double? verticalPadding;
  final TextStyle? activeTitleStyle;
  final TextStyle? activeSubtitleStyle;

  final Gradient? iconBackgroundGradient;

  const SettingsCelluleThemeData({
    this.titleStyle,
    this.subtitleStyle,
    this.radius,
    this.backgroundColor,
    this.iconBackgroundColor,
    this.overlayColor,
    this.constraints,
    this.imageHeight,
    this.imageWidth,
    this.shape,
    this.horizontalPadding,
    this.verticalPadding,
    this.activeBackgroundColor,
    this.activeIconBackgroundColor,
    this.activeSubtitleStyle,
    this.activeTitleStyle,
    this.iconBackgroundGradient,
  });
}
