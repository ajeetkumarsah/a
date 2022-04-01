import 'package:flutter/material.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';

class ProductDetailsPage extends StatelessWidget {
  static String routeName = "productDetailsPage";
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Product Details'),
      body: Container(),
    );
  }
}
