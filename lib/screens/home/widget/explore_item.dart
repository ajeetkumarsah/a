import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';

class ExploreItem extends StatelessWidget {
  const ExploreItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
       gradient: LinearGradient(
         begin: Alignment.topLeft,
         end: Alignment.bottomRight,
         colors: GradientColors.red
       )
      ),child: ListTile(
      title: Row(
        children: [
          AdaptiveText(
            text: 'Fitness by WTF',
            minFontSize: 16,
            style: const TextStyle(color: Colors.white,fontSize: 24),
          ),const  Spacer(),
          const Icon(FontAwesomeIcons.dumbbell)
        ],
      ),
    ),
    );
  }
}
