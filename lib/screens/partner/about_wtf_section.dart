import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';

class AboutWTFSection extends StatefulWidget {
  const AboutWTFSection({Key? key}) : super(key: key);

  @override
  _AboutWTFSectionState createState() => _AboutWTFSectionState();
}

class _AboutWTFSectionState extends State<AboutWTFSection> {
  List<String> title = ['3000 +', '100 +', '1000+', '50+'];
  List<String> subTitle = [
    'WTF Exclusive in-app workout \ndemos',
    'WTF Trained and Certified \nGurus',
    'WTF Curated diet plans',
    'In-App Hyper \nPersonalization feature',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 0, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 400,
              child: ListView.builder(
                  itemCount: title.length,
                  padding: const EdgeInsets.only(top: 0),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return item(subTitle: subTitle[index], title: title[index]);
                  }))
        ],
      ),
    );
  }

  Widget item({required String title, required subTitle, Gradient? gradient}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 154,
          width: 154,
          padding: const EdgeInsets.all(20),
          margin:
              const EdgeInsets.only(top: 60, right: 100, left: 100, bottom: 32),
          decoration: BoxDecoration(
            gradient: gradient != null
                ? gradient
                : const LinearGradient(
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Color(0XffFF002E),
                      Color(0XffFC0404),
                    ],
                  ),
            borderRadius: BorderRadius.circular(80),
          ),
          child: Center(
            child: AdaptiveText(
              text: title,
              style: GoogleFonts.montserrat(
                fontStyle: FontStyle.normal,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        AdaptiveText(
          text: subTitle,
          maxLines: 3,
          align: TextAlign.center,
          style: GoogleFonts.openSans(
              fontStyle: FontStyle.normal,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ],
    );
  }
}
