import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wtf_web/controller/menu_controller.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/home/home_screen.dart';
import 'package:wtf_web/screens/widgets/animated_pointer.dart';
import 'package:wtf_web/utils/const.dart';
import 'web_menu.dart';

class Header extends StatefulWidget {
  final MenuController _controller = Get.put(MenuController());

  final bool scroll, isLoggedIn;
  Header({Key? key, required this.scroll, required this.isLoggedIn})
      : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: widget.scroll ? Colors.black : Colors.transparent,
      child: SafeArea(
          child: Container(
        padding: EdgeInsets.only(
            left: Responsive.isDesktop(context) ? 88 : 12.0,
            right: 88,
            top: widget.scroll ? 20 : 50,
            bottom: widget.scroll ? 20 : 50),
        child: Row(
          children: [
            if (!Responsive.isDesktop(context))
              IconButton(
                icon: widget._controller.scaffoldkey.currentState!.isDrawerOpen
                    ? Image.asset('assets/home/more.png')
                    : Image.asset('assets/home/menu.png'),
                onPressed: () {
                  widget._controller.openOrCloseDrawer();
                },
              ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/logo.png',
                  width: 90,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const Spacer(),
            if (Responsive.isDesktop(context))
              WebMenu(isLoggedIn: widget.isLoggedIn),
          ],
        ),
      )),
    );
  }
}
