import 'dart:io';

import 'package:core_kosmos/core_kosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_kosmos_v4/form/theme.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract class Input extends HookWidget {
  final double? height;
  final String? fieldName;
  final TextStyle? fieldNameStyle;
  final String? fieldPostRedirection;
  final TextStyle? fieldPostRedirectionStyle;
  final VoidCallback? postFieldOnClick;
  final Widget? child;
  final String? svgIconPath;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final File? image;
  final BoxDecoration? boxDecoration;
  final double? inkRadius;
  final EdgeInsets? contentPadding;
  final double? imageRadius;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double? widthImage;

  final CustomFormFieldThemeData? theme;

  final List<FileNameItem>? listNameFiles;
  final Function(File?)? onChanged;
  final File? defaultFile;
  final List<File?>? defaultFileList;
  final Function(List<File?>?)? onMultipleChanged;

  const Input({
    this.theme,
    this.height,
    this.child,
    this.svgIconPath,
    this.onTap,
    this.onDoubleTap,
    this.image,
    this.boxDecoration,
    this.inkRadius,
    this.contentPadding,
    this.imageRadius,
    this.textStyle,
    this.iconColor,
    this.widthImage,
    this.listNameFiles,
    this.fieldName,
    this.fieldNameStyle,
    this.fieldPostRedirection,
    this.fieldPostRedirectionStyle,
    this.postFieldOnClick,
    this.defaultFile,
    this.onChanged,
    this.defaultFileList,
    this.onMultipleChanged,
    Key? key,
  }) : super(key: key);

  const factory Input.image({
    final double? height,
    final String? svgIconPath,
    final String? fieldName,
    final TextStyle? fieldNameStyle,
    final String? fieldPostRedirection,
    final TextStyle? fieldPostRedirectionStyle,
    final VoidCallback? postFieldOnClick,
    final VoidCallback? onTap,
    final VoidCallback? onDoubleTap,
    final File? image,
    final BoxDecoration? boxDecoration,
    final double? inkRadius,
    final EdgeInsets? contentPadding,
    final double? imageRadius,
    final TextStyle? textStyle,
    final Color? iconColor,
    final double? widthImage,
    final CustomFormFieldThemeData? theme,
    final Function(File?)? onChanged,
    final File? defaultFile,
  }) = _OneImage;

  const factory Input.files({
    final String? svgIconPath,
    final VoidCallback? onTap,
    final VoidCallback? onDoubleTap,
    final BoxDecoration? boxDecoration,
    final double? inkRadius,
    final EdgeInsets? contentPadding,
    final String? fieldName,
    final TextStyle? fieldNameStyle,
    final String? fieldPostRedirection,
    final TextStyle? fieldPostRedirectionStyle,
    final VoidCallback? postFieldOnClick,
    final TextStyle? textStyle,
    final Color? iconColor,
    final List<FileNameItem>? listNameFiles,
    final CustomFormFieldThemeData? theme,
    final List<File?>? defaultFileList,
    final Function(List<File?>?)? onMultipleChanged,
  }) = _MultipleFile;

  @override
  Widget build(BuildContext context) => Container();
}

