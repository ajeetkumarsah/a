// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:salessimplify/models/Profile.dart';
// import 'package:salessimplify/repository/Repository.dart';

// class SettingsController extends GetxController {
//   Rx<Profile>? data;
//   RxInt log2 = 0.obs;

//   void change() => log2.value++;
//   @override
//   void onInit() {
//     super.onInit();
//     fetchAlbum();
//   }

//   fetchAlbum() async {
//     var dataResponse = await Repository.getInstance().curentUserProfile();
//     if (dataResponse.hasData) {
//       data = dataResponse;
//     }
//   }
// }
