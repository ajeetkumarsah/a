import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wtf_web/controller/menu_controller.dart';
import 'package:wtf_web/new/responsive.dart';
import 'web_menu.dart';

class Header extends StatelessWidget {
  final MenuController _controller = Get.put(MenuController());
  final bool scroll;
  Header({Key? key, required this.scroll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: scroll ? Colors.black : Colors.transparent,
      child: SafeArea(
          child: Container(
        padding: EdgeInsets.only(
            left: Responsive.isDesktop(context) ? 88 : 12.0,
            right: 88,
            top: scroll ? 20 : 50,
            bottom: scroll ? 20 : 50),
        child: Row(
          children: [
            if (!Responsive.isDesktop(context))
              IconButton(
                icon: _controller.scaffoldkey.currentState!.isDrawerOpen
                    ? Image.asset('assets/home/more.png')
                    : Image.asset('assets/home/menu.png'),
                onPressed: () {
                  _controller.openOrCloseDrawer();
                },
              ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                'assets/logo.png',
                width: 90,
                fit: BoxFit.fitWidth,
              ),
            ),
            const Spacer(),
            if (Responsive.isDesktop(context)) WebMenu(),
          ],
        ),
      )),
    );
  }
}
