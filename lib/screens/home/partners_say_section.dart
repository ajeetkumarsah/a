import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
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
    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 45, bottom: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AdaptiveText(
              text: 'What our Partner say about us?',
              maxLines: 10,
              style:  TextStyle(
                fontWeight: FontWeight.w400,
                fontSize:isMobile() ?18: 36,
                color: Colors.white,
                fontStyle: FontStyle.normal,
              )),
          SizedBox(
              height: isMobile()?320: 500,
              child: ListView.builder(
                physics: ScrollPhysics(),
                  itemCount: 5,
                  padding:  EdgeInsets.only(top:isMobile()?16: 65),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return item(isMobile(),index);
                  }))
        ],
      ),
    );
  }

  Widget item(bool isMobile, int index) {
    return Padding(
     padding:  EdgeInsets.only(left:index==0?100.0:50,right:index==4?100:50),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding:  EdgeInsets.only(
                left: 20, top:isMobile?16.0: 45 + 20, right: 20, bottom:isMobile?8.0: 20),
            margin:  EdgeInsets.only(top: 60),
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
            height: isMobile?198: 311,
            width:isMobile?309: 695,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AdaptiveText(
                  text: 'Ragini Sharma',
                  style: GoogleFonts.openSans(
                      fontStyle: FontStyle.normal,
                      fontSize:isMobile?12: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 4
                ),
                AdaptiveText(
                  text: 'ONE Fitness (Noida sector 8)',
                  style: GoogleFonts.openSans(
                      fontStyle: FontStyle.normal,
                      fontSize:isMobile?12: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 15
                ),
                AdaptiveText(
                  text:
                      'I am really impressed with the WTF Team ,From the day 1 my sales growth is going up along with i am able to make new members easily,from marketing to payments all are easily managable through WTF,I really recommend it to every gym owner out there.',
                  align: TextAlign.center,
                  maxLines: 20,
                  style: GoogleFonts.openSans(
                      fontStyle: FontStyle.normal,
                      fontSize:isMobile?12: 17,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 16
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              radius:isMobile?37: 56,
              child: Padding(
                padding: const EdgeInsets.all(0), // Border radius
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 6.0, color: Color.fromARGB(255, 12, 12, 12)),
                      borderRadius: BorderRadius.circular(90)),
                  child: ClipOval(
                      child: Image.asset('assets/home/girl_exercise.png')),
                ),
              ),
            ),
           
          ),
        ],
      ),
    );
  }
}
