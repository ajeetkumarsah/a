import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/controller/menu_controller.dart';
import 'package:wtf_web/controller/view_controller.dart';
import 'package:wtf_web/session_manager/global_data.dart';
import 'package:wtf_web/session_manager/session_manager.dart';
import 'package:wtf_web/utils/const.dart';

class WebMenu extends StatelessWidget {
  final bool isLoggedIn;
  final MenuController _controller = Get.put(MenuController());

  WebMenu({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(
          _controller.menuItems.length,
          (index) => WebMenuItem(
            isLoggedIn: isLoggedIn,
            isLast: index == (_controller.menuItems.length - 1),
            text: _controller.menuItems[index],
            isActive: index == _controller.selectedIndex,
            press: () {
              viewController.setBaseListStream(index);
              _controller.setMenuIndex(index);
            },
          ),
        ),
      ),
    );
  }
}

class WebMenuItem extends StatefulWidget {
  const WebMenuItem({
    Key? key,
    required this.isActive,
    required this.text,
    required this.press,
    required this.isLast,
    required this.isLoggedIn,
  }) : super(key: key);

  final bool isActive;
  final String text;
  final VoidCallback press;
  final bool isLast;
  final bool isLoggedIn;
  @override
  _WebMenuItemState createState() => _WebMenuItemState();
}

class _WebMenuItemState extends State<WebMenuItem> {
  bool _isHover = false;

  Color _borderColor() {
    if (widget.isActive) {
      return Constants.primaryColor;
    }

    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      onHover: (value) {
        setState(() {
          _isHover = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(microseconds: 250),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: widget.isLoggedIn == true && widget.isLast ? 42 : null,
        width: widget.isLoggedIn == true && widget.isLast ? 42 : null,
        padding: widget.isLast
            ? EdgeInsets.symmetric(horizontal: 12.0, vertical: 4)
            : const EdgeInsets.symmetric(vertical: 20 / 2),
        decoration: widget.isLast
            ? widget.isLoggedIn == true
                ? BoxDecoration(
                    color: Constants.white,
                    borderRadius: BorderRadius.circular(90),
                    image: DecorationImage(
                      image: globalData.userProfile?.profile != null
                          ? AssetImage('assets/profile/woman.png')
                          : AssetImage('assets/profile/man.png'),
                    ),
                  )
                : BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Color(0xff9A0E0E),
                        Color(0xffDE0000),
                      ],
                    ),
                  )
            : BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: _borderColor(), width: 3),
                ),
              ),
        child: widget.isLoggedIn == true && widget.isLast
            ? SizedBox()
            : Text(
                widget.text,
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w300,
                  color: widget.isActive || _isHover
                      ? Constants.white
                      : Colors.white.withOpacity(0.5),
                  fontSize: 18,
                ),
              ),
      ),
    );
  }
}
