import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project/app_binding.dart';
import 'package:project/route.dart';
import 'package:project/theme/theme_color.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kilo Health',
      initialRoute: AppRoutes.desboard,
      initialBinding: AppBindings(),
      getPages: getPage,
      theme: AppTheme.lightTheme,
      builder: FToastBuilder(),
    );
  }
}
