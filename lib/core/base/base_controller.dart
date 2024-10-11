import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

abstract class BaseProvider<UiState> extends GetxController {
  @protected
  UiState onInitUiState();

  late UiState _uiState;

  BaseProvider() {
    _uiState = onInitUiState();
  }

  UiState get uiState => _uiState;

  void _updateState(UiState newState) {
    _uiState = newState;
    update();
  }

  void setState(void Function(UiState) reducer) {
    reducer(_uiState);
    _updateState(_uiState);
  }
}
