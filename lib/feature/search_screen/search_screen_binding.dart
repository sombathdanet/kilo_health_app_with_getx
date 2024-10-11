import 'package:get/get.dart';
import 'package:project/feature/search_screen/data/network/search_network_data_source.dart';
import 'package:project/feature/search_screen/data/repository/search_repository_impl.dart';
import 'package:project/feature/search_screen/domain/repository/search_repository.dart';
import 'package:project/feature/search_screen/domain/usecase/get_category_usecase.dart';
import 'package:project/feature/search_screen/domain/usecase/search_usecase.dart';
import 'package:project/feature/search_screen/search_screen_controller.dart';

class SearchScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchNetWorkDataSource>(
      () => SearchNetWorkDataSource(),
    );
    Get.lazyPut<SearchReposiory>(
      () => SearchRepositoryImpl(
        Get.find<SearchNetWorkDataSource>(),
      ),
    );
    Get.lazyPut<SearchUseCase>(
      () => SearchUseCase(
        Get.find<SearchReposiory>(),
      ),
    );
    Get.lazyPut<GetCategoryUsecase>(
      () => GetCategoryUsecase(
        Get.find<SearchReposiory>(),
      ),
    );
    Get.lazyPut<SearchScreenController>(
      () => SearchScreenController(
        Get.find<SearchUseCase>(),
        Get.find<GetCategoryUsecase>(),
      ),
    );
  }
}
