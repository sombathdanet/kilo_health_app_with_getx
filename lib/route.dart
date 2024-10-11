import 'package:get/get.dart';
import 'package:project/feature/desboard/desboard_screen.dart';
import 'package:project/feature/home/presentation/detail/health_detail.dart';
import 'package:project/feature/home/presentation/detail/health_detail_binding.dart';
import 'package:project/feature/home/presentation/home/home_screen_binding.dart';
import 'package:project/feature/message/message_detail_screen/message_detail.dart';
import 'package:project/feature/search_screen/search_screen.dart';
import 'package:project/feature/search_screen/search_screen_binding.dart';
import 'package:project/feature/search_screen/submit_screen/onsubmit_screen.dart';

class AppRoutes {
  static const String desboard = '/';
  static const String healthDetail = '/healthDetail';
  static const String searchScreen = "/searchScreen";
  static const String messageDetailScreen = "/MessageDetailScreen";
  static const String seachPopScreen = "/seachPopScreen";

  static void gotoDesBoard() => Get.toNamed(desboard);

  static void gotoOffAllDessBord() => Get.offAll(desboard);

  static void gotoDetailRoute({int? id}) => Get.toNamed(
        arguments: {"id": id},
        healthDetail,
      );

  static void gotoSearchRoute() => Get.toNamed(searchScreen);

  static void gotoSearchPopScreen() => Get.toNamed(seachPopScreen);

  static void gotoMessageDetailScreen() => Get.toNamed(messageDetailScreen);
}

final getPage = [
  GetPage(
    name: AppRoutes.desboard,
    page: () => const DesBoardScreen(),
    binding: HomeScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.searchScreen,
    page: () => const SearchScreen(),
    binding: SearchScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.healthDetail,
    page: () => const HeathDetail(),
    binding: HealthDetailBinding(),
  ),
  GetPage(
    name: AppRoutes.seachPopScreen,
    page: () => const SubmitSearchScreen(),
  ),
  GetPage(
    name: AppRoutes.messageDetailScreen,
    page: () => const MessageDetailScreen(),
  )
];

// class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case AppRoutes.seachPopScreen:
//         final args = settings.arguments as String?;
//         return MaterialPageRoute(
//           builder: (_) => SubmitSearchScreen(
//             qurey: args,
//           ),
//         );
//       case AppRoutes.desboard:
//         return MaterialPageRoute(
//           builder: (_) => const DesBoardScreen(),
//         );
//       case AppRoutes.healthDetail:
//         final args = settings.arguments as String?;
//         return MaterialPageRoute(
//           builder: (_) => HeathDetail(
//             id: args,
//           ),
//         );
//       case AppRoutes.searchScreen:
//         return MaterialPageRoute(
//           builder: (_) => const SearchScreen(),
//         );
//       case AppRoutes.messageDetailScreen:
//         return MaterialPageRoute(
//           builder: (_) => const MessageDetailScreen(),
//         );

//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child: Text('No route defined for ${settings.name}'),
//             ),
//           ),
//         );
//     }
//   }
// }
