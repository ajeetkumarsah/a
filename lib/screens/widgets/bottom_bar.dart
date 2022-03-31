import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/utils/const.dart';

class BottomBar extends StatefulWidget {
  final Color? color;
  const BottomBar({Key? key, this.color}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(
      gutterSize: 30,
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = Constants.getPadding(context);
    bool isDesktop() => Responsive.isDesktop(context);
    return Container(
      decoration: BoxDecoration(
          color: widget.color != null ? widget.color : Colors.transparent),
      child: BootstrapContainer(
        fluid: true,
        padding: EdgeInsets.all(padding),
        children: [
          BootstrapRow(
            children: <BootstrapCol>[
              BootstrapCol(
                  sizes: 'col-12 col-xl-3 col-sm-12 col-md-12',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 30, top: 30),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 100,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  )),
              BootstrapCol(
                sizes: 'col-xl-3 col-sm-6 col-md-4',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getHeading(
                      isDesktop: isDesktop(),heading: 'Quick Links'),
                    const SizedBox(
                      height: 18
                    ),
                    getItem(
                      isDesktop: isDesktop(),item: 'About', onClick: () {}),
                    getItem(
                      isDesktop: isDesktop(),item: 'FAQs', onClick: () {}),
                    getItem(
                      isDesktop: isDesktop(),item: 'Term & Conditions', onClick: () {}),
                    getItem(
                      isDesktop: isDesktop(),item: 'Refund & Cancellation', onClick: () {}),
                    getItem(
                      isDesktop: isDesktop(),item: 'Contact', onClick: () {}),
                  ],
                ),
              ),
              BootstrapCol(
                sizes: 'col-xl-3 col-sm-6 col-md-4',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getHeading(
                      isDesktop: isDesktop(),heading: 'Explore'),
                    const SizedBox(
                      height: 18,
                    ),
                    getItem(
                      isDesktop: isDesktop(),item: 'Arenas', onClick: () {}),
                    getItem(
                      isDesktop: isDesktop(),item: 'Studios', onClick: () {}),
                    getItem(
                      isDesktop: isDesktop(),item: 'Nutrition', onClick: () {}),
                    getItem(
                      isDesktop: isDesktop(),item: 'Personal Trainer', onClick: () {}),
                  ],
                ),
              ),
              BootstrapCol(
                sizes: 'col-12 col-xl-3 col-sm-12 col-md-4',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getHeading(
                      isDesktop: isDesktop(),heading: 'Contact'),
                    const SizedBox(
                      height: 18
                    ),
                    getItem(
                      isDesktop: isDesktop(),
                        item:
                            'Ro : S 1502, Amrapali Silicon city, Sector 76, Noida, Uttar Pradesh, India',
                        onClick: () {},
                        iconData: Icons.location_on),
                    getItem(
                      isDesktop: isDesktop(),
                        item:
                            'Ho : C-86 B, Ground Floor, Sector 8, Noida, Uttar Pradesh, India',
                        onClick: () {},
                        iconData: Icons.location_on),
                    getItem(
                      isDesktop: isDesktop(),
                        item: '+919090639005',
                        onClick: () {},
                        iconData: Icons.phone),
                    getItem(
                      isDesktop: isDesktop(),
                        item: 'support@wtfup.me',
                        onClick: () {},
                        iconData: Icons.mail),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getHeading({required String heading,required bool isDesktop}) {
    return ListTile(
      dense: true,
      title: Text(
        heading,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize:isDesktop? 20:18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget getItem(
      {required String item, required Function onClick, IconData? iconData,required bool isDesktop}) {
    return ListTile(
      onTap: onClick(),
      leading: iconData != null
          ? Icon(
              iconData,
              color: Colors.white,
            )
          : null,
      dense: true,
      title: Text(item,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize:isDesktop? 18:12,
          )),
    );
  }
}
