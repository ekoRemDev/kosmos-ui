import 'package:flutter/material.dart';

class SettingsCelluleThemeData {
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double? radius;
  final Color? iconBackgroundColor;
  final BoxConstraints? constraints;
  final double? imageWidth;
  final double? imageHeight;

  final MaterialStateProperty<Color?>? backgroundColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final MaterialStateProperty<OutlinedBorder?>? shape;

  final double? horizontalPadding;
  final double? verticalPadding;

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
  });
}