class _OneImage extends Input {
  const _OneImage({
    final String? fieldName,
    final TextStyle? fieldNameStyle,
    final String? fieldPostRedirection,
    final TextStyle? fieldPostRedirectionStyle,
    final VoidCallback? postFieldOnClick,
    final double? height,
    final String? svgIconPath,
    final VoidCallback? onTap,
    final VoidCallback? onDoubleTap,
    final File? image,
    final BoxDecoration? boxDecoration,
    final double? inkRadius,
    final EdgeInsets? contentPadding,
    final double? imageRadius,
    final TextStyle? textStyle,
    final Color? iconColor,
    final double? widthImage,
    final CustomFormFieldThemeData? theme,
    final Function(File?)? onChanged,
    final File? defaultFile,
  }) : super(
          height: height,
          svgIconPath: svgIconPath,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          image: image,
          boxDecoration: boxDecoration,
          inkRadius: inkRadius,
          contentPadding: contentPadding,
          imageRadius: imageRadius,
          textStyle: textStyle,
          iconColor: iconColor,
          widthImage: widthImage,
          fieldName: fieldName,
          fieldNameStyle: fieldNameStyle,
          fieldPostRedirection: fieldPostRedirection,
          fieldPostRedirectionStyle: fieldPostRedirectionStyle,
          postFieldOnClick: postFieldOnClick,
          theme: theme,
          onChanged: onChanged,
          defaultFile: defaultFile,
        );
  @override
  Widget build(BuildContext context) {
    final themeData = loadThemeData(theme, "input_field", () => const CustomFormFieldThemeData())!;
    final state = useState<File?>(defaultFile);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            fieldName != null
                ? Text(
                    fieldName!,
                    style: fieldNameStyle ?? themeData.fieldNameStyle ?? const TextStyle(color: Color(0xFF02132B), fontSize: 12, fontWeight: FontWeight.w500),
                  )
                : Container(),
            fieldPostRedirection == null ? const SizedBox() : const Spacer(),
            fieldPostRedirection == null
                ? const SizedBox()
                : InkWell(
                    onTap: postFieldOnClick,
                    child: Text(
                      fieldPostRedirection!,
                      style: fieldPostRedirectionStyle ??
                          themeData.fieldPostRedirectionStyle ??
                          const TextStyle(
                            color: Color(0xFF02132B),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                    )),
          ],
        ),
        sh(7),
        Material(
            type: MaterialType.transparency,
            child: Container(
              height: formatHeight(height ?? themeData.pickerHeight ?? 108),
              constraints: themeData.pickerConstraints,
              decoration: boxDecoration ??
                  themeData.pickerDecoration ??
                  BoxDecoration(
                    color: themeData.backgroundColor ?? const Color(0xFF02132B).withOpacity(0.03),
                    borderRadius: BorderRadius.circular(themeData.selectRadius ?? 7),
                  ),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                    borderRadius: BorderRadius.circular(inkRadius ?? 7),
                    onTap: () {
                      if (onTap != null) onTap!(); //TODO picker for web and mobile
                      if (onChanged != null) onChanged!(state.value);
                    },
                    onDoubleTap: onDoubleTap,
                    child: Padding(
                      padding: state.value != null ? (contentPadding ?? themeData.contentPadding ?? const EdgeInsets.fromLTRB(7, 6, 30, 6)) : EdgeInsets.zero,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: state.value != null
                            ? [
                                Container(
                                  width: formatWidth(widthImage ?? themeData.pickerImageWidth ?? 81),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: FileImage(state.value!), fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(imageRadius ?? themeData.pickerImageRadius ?? 5),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      svgIconPath == null
                                          ? Icon(
                                              Icons.cloud_upload_outlined,
                                              color: iconColor ?? themeData.pickerIconColor ?? const Color(0xFF02132B).withOpacity(0.41),
                                            )
                                          : SvgPicture.asset(
                                              svgIconPath!,
                                              color: iconColor ?? themeData.pickerIconColor ?? const Color(0xFF02132B).withOpacity(0.41),
                                            ),
                                      const SizedBox(height: 7),
                                      SizedBox(
                                          width: 120,
                                          child: Text(
                                            'Appuyez pour modifier la photo',
                                            textAlign: TextAlign.right,
                                            style: textStyle ??
                                                themeData.hintStyle ??
                                                TextStyle(fontSize: sp(13), fontWeight: FontWeight.w500, color: const Color(0xFF02132B).withOpacity(0.41)),
                                          )),
                                    ],
                                  ),
                                ),
                              ]
                            : [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      svgIconPath == null
                                          ? Icon(
                                              Icons.cloud_upload_outlined,
                                              color: iconColor ?? themeData.pickerIconColor ?? const Color(0xFF02132B).withOpacity(0.41),
                                            )
                                          : SvgPicture.asset(
                                              svgIconPath!,
                                              color: iconColor ?? themeData.pickerIconColor ?? const Color(0xFF02132B).withOpacity(0.41),
                                            ),
                                      sh(7),
                                      Text(
                                        'Appuyez pour choisir une photo',
                                        style: textStyle ??
                                            themeData.hintStyle ??
                                            TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF02132B).withOpacity(0.41),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                      ),
                    )),
              ),
            )),
      ],
    );
  }
}

