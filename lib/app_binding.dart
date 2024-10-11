import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project/core/local/local_mananger.dart';
import 'package:project/core/network/network_info.dart';
import 'package:project/core/network/networkdata_source.dart';
import 'package:project/feature/desboard/desboard_controller.dart';
import 'package:project/theme/theme_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Core dependencies
    Get.put(ThemeController());
    Get.lazyPut<NetWorkDataSource>(() => NetWorkDataSource.instance);
    Get.lazyPut<LocalStorageManageer>(() => LocalStorageManageer.instance);
    Get.lazyPut<NetWorkInfo>(
      () => NetWrokInfoImpl(
        InternetConnectionChecker(),
      ),
    );
    
    Get.lazyPut<DesBoardController>(() => DesBoardController());
  }
}
