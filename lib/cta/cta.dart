import 'package:core_kosmos/core_kosmos.dart';
import 'package:flutter/material.dart';
import 'package:ui_kosmos_v4/cta/theme.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ui_kosmos_v4/micro_element/micro_element.dart';

abstract class CTA extends HookWidget {
  final double? height;
  final bool? isEnabled;
  final double? width;
  final double? radius;
  final Widget? child;
  final IconData? beforeIcon;
  final IconData? afterIcon;
  final IconData? backIcon;
  final String? textButton;
  final TextStyle? textButtonStyle;
  final double? distanceBetweenIconText;
  final Function? onTap;
  final VoidCallback? onDoubleTap;
  final bool circleOnTap;
  final Color? backgroundColor;
  final Icon? icon;
  final CtaThemeData? theme;
  final String? themeName;
  final BoxBorder? border;
  final LinearGradient? gradient;

  const CTA({
    this.height,
    this.isEnabled,
    this.width,
    this.radius,
    this.distanceBetweenIconText,
    this.child,
    this.beforeIcon,
    this.afterIcon,
    this.textButton,
    this.textButtonStyle,
    this.onTap,
    this.onDoubleTap,
    this.backIcon,
    this.circleOnTap = false,
    this.backgroundColor,
    this.icon,
    this.theme,
    this.themeName,
    this.border,
    this.gradient,
    Key? key,
  }) : super(key: key);

  const factory CTA.primary({
    final double? height,
    final double? width,
    final double? radius,
    final bool? isEnabled,
    final Widget? child,
    final IconData? beforeIcon,
    final IconData? afterIcon,
    final String? textButton,
    final TextStyle? textButtonStyle,
    final double? distanceBetweenIconText,
    final Function? onTap,
    final VoidCallback? onDoubleTap,
    final CtaThemeData? theme,
    final String? themeName,
    final BoxBorder? border,
    final LinearGradient? gradient,
  }) = _Primary;

  const factory CTA.secondary({
    final double? height,
    final double? width,
    final double? radius,
    final Widget? child,
    final bool? isEnabled,
    final IconData? beforeIcon,
    final IconData? afterIcon,
    final String? textButton,
    final TextStyle? textButtonStyle,
    final double? distanceBetweenIconText,
    final Function? onTap,
    final VoidCallback? onDoubleTap,
    final CtaThemeData? theme,
    final String? themeName,
    final BoxBorder? border,
    final LinearGradient? gradient,
  }) = _Secondary;

  const factory CTA.tiers({
    final double? height,
    final double? width,
    final double? radiusOnTap,
    final bool circleOnTap,
    final Function? onTap,
    final VoidCallback? onDoubleTap,
    final String? textButton,
    final TextStyle? textButtonStyle,
    final Icon? icon,
    final CtaThemeData? theme,
    final bool? isEnabled,
    final String? themeName,
    final BoxBorder? border,
  }) = _Tiers;

  const factory CTA.back({
    final double? height,
    final double? width,
    final bool? isEnabled,
    final double? radius,
    final Function? onTap,
    final VoidCallback? onDoubleTap,
    final IconData? backIcon,
    final Color backgroundColor,
    final CtaThemeData? theme,
    final String? themeName,
    final BoxBorder? border,
  }) = _Back;

  @override
  Widget build(BuildContext context) => Container();
}

class _Primary extends CTA {
  const _Primary({
    final double? height,
    final double? width,
    final double? radius,
    final bool? isEnabled,
    final Widget? child,
    final IconData? beforeIcon,
    final IconData? afterIcon,
    final String? textButton,
    final TextStyle? textButtonStyle,
    final double? distanceBetweenIconText,
    final Function? onTap,
    final VoidCallback? onDoubleTap,
    final CtaThemeData? theme,
    final String? themeName,
    final BoxBorder? border,
    final LinearGradient? gradient,
  }) : super(
          height: height,
          width: width,
          radius: radius,
          isEnabled: isEnabled,
          child: child,
          beforeIcon: beforeIcon,
          afterIcon: afterIcon,
          textButton: textButton,
          textButtonStyle: textButtonStyle,
          distanceBetweenIconText: distanceBetweenIconText,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          theme: theme,
          themeName: themeName,
          border: border,
          gradient: gradient,
        );

