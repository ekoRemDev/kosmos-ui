import 'dart:io';

import 'package:core_kosmos/core_package.dart';
import 'package:example/imagePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ui_kosmos_v4/cta/theme.dart';
import 'package:ui_kosmos_v4/ui_kosmos_v4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            builder: (_, child) {
              return ResponsiveWrapper.builder(
                BouncingScrollWrapper(child: child!),
                maxWidth: double.infinity,
                minWidth: 480,
                breakpoints: const [
                  ResponsiveBreakpoint.tag(800, name: PHONE),
                  ResponsiveBreakpoint.tag(1100, name: TABLET),
                  ResponsiveBreakpoint.tag(2400, name: DESKTOP),
                  ResponsiveBreakpoint.tag(double.infinity, name: "4K"),
                ],
              );
            },
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PlatformFile>? items;
  double value = 0;

  PlatformFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sh(80),
              CTA.back(
                theme: CtaThemeData(backgroundColor: Colors.transparent),
              ),
              sh(80),
              Header.secondary(),
              sh(80),
              SettingsCellule(
                onClick: () {},
                icon: Icons.facebook,
                iconColor: Colors.white,
                activeIconColor: Colors.blue,
              ),  
              const SizedBox(height: 400),
              Input.image(
                image: image,
                onTap: () async {
                  FilePickerResult? res = await FilePicker.platform.pickFiles();
                  setState(() {
                    image = res?.files[0];
                    print(image.toString());
                  });
                  // getImage(
                  //     context: context,
                  //     onImageSelected: ((_) {
                  //       setState(() {
                  //         image = _;
                  //       });
                  //     }));
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SelectForm<String>(
                  items: [
                    DropdownMenuItem(
                      value: 'Value1',
                      child: Text(
                        'Value1',
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Value2',
                      child: Text(
                        'Value2',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 400),
              const Cards.five(),
              const SizedBox(height: 400),
              const Input.image(),
              const SizedBox(height: 400),
              CTA.primary(
                textButton: 'Primary CTA',
                onTap: () async {
                  await Future.delayed(const Duration(seconds: 5));
                },
              ),
              sh(80),
              CustomSlider.slider(
                min: 0,
                max: 100,
                customSliderThumbShape: CustomSliderThumbShape(
                    elevation: 0, pressedElevation: 0, stringNumber: "${(value).toInt()} km", ajustString: 2.2),
                onChanged: (_) {
                  setState(() {
                    value = _;
                  });
                },
              ),
              sh(80),
              SizedBox(
                width: 284,
                child: Input.validatedFile(
                  height: 200,
                  fieldName: "Test",
                  desc: "Format PDF",
                  defaultFiles: items,
                ),
              ),
              sh(80),
              SizedBox(
                height: 100,
                width: 800,
                child: ProgressBar.separated(
                    max: 5, current: 2, items: const ["1", "2", "3", "4", "5"], showPercentage: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
