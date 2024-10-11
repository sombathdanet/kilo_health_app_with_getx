import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/component/button/xicon_button.dart';
import 'package:project/component/ximage_provider.dart';
import 'package:project/component/xlist_veritical.dart';
import 'package:project/core/base/base_builder.dart';
import 'package:project/core/view/padding.dart';
import 'package:project/feature/search_screen/submit_screen/onsubmit_screen.dart';
import 'package:project/feature/search_screen/component/search_textfield.dart';
import 'package:project/feature/search_screen/component/tab_bar_search_screen.dart';
import 'package:project/feature/search_screen/search_screen_controller.dart';
import 'package:project/theme/text_style/text_style.dart';
import 'package:project/utils/constant/image_constant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = Get.find<SearchScreenController>();
  @override
  void initState() {
    super.initState();
    controller.search(
      query: null,
    );
    controller.getCateogryItem();
    controller.listenPaging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
      ),
      body: BaseBuilder<SearchScreenController>(
        builder: (controller) => controller.uiState.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _buildBody(controller: controller),
      ),
    );
  }

  Widget _buildBody({
    required SearchScreenController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: XPadding.extraLarge),
      child: Column(
        children: [
          SearchTextField(
            textEditingController: controller.textEditingController,
            color: Theme.of(context).cardColor,
            suffixIcon: const XIconButton(iconData: Icons.mic),
            onSubMit: (value) {
              controller.search(query: value);
              if (value.isNotEmpty) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SubmitSearchScreen(
                      qurey: value,
                    ),
                  ),
                );
              }
            },
          ),
          Expanded(
            child: XSearchTabBar(
              categoryItem: controller.uiState.categoryItem,
              currentIndex: controller.uiState.currentIndex,
              color: Theme.of(context).colorScheme.primaryContainer,
              onChangeIndex: (index) {
                controller.changeTap(index);
              },
              content: Padding(
                padding: const EdgeInsets.only(top: XPadding.large),
                child: _buildList(controller: controller),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList({required SearchScreenController controller}) {
    if (controller.uiState.searchItemUi.isEmpty) {
      return _buildEmptySearch();
    }
    return XListVeritical(
      scrollController: controller.scrollController,
      items: controller.uiState.searchItemUi,
      margin: const EdgeInsets.only(bottom: XPadding.large),
      content: (context, it, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  XTextMedium(
                    text: it.title,
                    overflow: null,
                    maxLine: 2,
                  ),
                  const SizedBox(
                    height: XPadding.large,
                  ),
                  XTextMedium(
                    text: it.subtitle,
                    overflow: null,
                    fontWeight: FontWeight.w400,
                    maxLine: 2,
                  )
                ],
              ),
            ),
            Container(
              height: 80,
              width: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(it.thumnail),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildEmptySearch() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: XImageProvider(
        height: height / 2,
        width: width / 2,
        path: ImageConstant.no_search_found,
        fit: BoxFit.contain,
      ),
    );
  }
}