class _MultipleFile extends Input {
  const _MultipleFile({
    final String? svgIconPath,
    final VoidCallback? onTap,
    final VoidCallback? onDoubleTap,
    final BoxDecoration? boxDecoration,
    final double? inkRadius,
    final EdgeInsets? contentPadding,
    final TextStyle? textStyle,
    final Color? iconColor,
    final List<FileNameItem>? listNameFiles,
    final String? fieldName,
    final TextStyle? fieldNameStyle,
    final String? fieldPostRedirection,
    final TextStyle? fieldPostRedirectionStyle,
    final VoidCallback? postFieldOnClick,
    final CustomFormFieldThemeData? theme,
    final List<File?>? defaultFileList,
    final Function(List<File?>?)? onMultipleChanged,
  }) : super(
          svgIconPath: svgIconPath,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          boxDecoration: boxDecoration,
          inkRadius: inkRadius,
          contentPadding: contentPadding,
          textStyle: textStyle,
          iconColor: iconColor,
          listNameFiles: listNameFiles,
          fieldName: fieldName,
          fieldNameStyle: fieldNameStyle,
          fieldPostRedirection: fieldPostRedirection,
          fieldPostRedirectionStyle: fieldPostRedirectionStyle,
          postFieldOnClick: postFieldOnClick,
          theme: theme,
          defaultFileList: defaultFileList,
          onMultipleChanged: onMultipleChanged,
        );
  @override
  Widget build(BuildContext context) {
    final themeData = loadThemeData(theme, "input_field", () => const CustomFormFieldThemeData())!;
    final state = useState<List<File?>?>(defaultFileList);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            fieldName != null
                ? Text(
                    fieldName!,
                    style: fieldNameStyle ?? themeData.fieldNameStyle ?? const TextStyle(color: Color(0xFF02132B), fontSize: 12, fontWeight: FontWeight.w500),
                  )
                : Container(),
            fieldPostRedirection == null ? const SizedBox() : const Spacer(),
            fieldPostRedirection == null
                ? const SizedBox()
                : InkWell(
                    onTap: postFieldOnClick,
                    child: Text(
                      fieldPostRedirection!,
                      style: fieldPostRedirectionStyle ??
                          themeData.fieldPostRedirectionStyle ??
                          const TextStyle(
                            color: Color(0xFF02132B),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                    )),
          ],
        ),
        sh(7),
        Material(
            type: MaterialType.transparency,
            child: Container(
              constraints: themeData.pickerConstraints ?? const BoxConstraints(minHeight: 108),
              decoration: boxDecoration ?? themeData.pickerDecoration ?? BoxDecoration(color: const Color(0xFF02132B).withOpacity(0.03), borderRadius: BorderRadius.circular(7)),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                    borderRadius: BorderRadius.circular(inkRadius ?? 7),
                    onTap: () {
                      if (onTap != null) onTap!();
                      //TODO picker files
                      if (onMultipleChanged != null) onMultipleChanged!(state.value);
                    },
                    onDoubleTap: onDoubleTap,
                    child: Padding(
                      padding: contentPadding ?? themeData.contentPadding ?? const EdgeInsets.fromLTRB(26, 6, 26, 6),
                      child: Stack(
                        alignment: Alignment.center,
                        children: (state.value != null && state.value!.isNotEmpty)
                            ? [
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: state.value != null
                                        ? [
                                            ...state.value!.map((e) {
                                              return Row(
                                                children: [
                                                  FileNameItem(
                                                    fileName: e!.path.split("/").last,
                                                    onClear: () {
                                                      if (state.value == null) return;
                                                      if ((state.value?.length ?? 0) == 1) {
                                                        state.value = null;
                                                        return;
                                                      }
                                                      List<File?>? ret = [];
                                                      for (final t in state.value!) {
                                                        if (e != t) ret.add(t);
                                                      }
                                                      state.value = ret;
                                                    },
                                                  ),
                                                  sw(3),
                                                ],
                                              );
                                            }).toList(),
                                            SizedBox(
                                              width: 200,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    svgIconPath == null
                                                        ? Icon(
                                                            Icons.cloud_upload_outlined,
                                                            color: iconColor ?? themeData.pickerIconColor ?? const Color(0xFF02132B).withOpacity(0.41),
                                                          )
                                                        : SvgPicture.asset(
                                                            svgIconPath!,
                                                            color: iconColor ?? themeData.pickerIconColor ?? const Color(0xFF02132B).withOpacity(0.41),
                                                          ),
                                                    sh(7),
                                                    SizedBox(
                                                      width: 100,
                                                      child: Text(
                                                        'Appuyez pour modifier la / les fichier(s)',
                                                        textAlign: TextAlign.center,
                                                        style: textStyle ??
                                                            themeData.fieldStyle ??
                                                            TextStyle(fontSize: sp(13), fontWeight: FontWeight.w500, color: const Color(0xFF02132B).withOpacity(0.41)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ]
                                        : [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                svgIconPath == null
                                                    ? Icon(
                                                        Icons.cloud_upload_outlined,
                                                        color: iconColor ?? themeData.pickerIconColor ?? const Color(0xFF02132B).withOpacity(0.41),
                                                      )
                                                    : SvgPicture.asset(
                                                        svgIconPath!,
                                                        color: iconColor ?? themeData.pickerIconColor ?? const Color(0xFF02132B).withOpacity(0.41),
                                                      ),
                                                sw(7),
                                                Text(
                                                  'Appuyez pour choisir une / des fichier(s)',
                                                  style: textStyle ??
                                                      themeData.fieldStyle ??
                                                      TextStyle(
                                                        fontSize: sp(13),
                                                        fontWeight: FontWeight.w500,
                                                        color: const Color(0xFF02132B).withOpacity(0.41),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                  ),
                                ),
                              ]
                            : [
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      svgIconPath == null
                                          ? Icon(
                                              Icons.cloud_upload_outlined,
                                              color: iconColor ?? themeData.pickerIconColor ?? const Color(0xFF02132B).withOpacity(0.41),
                                            )
                                          : SvgPicture.asset(
                                              svgIconPath!,
                                              color: iconColor ?? themeData.pickerIconColor ?? const Color(0xFF02132B).withOpacity(0.41),
                                            ),
                                      sh(7),
                                      Text(
                                        'Appuyez pour choisir un fichier',
                                        style: textStyle ??
                                            themeData.hintStyle ??
                                            TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF02132B).withOpacity(0.41),
                                            ),
                                        // textAlign: TextAlign.,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                      ),
                    )),
              ),
            )),
      ],
    );
  }
}

class FileNameItem extends StatelessWidget {
  final String fileName;
  final VoidCallback onClear;
  const FileNameItem({
    required this.fileName,
    required this.onClear,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: const Color(0xFF02132B).withOpacity(0.41), indent: 0, endIndent: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              fileName,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF02132B),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: onClear,
              splashRadius: 24,
            )
          ],
        ),
      ],
    );
  }
}
