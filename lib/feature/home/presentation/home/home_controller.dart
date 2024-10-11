import 'package:flutter/material.dart';
import 'package:project/core/base/base_controller.dart';
import 'package:project/core/network/error_handler.dart';
import 'package:project/feature/home/domain/home_resposiory.dart';
import 'package:project/feature/home/domain/usecase/get_home_grid_usecase.dart';
import 'package:project/feature/home/presentation/home/home_state.dart';

class HomeController extends BaseProvider<HomeState> {
  final HomeRepository _homeRepository;
  final GetHomeGridUseCase _getHomeGridUseCase;
  @override
  onInitUiState() => HomeState();

  HomeController(
    this._homeRepository,
    this._getHomeGridUseCase,
  );
  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    getHomeSlider();
    getHomeGridData();
    scrollController.addListener(() {
      setOffSet(scrollController.offset);
    });
    listenPaging(scrollController);
    super.onInit();
  }

  void changeTap(int index) {
    setState((state) {
      state.currentIndex = index;
    });
  }

  void changePage(int index) {
    setState((state) {
      state.currentPageIndex = index;
    });
  }

  void getHomeGridData({bool loadMore = false}) async {
    try {
      final res = await _getHomeGridUseCase.call(loadMore: loadMore);

      if (loadMore) {
        setState((state) {
          state.homeGridItem = state.homeGridItem + res;
        });
      }
      if (!loadMore) {
        setState((state) {
          state.homeGridItem = res;
        });
      }
    } on ErrorHandler catch (e) {
      throw Exception(e.failure.message);
    }
  }


  void getHomeSlider() async {
    try {
      final res = await _homeRepository.getHomeSlider();
      setState((state) {
        state.sliderItem = res;
      });
    } on ErrorHandler catch (e) {
      throw Exception(e.failure.message);
    }
  }

  void setOffSet(double offset) {
    setState((state) {
      state.offset = offset;
    });
  }

  void listenPaging(ScrollController scrollController) {
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent.toInt();
      final currentScroll = scrollController.position.pixels.toInt();

      if (currentScroll == maxScroll) {
        setState((e) => e.isFetchingData = true);
        getHomeGridData(loadMore: uiState.isFetchingData);
      }
    });
  }
}
