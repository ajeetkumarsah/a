import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/LoggedProfile.dart';
import 'package:salessimplify/models/location_model.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/sessionmanager/SessionManager.dart';
import 'package:salessimplify/ui/landing/LandingPage.dart';
import 'package:salessimplify/ui/widgetHelper/FormTextField.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wifi/wifi.dart';

class LoginPage extends StatelessWidget {
  static String ROUTE_LOGIN_PAGE = "route/login_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWidget(),
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _googlebtnController =
      RoundedLoadingButtonController();
  final storage = new FlutterSecureStorage();

  bool isOtpRequired = false;
  bool _passwordVisible = true;
  bool _isSelected = true;
  String ipAddress = '';

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
    _setData().then((userEmail) => {
          print(userEmail),
        });
    selfIP;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _setData() async {
    var mail = await storage.read(key: "e");
    var pass = await storage.read(key: "p");
    setState(() {
      print(mail! + '~~~~~~~~~~~' + pass!);
    });
    if (mail != null && pass != null) {
      setState(() {
        _emailController = TextEditingController(text: mail);
        _passwordController = TextEditingController(text: pass);
      });
    } else {
      setState(() {
        print('Else Part');
      });
    }
  }

  Future<InternetAddress> get selfIP async {
    ipAddress = await Wifi.ip;
    setState(() {});
    return InternetAddress(ipAddress);
  }

  @override
  Widget build(BuildContext context) {
    isOtpRequired = context.watch<Repository>().isOtpSent;
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: white,
            padding: EdgeInsets.only(
              top: 36 + MediaQuery.of(context).padding.top,
              left: 40,
              right: 40,
            ),
            alignment: Alignment.center,
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: 200,
                    image: AssetImage("assets/images/sales_logo.png"),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 70,
                  ),
                  FormTextField(
                    hintText: "Email",
                    iconColor: Colors.blue,
                    iconData: Icons.email,
                    controller: _emailController,
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 30,
                  ),
                  if (!isOtpRequired)
                    FormTextField(
                      hintText: "Password",
                      iconColor: Colors.blue,
                      iconData: Icons.lock,
                      isPassword: _passwordVisible,
                      controller: _passwordController,
                      onTextChange: (String s) {
                        setState(() {
                          if (formkey.currentState!.validate()) {
                            _btnController.reset();
                          }
                        });
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                          size: 18,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  if (isOtpRequired)
                    FormTextField(
                      hintText: "Enter OTP",
                      iconColor: Colors.blue,
                      iconData: Icons.lock,
                      isPassword: true,
                      controller: _otpController,
                    ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: _radio,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 4.0),
                        radioButton(_isSelected),
                        SizedBox(width: 8.0),
                        Text("Remember me", style: TextStyle(fontSize: 12))
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Container(
                  //   width: double.infinity,
                  //   margin: EdgeInsets.only(
                  //     top: 20,
                  //     bottom: 20,
                  //   ),
                  //   child: Text(
                  //     "Forgot Password?",
                  //     style: TextStyle(
                  //         fontSize: 12,
                  //         color: deepblue,
                  //         fontWeight: FontWeight.bold),
                  //     textAlign: TextAlign.end,
                  //   ),
                  // ),
                  RoundedLoadingButton(
                    child: Container(
                      padding: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [lightGreen, deepGreen],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    controller: _btnController,
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        login(context);
                      } else {
                        _btnController.error();
                        //
                      }
                    },
                    color: lightGreen,
                    curve: Curves.easeOutQuart,
                    borderRadius: 12.0,
                    successColor: greenColor,
                    errorColor: redColor,
                    loaderStrokeWidth: 1.5,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //     top: 30,
                  //     bottom: 30,
                  //   ),
                  //   child: Stack(
                  //     alignment: Alignment.center,
                  //     children: [
                  //       Divider(
                  //         thickness: 1,
                  //       ),
                  //       Container(
                  //         padding: EdgeInsets.only(left: 12, right: 12),
                  //         color: Colors.white,
                  //         child: Text(
                  //           "Or",
                  //           style: Theme.of(context).textTheme.bodyText2,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // RoundedLoadingButton(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       // Image(
                  //       //   image: AssetImage("assets/images/gmail.png"),
                  //       // ),
                  //       Icon(Boxicons.bxl_google_plus, size: 40),
                  //       Container(
                  //         margin: EdgeInsets.only(
                  //           left: 20,
                  //         ),
                  //         child: Text(
                  //           "Log In with Google",
                  //           style: Theme.of(context).textTheme.button,
                  //           textAlign: TextAlign.center,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  //   controller: _googlebtnController,
                  //   onPressed: () => loginWithGoogle(),
                  //   color: deepblue,
                  //   curve: Curves.easeOutQuart,
                  //   borderRadius: 12.0,
                  //   successColor: greenColor,
                  //   errorColor: redColor,
                  //   loaderStrokeWidth: 1.5,
                  // ),
                  InkWell(
                    onTap: () {
                      launch('https://app.salessimplify.com/auth/registration');
                      // Navigator.of(context)
                      //     .pushNamed(RegistrationPage.ROUTE_REGISTRATION_PAGE);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 22),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have account?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            " Sign Up",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: deepblue,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginWithGoogle() async {
    Timer(Duration(seconds: 3), () {
      _googlebtnController.error();
      _googlebtnController.reset();
    });
    /*var userCredential = await signInWithGoogle();
    userCredential.user!.getIdToken().then((value) {
      SessionManager.getInstance().saveProfile(
        id: userCredential.user?.uid,
        name: userCredential.user?.displayName,
        emailId: userCredential.user?.email,
        authToken: value,
        uuid: userCredential.user?.uid,
      );
    });*/
  }

  login(BuildContext context) async {
    LocationModel locationModel;
    locationModel = await Repository.getInstance().getLocation();
    String lication = '${locationModel.city}, ${locationModel.countryName}';

    var success = await context.read<Repository>().postLogin(
        _emailController.text,
        _passwordController.text,
        _otpController.text,
        ipAddress,
        lication);
    if (success == "Invalid") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Please check Email and Password is correct!'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          )));
      _btnController.error();
      Timer(Duration(seconds: 1), () {
        _btnController.reset();
      });
      return;
    }

    if (success == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('OTP Sent'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          )));
      _btnController.error();
      Timer(Duration(seconds: 1), () {
        _btnController.reset();
      });

      context.read<Repository>().isOtpSent = true;
    } else {
      // api call for profile
      _btnController.success();
      Timer(Duration(seconds: 2), () {
        _btnController.reset();
      });

      LoggedProfile data =
          await Repository.getInstance().getCurrentUserDetails(success);
      if (_isSelected) {
        await storage.write(key: "e", value: data.email);
        await storage.write(key: "p", value: _passwordController.text);
      }

      await SessionManager.getInstance().saveProfile(
        id: data.id,
        name: data.fullName,
        emailId: data.email,
        authToken: success,
        uuid: "",
      );
      Navigator.of(context).popAndPushNamed(LandingPage.ROUTE_LANDING_PAGE);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Widget radioButton(bool isSelected) => Container(
        width: 18.0,
        height: 18.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: deepblue)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: deepblue),
              )
            : Container(),
      );

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }
}
