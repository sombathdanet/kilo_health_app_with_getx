import 'package:flutter/foundation.dart';
import 'package:project/core/base/base_controller.dart';
import 'package:project/core/network/error_handler.dart';
import 'package:project/data/model.dart';
import 'package:project/feature/search_screen/domain/model/searh_model.dart';
import 'package:project/feature/search_screen/domain/usecase/search_usecase.dart';
import 'package:project/feature/search_screen/submit_screen/submit_screen_state.dart';

class SubmitScreenController extends BaseProvider<SubmitScreenState> {
  final SearchUseCase _searchUseCase;
  SubmitScreenController(this._searchUseCase);
  @override
  SubmitScreenState onInitUiState() => SubmitScreenState();

  void search({
    String? query,
    int? page,
  }) async {
    try {
      setState((e) {
        e.searchLoading = true;
      });
      final res = await _searchUseCase.call(
        param: QueryModel(
          query: query,
          page: page,
        ),
      );
      setState((e) {
        e.searchItemUi = res.toSearchItem();
      });
    } on ErrorHandler catch (e) {
      if (kDebugMode) {
        print(e.failure.message);
      }
    } finally {
      setState((e) {
        e.searchLoading = false;
      });
    }
  }
}

extension SearchUIItemMapper on List<SerachModelUI> {
  List<SearchModel> toSearchItem() {
    return map((e) => e.toSearch()).toList();
  }
}

extension SearchUIMapper on SerachModelUI {
  SearchModel toSearch() {
    return SearchModel(
      id: id,
      title: name,
      subtitle: description,
      thumnail: thumbnail,
    );
  }
}
