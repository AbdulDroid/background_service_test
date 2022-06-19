import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ubenwa_abdulrahman/ui/signup/signupviewmodel.dart';

import '../../di/servicelocator.dart';
import '../../utils/margins.dart';
import '../../utils/navigationservice.dart';
import '../widgets/custombutton.dart';
import '../widgets/customtextfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _navHandler = getIT<NavigationHandler>();

  final nameController = TextEditingController();
  bool nameHasError = false;

  final emailController = TextEditingController();
  bool emailHasError = false;

  final passwordController = TextEditingController();
  bool passwordHasError = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SignUpViewModel>(context);
    TextStyle defaultStyle = const TextStyle(
        fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF88879C));
    TextStyle clickableStyle = const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: Color(0xFFF9923B),
        decoration: TextDecoration.underline);
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: width(26)),
          color: const Color(0xFFFFFBF8),
          child: Center(
              child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: height(116.0)),
                  const Text(
                    "Test App",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF384571)),
                  ),
                  SizedBox(height: height(86.0)),
                  Card(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(color: Color(0xFFFBF5FF), width: 1),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0.h, vertical: 20.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "SignUp",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                          SizedBox(
                            height: height(17),
                          ),
                          CustomTextField(
                            title: "Name",
                            inputType: TextInputType.name,
                            hintText: "Jane Doe",
                            filled: true,
                            controller: nameController,
                            containerHeight: nameHasError ? 80 : 60,
                            fieldHeight: nameHasError ? 60 : 40,
                            validator: (v) {
                              if (v!.isEmpty) {
                                setState(() {
                                  nameHasError = true;
                                });
                                return "Please enter your name";
                              } else {
                                setState(() {
                                  nameHasError = false;
                                });
                                return null;
                              }
                            },
                          ),
                          verticalSpaceSmall,
                          CustomTextField(
                            title: "Email",
                            inputType: TextInputType.emailAddress,
                            hintText: "example@gmail.com",
                            filled: true,
                            controller: emailController,
                            containerHeight: emailHasError ? 80 : 60,
                            fieldHeight: emailHasError ? 60 : 40,
                            validator: (v) {
                              if (v!.isEmpty) {
                                setState(() {
                                  emailHasError = true;
                                });
                                return "Email cannot be empty";
                              } else {
                                if (RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$")
                                    .hasMatch(v)) {
                                  setState(() {
                                    emailHasError = false;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    emailHasError = true;
                                  });
                                  return "Invalid email address";
                                }
                              }
                            },
                          ),
                          verticalSpaceSmall,
                          CustomTextField(
                            title: "Password",
                            obscure: true,
                            inputType: TextInputType.visiblePassword,
                            filled: true,
                            hintText: "········",
                            controller: passwordController,
                            containerHeight: passwordHasError ? 80 : 60,
                            fieldHeight: passwordHasError ? 60 : 40,
                            validator: (v) {
                              if (v!.isEmpty) {
                                setState(() {
                                  passwordHasError = true;
                                });
                                return "Please enter a password";
                              } else {
                                if (RegExp(r"(?=.*,)(?=.*\.).+").hasMatch(v)) {
                                  setState(() {
                                    passwordHasError = false;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    passwordHasError = true;
                                  });
                                  return "Password must contain , and .";
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: height(16.0),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(style: defaultStyle, children: <
                                  TextSpan>[
                                const TextSpan(
                                    text:
                                        "By entering your details, you are agreeing to our "),
                                TextSpan(
                                  text: "Terms of Service",
                                  style: clickableStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Terms of Service")));
                                    },
                                ),
                                const TextSpan(text: " and "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: clickableStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("Privacy Policy")));
                                    },
                                ),
                                const TextSpan(text: ", Thanks!"),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: height(28),
                          ),
                          CustomButton(
                            onPressed: (() {
                              if (_formKey.currentState!.validate()) {
                                vm.signup(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text, (v) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(v)));
                                });
                              }
                            }),
                            title: "Sign Up",
                            titleFontSize: 16.0,
                          ),
                          SizedBox(
                            height: height(34),
                          ),
                          RichText(
                            text: TextSpan(
                                style: defaultStyle,
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: "Already have an account? "),
                                  TextSpan(
                                    text: "Login",
                                    style: clickableStyle,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _navHandler.pop();
                                      },
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
        if (vm.isLoading)
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}
