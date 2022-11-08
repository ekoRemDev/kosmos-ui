// ignore_for_file: unnecessary_import

import 'package:core_kosmos/core_package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:file_picker/file_picker.dart';
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
              sh(40),
              const TextFormUpdated.classic(
                textInputAction: TextInputAction.newline,
                maxLine: 5,
              ),
              const Cards.six(
                boxShadow: false,
                threeDots: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
