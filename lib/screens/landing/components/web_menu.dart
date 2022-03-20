import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/controller/menu_controller.dart';
import 'package:wtf_web/controller/view_controller.dart';
import 'package:wtf_web/utils/const.dart';

class WebMenu extends StatelessWidget {
  final MenuController _controller = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(
          _controller.menuItems.length,
          (index) => WebMenuItem(
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
  }) : super(key: key);

  final bool isActive;
  final String text;
  final VoidCallback press;

  @override
  _WebMenuItemState createState() => _WebMenuItemState();
}

class _WebMenuItemState extends State<WebMenuItem> {
  bool _isHover = false;

  Color _borderColor() {
    if (widget.isActive) {
      return Constants.primaryColor;
    }
    // } else if (!widget.isActive & _isHover) {
    //   return Constants.primaryColor.withOpacity(0.4);
    // }
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
        padding: const EdgeInsets.symmetric(vertical: 20 / 2),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: _borderColor(), width: 3),
          ),
        ),
        child: Text(
          widget.text,
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.w300,
              color: widget.isActive || _isHover
                  ? Constants.white
                  : Colors.white.withOpacity(0.5),
              fontSize: 18),
        ),
      ),
    );
  }
}
