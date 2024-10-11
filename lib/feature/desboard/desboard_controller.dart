import 'package:flutter/material.dart';
import 'package:project/core/base/base_controller.dart';
import 'package:project/feature/desboard/desboard_state.dart';

class DesBoardController extends BaseProvider<DesboardState> {
  final pageController = PageController();

  @override
  DesboardState onInitUiState() => DesboardState();

  void navigator(int index) {
    setState((state) {
      state.currentindex = index;
    });
    pageController.jumpToPage(uiState.currentindex);
  }
}
