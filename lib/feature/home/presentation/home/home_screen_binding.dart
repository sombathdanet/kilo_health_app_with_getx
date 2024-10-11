import 'package:get/get.dart';
import 'package:project/core/network/network_info.dart';
import 'package:project/feature/home/data/local/home_local_source.dart';
import 'package:project/feature/home/data/repository/home_repository_impl.dart';
import 'package:project/feature/home/domain/home_resposiory.dart';
import 'package:project/feature/home/domain/usecase/get_home_grid_usecase.dart';
import 'package:project/feature/home/presentation/home/home_controller.dart';
import '../../data/network/home_network_data_source.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeNetworkDataSource>(
      () => HomeNetworkDataSource(),
    );
    Get.lazyPut<HomeLocalDataSource>(
      () => HomeLocalDataSource(),
    );
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(
        Get.find<HomeNetworkDataSource>(),
        Get.find<HomeLocalDataSource>(),
        Get.find<NetWorkInfo>(),
      ),
    );
    Get.lazyPut<GetHomeGridUseCase>(
      () => GetHomeGridUseCase(
        Get.find<HomeRepository>(),
        Get.find<NetWorkInfo>(),
      ),
    );
    Get.put<HomeController>(
      HomeController(
        Get.find<HomeRepository>(),
        Get.find<GetHomeGridUseCase>(),
      ),
    );
  }
}
