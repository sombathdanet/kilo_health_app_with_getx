import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/component/xgrid_view.dart';
import 'package:project/component/xslider.dart';
import 'package:project/core/base/base_builder.dart';
import 'package:project/core/view/padding.dart';
import 'package:project/route.dart';
import 'package:project/feature/home/presentation/home/home_controller.dart';
import 'package:project/feature/home/presentation/home/home_state.dart';
import 'package:project/theme/text_style/text_style.dart';
import 'package:project/theme/theme_controller.dart';
import 'package:project/utils/constant/image_constant.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../../component/xtapbar.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: XPadding.extraLarge),
      child: BaseBuilder<HomeController>(
        builder: (controller) => Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              titleSpacing: 0,
              title: Row(
                children: [
                  Image.asset(
                    ImageConstant.logo_app,
                    height: 30,
                    width: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  XTextExtraLarge(
                    padding: const EdgeInsets.only(left: XPadding.medium),
                    text: "Kilo Health",
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              actions: [
                GestureDetector(
                  onTap: () => Get.find<ThemeController>().chnageTheme(),
                  child: Icon(
                    Icons.dark_mode,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: XPadding.medium,
                ),
                GestureDetector(
                  onTap: () => AppRoutes.gotoSearchRoute(),
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                )
              ],
            ),
            body: _buildPinHeader(
              homeProvider: controller,
              context: context,
              state: controller.uiState,
            )),
      ),
    );
  }

  // Widget _buildBody({
  Widget _buildSlider({
    required HomeController homeProvider,
    required BuildContext context,
    required HomeState state,
  }) {
    final pagecontroller = PageController();
    return XSlider(
      pageController: pagecontroller,
      currentIndex: state.currentPageIndex,
      sliderItems: state.sliderItem.slides,
      onPageChanged: (index) {
        homeProvider.changePage(index);
      },
    );
  }

  Widget _buildGridView({
    required HomeController homeProvider,
    required BuildContext context,
    required HomeState state,
  }) {
    return XGridView(
      listItem: state.homeGridItem,
      cardColor: Theme.of(context).cardColor,
      onTapItem: (index) {
        AppRoutes.gotoDetailRoute(id: state.homeGridItem[index].id);
      },
    );
  }

  Widget _buildPinHeader({
    required HomeController homeProvider,
    required BuildContext context,
    required HomeState state,
  }) {
    return CustomScrollView(
      controller: controller.scrollController,
      slivers: [
        SliverFixedExtentList(
          delegate: SliverChildListDelegate([
            //Restaurant
            _buildSlider(
              homeProvider: homeProvider,
              context: context,
              state: state,
            ),
          ]),
          itemExtent: 160.0,
        ),
        SliverToBoxAdapter(
          child: XTextLarge(
            padding: const EdgeInsets.symmetric(vertical: XPadding.medium),
            text: "All Category",
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        MultiSliver(
            pushPinnedChildren: true, //if u have multiple sticky headers
            children: [
              //categories sticky header from sliver_tools package
              SliverPinnedHeader(
                child: Container(
                  margin:
                      const EdgeInsetsDirectional.only(bottom: XPadding.medium),
                  padding: state.offset >= 200
                      ? const EdgeInsets.symmetric(vertical: XPadding.medium)
                      : EdgeInsets.zero,
                  color: state.offset >= 200
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Colors.transparent,
                  child: XTabBar(
                    tabItems: tabItems,
                    currentIndex: state.currentIndex,
                    onChangeIndex: (index) {
                      homeProvider.changeTap(index);
                    },
                  ),
                ),
              ),
              _buildGridView(
                context: context,
                homeProvider: homeProvider,
                state: state,
              ),
            ])
      ],
    );
  }
}
