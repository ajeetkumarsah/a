import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/Profile.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/settings/widget/profile_photo.dart';
import 'package:salessimplify/ui/widgetHelper/bottomsheet.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';
import 'package:provider/provider.dart';
import 'arguments/profile_arguments.dart';

class UpdateUserInfo extends StatefulWidget {
  static String routeName = "updateUserInfo";
  Profile data;
  UpdateUserInfo({Key? key, required this.data}) : super(key: key);

  @override
  _UpdateUserInfoState createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  var _image;

  Future camaraImage() async {
    PickedFile? image = (await ImagePicker()
        .getImage(source: ImageSource.camera, maxWidth: 400, imageQuality: 50));

    setState(() {
      _image = File(image!.path);
    });
    uploadProfilePicture(context, _image.path);
    Navigator.pop(context);
  }

  Future galleryImage() async {
    PickedFile? image = (await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 1200,
        imageQuality: 80));

    setState(() {
      _image = File(image!.path);
    });
    uploadProfilePicture(context, _image.path);
    Navigator.pop(context);
  }

  uploadProfilePicture(BuildContext context, String path) async {
    var success = await Repository.getInstance().updateUserProfilePicture(path);
    toastHelper.toastWithTitleAndColor(success, greenColor);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final ProfileArguments args =
        ModalRoute.of(context)!.settings.arguments as ProfileArguments;
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      backgroundColor: white,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    _image == null
                        ? Container(
                            width: 150,
                            height: 150,
                            decoration: ShapeDecoration(
                                shape: CircleBorder(), color: lightBlue),
                            padding: EdgeInsets.all(2.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProfilePhoto(
                                          image: args.data?.avatar ?? ''),
                                    ),
                                  );
                                },
                                child: DecoratedBox(
                                  decoration: ShapeDecoration(
                                    shape: CircleBorder(),
                                    image: args.data?.avatar == null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/user.png',
                                            ),
                                          )
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              args.data?.avatar ?? '',
                                            ),
                                          ),
                                  ),
                                )),
                          )
                        : Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 2, color: lightBlue),
                                borderRadius: BorderRadius.circular(90)),
                            child: CircleAvatar(
                              radius: 18,
                              child: ClipOval(
                                child: Image.file(
                                  _image,
                                  width: 150.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 110, left: 90),
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          gradient:
                              LinearGradient(colors: [lightBlue, deepblue]),
                        ),
                        child: GestureDetector(
                          onTap: () => customBottomSheet.imageBottomDialog(
                              context, camaraImage, galleryImage),
                          child: Center(
                            child: Icon(Icons.camera, color: white, size: 25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _settingsItem(
                            title: 'Full Name',
                            icon: Boxicons.bx_user,
                            subtitle: args.data?.fullName ?? 'Full Name',
                            onTap: () {},
                            editOnPressed: () {
                              // CustomBottomSheet(
                              //   handler: refresh,
                              //   id: '',
                              // ).settingsBottomDialog(
                              //   context,
                              //   'full Name',
                              //   args.data!.fullName,
                              // );
                            }),
                        _divider(),
                        _settingsItem(
                            title: 'Company',
                            icon: Boxicons.bx_buildings,
                            subtitle: args.data?.company ?? 'Company',
                            onTap: () {},
                            editOnPressed: () {
                              // CustomBottomSheet(
                              //   handler: refresh,
                              //   id: '',
                              // ).settingsBottomDialog(
                              //   context,
                              //   'company name',
                              //   args.data!.company,
                              // );
                            }),
                        _divider(),
                        _settingsItem(
                            title: 'Email',
                            icon: Boxicons.bx_mail_send,
                            subtitle: args.data?.email ?? 'Email',
                            onTap: () {},
                            editOnPressed: () {
                              // CustomBottomSheet(
                              //   handler: refresh,
                              //   id: '',
                              // ).settingsBottomDialog(
                              //     context, 'email id', args.data!.email);
                            }),
                        _divider(),
                        _settingsItem(
                          title: 'Phone',
                          icon: Boxicons.bxs_phone_call,
                          subtitle: args.data?.phone ?? 'Phone',
                          onTap: () {},
                          editOnPressed: () {
                            // CustomBottomSheet(
                            //   handler: refresh,
                            //   id: '',
                            // ).settingsBottomDialog(
                            //   context,
                            //   'phone number',
                            //   args.data!.phone,
                            // );
                          },
                        ),
                        _divider(),
                        _settingsItem(
                          title: 'Website',
                          icon: Boxicons.bx_world,
                          subtitle: args.data?.website ?? 'Website',
                          onTap: () {},
                          editOnPressed: () {
                            // CustomBottomSheet(
                            //   handler: refresh,
                            //   id: '',
                            // ).settingsBottomDialog(
                            //     context, 'website', args.data!.website);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  refresh() {
    setState(() {});
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Container(height: 0.5, color: Colors.grey[200]),
    );
  }

  _settingsItem(
      {required String title,
      String? subtitle,
      IconData? icon,
      Function()? onTap,
      Function()? editOnPressed}) {
    return ListTile(
      onTap: editOnPressed,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(12.0)),
        child: Center(
          child: Icon(
            icon == null ? Boxicons.bxs_image_add : icon,
            color: Colors.blue,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: black, fontWeight: FontWeight.w400),
      ),
      //remove the below commented code if you want to use edit feature
      // trailing: editOnPressed != null ? EditButton(onTap: editOnPressed) : null,
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(color: black, fontWeight: FontWeight.w300),
            )
          : null,
    );
  }
}
