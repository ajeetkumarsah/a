import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      children: [
        BootstrapContainer(
          fluid: false,
          padding: const EdgeInsets.only(top: 50),
          children: <Widget>[
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Constants.white),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 172, 168, 168),
                    ),
                    suffixIcon: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Constants.primaryColor,
                        border:
                            Border.all(width: 2, color: Constants.primaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: AdaptiveText(
                          text: "Search",
                          align: TextAlign.left,
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
