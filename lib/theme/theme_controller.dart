import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/local/local_mananger.dart';
import 'package:project/theme/theme_color.dart';

class ThemeController extends GetxController {
  
  late ThemeData _themeMode;

  final ThemeData _darkTheme = AppTheme.darkTheme;

  final ThemeData _lightTheme = AppTheme.lightTheme;

  ThemeData get themeMode => _themeMode;

  late bool _isDarkTheme = false;

  @override
  void onInit() {
    _loadTheme();
    super.onInit();
  }

  bool get isDartkThem => _isDarkTheme;

  void _loadTheme() async {
    _isDarkTheme = await LocalStorageManageer.instance.getbool("ThemeKey");
    _themeMode = _isDarkTheme ? _darkTheme : _lightTheme;
    Get.changeTheme(_themeMode);
  }

  void chnageTheme() {
    _isDarkTheme = !_isDarkTheme;
    LocalStorageManageer.instance.setBool("ThemeKey", _isDarkTheme);
    _themeMode = _isDarkTheme ? _darkTheme : _lightTheme;
    Get.changeTheme(_themeMode);
  }
}
