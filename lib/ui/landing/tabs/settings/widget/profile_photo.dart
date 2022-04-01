import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProfilePhoto extends StatelessWidget {
  final String image;
  const ProfilePhoto({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: image != ''
            ? PhotoView(
                minScale: PhotoViewComputedScale.contained * 0.95,
                maxScale: PhotoViewComputedScale.covered * 2,
                imageProvider: NetworkImage(image))
            : PhotoView(
                minScale: PhotoViewComputedScale.contained * 0.95,
                maxScale: PhotoViewComputedScale.covered * 2,
                imageProvider: AssetImage('assets/images/user.png'),
              ));
  }
}
