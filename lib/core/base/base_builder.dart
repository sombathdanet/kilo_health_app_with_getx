import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseBuilder<T extends GetxController> extends StatelessWidget {
  final Widget Function(T) builder;
  const BaseBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      builder: (controller) => builder(
        controller,
      ),
    );
  }
}
