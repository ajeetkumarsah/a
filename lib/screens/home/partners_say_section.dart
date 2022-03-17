import 'package:flutter/material.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class PartnerSaySection extends StatefulWidget {
  const PartnerSaySection({Key? key}) : super(key: key);

  @override
  _PartnerSaySectionState createState() => _PartnerSaySectionState();
}

class _PartnerSaySectionState extends State<PartnerSaySection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 45, bottom: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AdaptiveText(
              text: 'What our Partner say about us?',
              maxLines: 10,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 36,
                color: Colors.white,
                fontStyle: FontStyle.normal,
              )),
          SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.only(top: 65),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return item();
                  }))
        ],
      ),
    );
  }

  Widget item() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 20, top: 45 + 20, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 60, right: 30, left: 30),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: [
                  0.0,
                  1.0
                ],
                colors: [
                  Color(0XffFF002E),
                  Color(0XffFC0404),
                ]),
            image: const DecorationImage(
              image: AssetImage(
                "assets/home/partner_bg.png",
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          height: 311,
          width: 695,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AdaptiveText(
                text: 'Ragini Sharma',
                style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 4,
              ),
              AdaptiveText(
                text: 'ONE Fitness (Noida sector 8)',
                style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              AdaptiveText(
                text:
                    'I am really impressed with the WTF Team ,From the day 1 my sales growth is going up along with i am able to make new members easily,from marketing to payments all are easily managable through WTF,I really recommend it to every gym owner out there.',
                align: TextAlign.center,
                maxLines: 20,
                style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            radius: 56,
            child: Padding(
              padding: const EdgeInsets.all(0), // Border radius
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 6.0, color: Color.fromARGB(255, 12, 12, 12)),
                    borderRadius: BorderRadius.circular(90)),
                child: ClipOval(
                    child: Image.network('assets/home/girl_exercise.png')),
              ),
            ),
          ),
          // CircleAvatar(
          //     backgroundColor: Constants.secondBlack,
          //     foregroundColor: Constants.secondBlack,
          //     radius: 60.0,
          //     child: const CircleAvatar(
          //       backgroundImage: AssetImage("assets/home/men_exercise.png"),
          //       radius: 50.0,
          //     ),
          //   ),
        ),
      ],
    );
  }
}
