import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ui_kosmos_v4/cta/cta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CTA.primary(
              textButton: 'Primary CTA',
              onTap: () async {
                await Future.delayed(const Duration(seconds: 5));
              },
            )
          ],
        ),
      ),
    );
  }
}
