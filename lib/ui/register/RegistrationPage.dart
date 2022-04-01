import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/widgetHelper/FormTextField.dart';

class RegistrationPage extends StatefulWidget {
  static String ROUTE_REGISTRATION_PAGE = "route/RegistrationPage";

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formkey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  bool isOtpSent = false;
  String otpId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 36 + MediaQuery.of(context).padding.top,
            left: 40,
            right: 40,
          ),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  width: 200,
                  image: AssetImage("assets/images/sales_logo.png"),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 40,
                ),
                Text(
                  "Register here!",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 40,
                ),
                if (!isOtpSent)
                  FormTextField(
                    hintText: "Full Name",
                    iconColor: Colors.blue,
                    iconData: Icons.person,
                    validator: (String? input) =>
                        input!.isNotEmpty ? null : "Please enter correct name",
                    controller: _fullnameController,
                  ),
                Divider(
                  color: Colors.transparent,
                  height: 20,
                ),
                FormTextField(
                  hintText: "Email",
                  iconColor: Colors.blue,
                  iconData: Icons.email,
                  validator: (String? input) => input!.isValidEmail()
                      ? null
                      : "Invalid Email Id!!! Check your email",
                  controller: _emailController,
                ),
                Divider(
                  color: Colors.transparent,
                  height: 20,
                ),
                if (!isOtpSent)
                  FormTextField(
                    hintText: "Password",
                    iconColor: Colors.blue,
                    iconData: Icons.lock,
                    isPassword: true,
                    validator: (String? input) => input!.isValidPassword()
                        ? null
                        : "Add upper, lower, special character & number",
                    controller: _passwordController,
                  ),
                Divider(
                  color: Colors.transparent,
                  height: 20,
                ),
                if (isOtpSent)
                  FormTextField(
                    hintText: "OTP",
                    iconColor: Colors.blue,
                    iconData: Icons.lock,
                    validator: isOtpSent
                        ? (String? value) {
                            if (value!.isNotEmpty)
                              return null;
                            else
                              return "Enter OTP";
                          }
                        : (value) {
                            return null;
                          },
                    controller: _otpController,
                  ),
                Divider(
                  color: Colors.transparent,
                  height: 20,
                ),
                RoundedLoadingButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          "Register Now",
                          style: Theme.of(context).textTheme.button,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  controller: _btnController,
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      if (!isOtpSent)
                        sendOtp();
                      else
                        registerUser(context);
                    }
                  },
                  color: deepblue,
                  curve: Curves.easeOutQuart,
                  borderRadius: 12.0,
                  successColor: greenColor,
                  errorColor: redColor,
                  loaderStrokeWidth: 1.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendOtp() async {
    String otpId =
        await Repository.getInstance().postEmailOtp(_emailController.text);
    if (otpId.isNotEmpty) {
      setState(() {
        isOtpSent = true;
        this.otpId = otpId;
      });
    }
  }

  registerUser(BuildContext context) async {
    var success = await Repository.getInstance().postAccount(
      _fullnameController.text,
      _emailController.text,
      _passwordController.text,
      _otpController.text,
      otpId,
    );

    if (success) {
      _btnController.success();
      Timer(Duration(seconds: 1), () {
        _btnController.reset();
      });
      Navigator.of(context).pop();
    }
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(this);
  }
}
