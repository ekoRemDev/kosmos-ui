import 'dart:typed_data';

import 'package:core_kosmos/core_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ui_kosmos_v4/cta/cta.dart';
import 'package:ui_kosmos_v4/form/input.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ui_kosmos_v4/micro_element/micro_element.dart';

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
              Input.image(),
              const SizedBox(height: 400),
              CTA.primary(
                textButton: 'Primary CTA',
                onTap: () async {
                  await Future.delayed(const Duration(seconds: 5));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
