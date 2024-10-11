import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:project/component/appbar/xapp_bar.dart';
import 'package:project/component/xslider.dart';
import 'package:project/core/base/base_builder.dart';
import 'package:project/core/view/padding.dart';
import 'package:project/feature/home/presentation/detail/health_detial_controller.dart';
import 'package:project/theme/text_style/text_style.dart';
import 'package:project/theme/text_style/xfont_size.dart';

class HeathDetail extends StatefulWidget {
  final String? id;
  const HeathDetail({super.key, this.id});

  @override
  State<HeathDetail> createState() => _HeathDetailState();
}

class _HeathDetailState extends State<HeathDetail> {
  final controller = Get.find<HealthDetailController>();
  @override
  void initState() {
    super.initState();
    controller.getGridDetail(Get.arguments['id'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XNavAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        titleColor: Colors.white,
        title: "Health Detail Screen",
        onPressed: () => Navigator.of(context).pop(),
        isNavBack: true,
      ),
      body: BaseBuilder<HealthDetailController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: XPadding.extraLarge),
          child: _buildLoad(context),
        ),
      ),
    );
  }

  Widget _buildLoad(context) {
    final controller = Get.find<HealthDetailController>();
    if (controller.uiState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    final controller = Get.find<HealthDetailController>();
    final pagecontroller = PageController();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: XPadding.large,
          ),
          XSlider(
            pageController: pagecontroller,
            sliderItems: [controller.uiState.homeGridDetialModel.thumbnail],
          ),
          const SizedBox(
            height: XPadding.medium,
          ),
          XTextLarge(
            text: controller.uiState.homeGridDetialModel.name,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(
            height: XPadding.medium,
          ),
          XTextSmall(
            text: controller.uiState.homeGridDetialModel.description,
            color: Theme.of(context).colorScheme.secondary,
            overflow: null,
          ),
          Html(
            data: controller.uiState.homeGridDetialModel.content,
            style: {
              "head": Style(
                fontSize: FontSize(XFontSize.large),
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
                color: Theme.of(context).colorScheme.secondary,
              ),
              "body": Style(
                fontSize: FontSize(XFontSize.medium),
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
                color: Theme.of(context).colorScheme.secondary,
              )
            },
          ),
        ],
      ),
    );
  }
}
