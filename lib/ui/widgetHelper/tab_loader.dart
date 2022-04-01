import 'package:flutter/material.dart';

class TabLoader extends StatelessWidget {
  const TabLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(strokeWidth: 1));
  }
}
