import 'package:core_kosmos/core_kosmos.dart';
import 'package:flutter/material.dart';
import 'package:ui_kosmos_v4/settings_cellule/theme.dart';

class SettingsCellule extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final VoidCallback onClick;
  final Widget? switchNotif;

  final ImageProvider? image;
  final Widget? icon;
  final Widget? svg;

  final Color? backgroundColor;
  final Color? iconBackgroundColor;
  final Color? overlayColor;
  final double? radius;

  final String? themeName;
  final SettingsCelluleThemeData? theme;

  const SettingsCellule({
    this.radius,
    this.switchNotif,
    this.iconBackgroundColor,
    this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    required this.onClick,
    this.image,
    this.icon,
    this.svg,
    this.backgroundColor,
    this.overlayColor,
    this.theme,
    this.themeName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = loadThemeData(theme, themeName ?? "settings_cellule", () => const SettingsCelluleThemeData())!;

    return ConstrainedBox(
      constraints: themeData.constraints ??
          BoxConstraints(
            minHeight: 60,
            maxWidth: execInCaseOfPlatfom(() => getResponsiveValue(context, defaultValue: 293, tablet: double.infinity), () => double.infinity),
            minWidth: formatWidth(293),
          ),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: themeData.backgroundColor ?? MaterialStateProperty.resolveWith((states) => backgroundColor ?? const Color(0xFF02132B).withOpacity(0.03)),
          overlayColor: themeData.overlayColor ??
              MaterialStateProperty.resolveWith((states) => overlayColor ?? darkenOrLighten(backgroundColor ?? const Color(0xFF02132B).withOpacity(0.03))),
          shape: themeData.shape ?? MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular((radius ?? 7)))),
        ),
        onPressed: onClick,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: themeData.horizontalPadding ?? 10, vertical: themeData.verticalPadding ?? 0),
              child: (icon != null || svg != null || image != null)
                  ? Container(
                      height: formatHeight(themeData.imageHeight ?? 37),
                      width: formatWidth(themeData.imageWidth ?? 37),
                      decoration: image != null
                          ? BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: image!))
                          : BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                      child: icon ?? svg ?? const SizedBox(),
                    )
                  : const SizedBox(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title ?? 'Titre',
                          style: titleStyle ?? themeData.titleStyle ?? const TextStyle(color: Color(0xFF02132B), fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  subtitle != null
                      ? Text(
                          subtitle!,
                          style: subtitleStyle ?? themeData.subtitleStyle ?? TextStyle(color: const Color(0xFF02132B).withOpacity(0.65), fontSize: 11, fontWeight: FontWeight.w500),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            switchNotif == null
                ? execInCaseOfPlatfom(
                    () => getResponsiveValue(
                      context,
                      defaultValue: const SizedBox(),
                      tablet: Icon(
                        Icons.chevron_right_rounded,
                        color: Theme.of(context).iconTheme.color ?? const Color(0xFFA4AAB2),
                        size: (themeData.imageWidth ?? 37) - 17,
                      ),
                    ),
                    () => Icon(
                      Icons.chevron_right_rounded,
                      color: Theme.of(context).iconTheme.color ?? const Color(0xFFA4AAB2),
                      size: (themeData.imageWidth ?? 37) - 17,
                    ),
                  )
                : switchNotif!
          ],
        ),
      ),
    );
  }
}

Color darkenOrLighten(Color color) {
  double amount = color.computeLuminance();
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  if (amount < 0.8) {
    final hslLight = hsl.withLightness(((hsl.lightness + amount) / 3).clamp(0.3, 1.0));

    return hslLight.toColor();
  } else {
    final hslDark = hsl.withLightness((hsl.lightness - amount / 4).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}