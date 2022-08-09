import 'package:core_kosmos/core_kosmos.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_kosmos_v4/form/theme.dart';

class SelectForm<T> extends StatelessWidget {
  final CustomFormFieldThemeData? theme;
  final String? fieldName;
  final String? hintText;
  final T? value;
  final TextStyle? fieldNameStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double? iconSize;
  final double? radius;
  final double? radiusDropDown;
  final IconData? icon;
  final EdgeInsetsGeometry? contentPadding;
  final List<DropdownMenuItem<T>>? items;
  final Function(T?)? onChangedSelect;
  final String? Function(T?)? validator;

  const SelectForm({
    this.theme,
    this.fieldName,
    this.hintText,
    this.value,
    this.fieldNameStyle,
    this.hintTextStyle,
    this.textStyle,
    this.backgroundColor,
    this.iconSize,
    this.radius,
    this.radiusDropDown,
    this.icon,
    this.contentPadding,
    this.items,
    this.onChangedSelect,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = loadThemeData(theme, "input_field", () => const CustomFormFieldThemeData())!;
    return Column(
      crossAxisAlignment: themeData.fieldNameAlignment,
      children: [
        Text(
          fieldName ?? "NOM FIELD",
          style: fieldNameStyle ??
              themeData.fieldNameStyle ??
              const TextStyle(color: Color(0xFF02132B), fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 7),
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: backgroundColor ?? themeData.backgroundColor ?? const Color(0xFF02132B).withOpacity(0.03),
            borderRadius: BorderRadius.circular(radius ?? themeData.selectRadius ?? 7.0),
          ),
          child: Padding(
            padding: contentPadding ?? themeData.contentPadding ?? const EdgeInsets.only(left: 20.0, right: 17),
            child: Center(
              child: DropdownButtonFormField<T>(
                borderRadius: BorderRadius.circular(radiusDropDown ?? themeData.selectRadiusDropDown ?? 7),
                elevation: 0,
                hint: Text(
                  hintText ?? "Sélectionner",
                  style: hintTextStyle ??
                      themeData.hintStyle ??
                      const TextStyle(color: Color(0xFF9299A4), fontSize: 13, fontWeight: FontWeight.w500),
                ),
                value: value,
                isExpanded: true,
                iconSize: iconSize ?? themeData.selectIconSize ?? 24.0,
                icon: Icon(icon ?? Iconsax.arrow_down_14),
                style: textStyle ??
                    themeData.fieldStyle ??
                    const TextStyle(color: Color(0xFF02132B), fontSize: 13, fontWeight: FontWeight.w500)
                        .copyWith(color: const Color(0xFF02132B)),
                items: items ?? <DropdownMenuItem<T>>[],
                onChanged: onChangedSelect ?? (_) {},
                validator: validator,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
