import 'package:url_launcher/url_launcher.dart';

class Utils {
  static launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static launchWtp({required String number}) async {
    String url = "https://wa.me/$number?";
    var encoded = Uri.encodeFull(url);
    if (await canLaunch(encoded)) {
      await launch(encoded);
    } else {
      throw 'Could not launch $encoded';
    }
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