  @override
  Widget build(BuildContext context) {
    final themeData = loadThemeData(theme, themeName ?? "primary_button", () => const CtaThemeData())!;
    var state = useState(false);

    return Material(
      type: MaterialType.transparency,
      child: Opacity(
        opacity: isEnabled == null
            ? 1
            : isEnabled!
                ? 1
                : 0.5,
        child: Container(
          height: formatHeight(height ?? getResponsiveValue(context, defaultValue: 54, desktop: themeData.heightInWeb, phone: themeData.heightInMobile)),
          width: formatWidth(width ?? getResponsiveValue(context, defaultValue: double.infinity, desktop: themeData.widthInWeb, phone: themeData.widthInMobile)),
          constraints: themeData.constraints,
          decoration: BoxDecoration(
              color: themeData.backgroundColor ?? (gradient != null ? null : Theme.of(context).primaryColor),
              gradient: gradient ?? themeData.gradient,
              borderRadius: BorderRadius.circular(radius ?? themeData.borderRadius ?? 7),
              border: border ?? themeData.border),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: isEnabled == null || isEnabled!
                  ? () async {
                      state.value = true;
                      if (onTap != null) await onTap!();
                      state.value = false;
                    }
                  : null,
              onDoubleTap: onDoubleTap,
              borderRadius: BorderRadius.circular(radius ?? themeData.borderRadius ?? 7),
              child: state.value
                  ? Center(
                      child: LoaderClassique(
                        radius: (height ?? getResponsiveValue(context, defaultValue: 54, desktop: themeData.heightInWeb, phone: themeData.heightInMobile))! / 5,
                        activeColor: themeData.loaderColor,
                      ),
                    )
                  : child ??
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          beforeIcon != null
                              ? Icon(
                                  beforeIcon,
                                  color: Colors.white,
                                )
                              : const SizedBox(),
                          SizedBox(width: beforeIcon != null ? distanceBetweenIconText ?? themeData.distanceBetweenIconText ?? 10 : 0),
                          Text(
                            textButton ?? 'Button_Text',
                            style: textButtonStyle ?? const TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: afterIcon != null ? distanceBetweenIconText ?? themeData.distanceBetweenIconText ?? 10 : 0),
                          afterIcon != null
                              ? Icon(
                                  afterIcon,
                                  color: Colors.white,
                                )
                              : const SizedBox()
                        ],
                      ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Secondary extends CTA {
  const _Secondary({
    final double? height,
    final double? width,
    final bool? isEnabled,
    final double? radius,
    final Widget? child,
    final IconData? beforeIcon,
    final IconData? afterIcon,
    final String? textButton,
    final TextStyle? textButtonStyle,
    final double? distanceBetweenIconText,
    final Function? onTap,
    final VoidCallback? onDoubleTap,
    final CtaThemeData? theme,
    final String? themeName,
    final BoxBorder? border,
    final LinearGradient? gradient,
  }) : super(
          height: height,
          width: width,
          radius: radius,
          child: child,
          beforeIcon: beforeIcon,
          isEnabled: isEnabled,
          afterIcon: afterIcon,
          textButton: textButton,
          textButtonStyle: textButtonStyle,
          distanceBetweenIconText: distanceBetweenIconText,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          theme: theme,
          themeName: themeName,
          border: border,
          gradient: gradient,
        );

  @override
  Widget build(BuildContext context) {
    final themeData = loadThemeData(theme, themeName ?? "secondary_button", () => const CtaThemeData())!;
    var state = useState(false);

    return Material(
        type: MaterialType.transparency,
        child: Opacity(
          opacity: isEnabled == null
              ? 1
              : isEnabled!
                  ? 1
                  : 0.5,
          child: Container(
            height: formatHeight(height ?? getResponsiveValue(context, defaultValue: 54, desktop: themeData.heightInWeb, phone: themeData.heightInMobile)),
            width: formatWidth(width ?? getResponsiveValue(context, defaultValue: double.infinity, desktop: themeData.widthInWeb, phone: themeData.widthInMobile)),
            constraints: themeData.constraints,
            decoration: BoxDecoration(
              color: themeData.backgroundColor,
              gradient: gradient ?? themeData.gradient,
              borderRadius: BorderRadius.circular(radius ?? themeData.borderRadius ?? 7),
              border: border ?? themeData.border,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: isEnabled == null || isEnabled!
                    ? () async {
                        state.value = true;
                        if (onTap != null) await onTap!();
                        state.value = false;
                      }
                    : null,
                onDoubleTap: onDoubleTap,
                borderRadius: BorderRadius.circular(radius ?? themeData.borderRadius ?? 7),
                child: state.value
                    ? Center(
                        child: LoaderClassique(
                          radius: (height ?? getResponsiveValue(context, defaultValue: 54, desktop: themeData.heightInWeb, phone: themeData.heightInMobile))! / 5,
                          activeColor: themeData.loaderColor,
                        ),
                      )
                    : child ??
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            beforeIcon != null
                                ? Icon(
                                    beforeIcon,
                                    color: textButtonStyle?.color ?? themeData.textButtonStyle?.color ?? Colors.white,
                                  )
                                : const SizedBox(),
                            SizedBox(width: beforeIcon != null ? distanceBetweenIconText ?? themeData.distanceBetweenIconText ?? 10 : 0),
                            Text(
                              textButton ?? 'Button_Text',
                              style: textButtonStyle ?? themeData.textButtonStyle ?? const TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: afterIcon != null ? distanceBetweenIconText ?? themeData.distanceBetweenIconText ?? 10 : 0),
                            afterIcon != null
                                ? Icon(
                                    afterIcon,
                                    color: textButtonStyle?.color ?? themeData.textButtonStyle?.color ?? Colors.white,
                                  )
                                : const SizedBox()
                          ],
                        ),
              ),
            ),
          ),
        ));
  }
}

class _Tiers extends CTA {
  const _Tiers({
    final double? height,
    final double? width,
    final double? radiusOnTap,
    final bool? isEnabled,
    final bool circleOnTap = false,
    final Icon? icon,
    final Function? onTap,
    final VoidCallback? onDoubleTap,
    final String? textButton,
    final TextStyle? textButtonStyle,
    final CtaThemeData? theme,
    final String? themeName,
    final BoxBorder? border,
  }) : super(
          height: height,
          width: width,
          radius: radiusOnTap,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          icon: icon,
          isEnabled: isEnabled,
          textButton: textButton,
          textButtonStyle: textButtonStyle,
          circleOnTap: circleOnTap,
          theme: theme,
          themeName: themeName,
          border: border,
        );

