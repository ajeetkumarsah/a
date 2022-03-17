import 'package:flutter/material.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';

class TopBarContents extends StatefulWidget {
  const TopBarContents();

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 88, right: 88, top: 44, bottom: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                'assets/logo.png',
                width: 60,
                fit: BoxFit.fitWidth,
              ),
            ),
            const Spacer(),
            page(label: 'Fitness'),
            page(label: 'Nutrition'),
            page(label: 'Live Class'),
            page(label: 'Become WTF Partner'),
            page(label: 'Login'),
          ],
        ),
      ),
    );
  }

  Widget page({required String label}) {
    return Container(
        padding: const EdgeInsets.only(left: 30),
        child: AdaptiveText(
          text: label,
          maxLines: 1,
          minFontSize: 16,
          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 20),
        ));
  }
}
