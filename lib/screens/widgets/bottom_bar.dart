import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:wtf_web/utils/const.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

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
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
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
              sizes: 'col-12 col-xl-3 col-sm-12 col-md-4',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getHeading(heading: 'Quick Links'),
                  const SizedBox(
                    height: 18,
                  ),
                  getItem(item: 'About', onClick: () {}),
                  getItem(item: 'FAQs', onClick: () {}),
                  getItem(item: 'Term & Conditions', onClick: () {}),
                  getItem(item: 'Refund & Cancellation', onClick: () {}),
                  getItem(item: 'Contact', onClick: () {}),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-xl-3 col-sm-12 col-md-4',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeading(heading: 'Explore'),
                  const SizedBox(
                    height: 18,
                  ),
                  getItem(item: 'Arenas', onClick: () {}),
                  getItem(item: 'Studios', onClick: () {}),
                  getItem(item: 'Nutrition', onClick: () {}),
                  getItem(item: 'Personal Trainer', onClick: () {}),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-xl-3 col-sm-12 col-md-4',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeading(heading: 'Contact'),
                  const SizedBox(
                    height: 18,
                  ),
                  getItem(
                      item:
                          'Ro : S 1502, Amrapali Silicon city, Sector 76, Noida, Uttar Pradesh, India',
                      onClick: () {},
                      iconData: Icons.location_on),
                  getItem(
                      item:
                          'Ho : C-86 B, Ground Floor, Sector 8, Noida, Uttar Pradesh, India',
                      onClick: () {},
                      iconData: Icons.location_on),
                  getItem(
                      item: '+919090639005',
                      onClick: () {},
                      iconData: Icons.phone),
                  getItem(
                      item: 'support@wtfup.me',
                      onClick: () {},
                      iconData: Icons.mail),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getHeading({required String heading}) {
    return ListTile(
      dense: true,
      title: Text(
        heading,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget getItem(
      {required String item, required Function onClick, IconData? iconData}) {
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
            fontSize: 18,
          )),
    );
  }
}
