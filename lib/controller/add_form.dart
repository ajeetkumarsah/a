// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:salessimplify/constants/fieldinputtype.dart';
// import 'package:salessimplify/models/addformfields.dart';
// import 'package:salessimplify/repository/Repository.dart';

// class AddFormContriller extends GetxController {
//   List<AddFormFields> list = [].obs as List<AddFormFields>;
//   Map<String, TextEditingController> controllers =
//       {}.obs as Map<String, TextEditingController>;
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   fetchAlbum() async {
//     final snapshot = await Repository.getInstance().getAddFormField('');
//     if (snapshot.connectionState == ConnectionState.done) {
//       list = snapshot.data;
//       list.forEach((field) {
//         if (field.fieldInputType == FieldInputType.INPUT.getType()) {
//           controllers.putIfAbsent(
//               field.apiKeyName, () => TextEditingController());
//         }
//         if (field.fieldInputType ==
//                 FieldInputType.MULTI_PHONE_INPUT.getType() ||
//             field.fieldInputType ==
//                 FieldInputType.MULTI_EMAIL_INPUT.getType()) {
//           controllers.putIfAbsent(
//               field.fieldInputType, () => TextEditingController());
//         }
//       });
//     }
//   }
// }
