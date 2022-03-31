// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../../new/responsive.dart';

class MeetOurLeaders extends StatelessWidget {
  const MeetOurLeaders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop() => Responsive.isDesktop(context);
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<Leaders> leaders = [
      Leaders(
        name: 'Vishal Nigam',
        role: 'CEO,Co-founder',
      ),
      Leaders(
        name: 'Aakarshit Madaan',
        role: 'Co-founder',
      ),
      Leaders(
        name: 'Paras Gaba',
        role: 'CTO',
      ),
    ];
    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(isDesktop()? 88:12.0,isDesktop() ?  height * 0.1:0, 0, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   SizedBox(height:isDesktop()? 60:30),
                  Row(
                    children: [
                      AdaptiveText(
                        text: 'Meet our Leaders',
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: isDesktop() ? 48 : 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Divider(
                        thickness: isDesktop() ? 9 : 4,
                        height: isDesktop() ? 9 : 4,
                        color: Colors.white,
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

         SizedBox(height:isDesktop() ?  60:30),
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-12',
              child: SizedBox(
                height:isDesktop() ?  500:300,
                child: ListView.builder(
                  itemCount: leaders.length,
                  padding: const EdgeInsets.only(top: 0),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return item(
                      isDesktop: isDesktop(),
                        name: leaders[index].name,
                        role: leaders[index].role,
                        index: index);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget item(
      {required String name,
      required String role,
      required bool isDesktop,
      Gradient? gradient,
      
      required int index}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            index == 0
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:  EdgeInsets.only(left: 58.0, top:isDesktop? 48:8.0),
                      child: Image.asset('assets/about_us/cardLeft.png',height: isDesktop?null:200),
                    ),
                  )
                : SizedBox(),
            index == 1
                ? Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding:  EdgeInsets.only(left:isDesktop? 58.0:60, top:isDesktop? 48:8.0),
                      child: Image.asset('assets/about_us/cardCenter.png',width: isDesktop?null:200),
                    ),
                  )
                : SizedBox(),
            index == 2
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:  EdgeInsets.only(left:isDesktop? 290.0:210, top:isDesktop? 40:10),
                      child: Image.asset('assets/about_us/cardRight.png',height: isDesktop?null:200),
                    ),
                  )
                : SizedBox(),
            Container(
              height:isDesktop? 327:200,
              width: isDesktop? 327:200,
              padding: const EdgeInsets.all(20),
              margin:  EdgeInsets.only(
                  top:isDesktop? 60:16, right: 70, left: 70, bottom:isDesktop? 32:16),
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
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
        AdaptiveText(
          text: name,
          style: GoogleFonts.montserrat(
            fontStyle: FontStyle.normal,
            fontSize:isDesktop? 18:14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.0),
        AdaptiveText(
          text: role,
          maxLines: 3,
          align: TextAlign.center,
          minFontSize: 10,
          style: GoogleFonts.openSans(
              fontStyle: FontStyle.normal,
              fontSize:isDesktop? 14:10,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ],
    );
  }
}

class Leaders {
  final String name;
  final String role;

  Leaders({required this.name, required this.role});
}