  @override
  Widget build(BuildContext context) {
    final themeData = loadThemeData(theme, themeName ?? "tiers_button", () => const CtaThemeData())!;
    return Opacity(
      opacity: isEnabled == null
          ? 1
          : isEnabled!
              ? 1
              : 0.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(circleOnTap ? 1000 : radius ?? themeData.borderRadius ?? 14),
        onTap: isEnabled == null || isEnabled!
            ? () async {
                if (onTap != null) await onTap!();
              }
            : null,
        onDoubleTap: onDoubleTap,
        child: Container(
          width: width,
          height: height,
          constraints: BoxConstraints(
            minHeight: formatHeight(height ?? getResponsiveValue(context, defaultValue: 54, desktop: themeData.widthInWeb, phone: themeData.widthInMobile)),
            minWidth: formatHeight(height ?? getResponsiveValue(context, defaultValue: 54, desktop: themeData.heightInWeb, phone: themeData.heightInMobile)),
          ),
          decoration: BoxDecoration(
            border: border ?? themeData.border,
            borderRadius: BorderRadius.all(Radius.circular(themeData.borderRadius ?? 0)),
          ),
          padding: const EdgeInsets.all(15.0),
          child: IntrinsicWidth(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon != null ? icon! : const SizedBox(),
                icon != null && textButton != null
                    ? const SizedBox(
                        width: 9.5,
                      )
                    : const SizedBox(),
                textButton != null ? Text(textButton!, style: textButtonStyle) : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Back extends CTA {
  const _Back({
    final double? height,
    final double? width,
    final double? radius,
    final bool? isEnabled,
    final IconData? backIcon,
    final Function? onTap,
    final VoidCallback? onDoubleTap,
    final Color backgroundColor = Colors.white,
    final CtaThemeData? theme,
    final String? themeName,
    final BoxBorder? border,
  }) : super(
          height: height,
          width: width,
          isEnabled: isEnabled,
          radius: radius,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          backIcon: backIcon,
          backgroundColor: backgroundColor,
          theme: theme,
          themeName: themeName,
          border: border,
        );

  @override
  Widget build(BuildContext context) {
    final themeData = loadThemeData(theme, themeName ?? "back_button", () => const CtaThemeData())!;
    return Material(
        type: MaterialType.transparency,
        child: Opacity(
          opacity: isEnabled == null
              ? 1
              : isEnabled!
                  ? 1
                  : 0.5,
          child: InkWell(
            onTap: isEnabled == null || isEnabled!
                ? () async {
                    if (onTap != null) await onTap!();
                  }
                : null,
            onDoubleTap: onDoubleTap,
            child: Container(
              height: formatHeight(height ?? getResponsiveValue(context, defaultValue: 47, desktop: themeData.heightInWeb, phone: themeData.heightInMobile)),
              width: formatHeight(height ?? getResponsiveValue(context, defaultValue: 47, desktop: themeData.widthInWeb, phone: themeData.widthInMobile)),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius ?? themeData.borderRadius ?? 14),
                border: border ?? themeData.border,
              ),
              child: Material(
                type: MaterialType.transparency,
                child: Icon(backIcon ?? Icons.arrow_back_ios_new_rounded),
              ),
            ),
          ),
        ));
  }
}
