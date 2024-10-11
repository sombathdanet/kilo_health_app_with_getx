import 'package:get/get.dart';
import 'package:project/core/network/network_info.dart';
import 'package:project/feature/home/data/local/home_local_source.dart';
import 'package:project/feature/home/data/network/home_network_data_source.dart';
import 'package:project/feature/home/data/repository/home_repository_impl.dart';
import 'package:project/feature/home/domain/home_resposiory.dart';
import 'package:project/feature/home/presentation/detail/health_detial_controller.dart';

class HealthDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(
        Get.find<HomeNetworkDataSource>(),
        Get.find<HomeLocalDataSource>(),
        Get.find<NetWorkInfo>(),
      ),
    );
    Get.lazyPut<HealthDetailController>(
      () => HealthDetailController(
        Get.find<HomeRepository>(),
      ),
    );
  }
}
