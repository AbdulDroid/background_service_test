import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:background_service_test/ui/login/loginviewmodel.dart';

import '../widgets/custombutton.dart';
import '../widgets/customtextfield.dart';
import '../../utils/margins.dart';
import '../../di/servicelocator.dart';
import '../../utils/navigationservice.dart';
import '../../utils/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _navHandler = getIT<NavigationHandler>();

  final TextEditingController emailController = TextEditingController();
  bool emailHasError = false;

  final TextEditingController passwordController = TextEditingController();
  bool passwordHasError = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);
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
          padding: EdgeInsets.symmetric(horizontal: 26.0.h),
          color: const Color(0xFFFFFBF8),
          child: Center(
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
                    side: const BorderSide(color: Color(0xFFFBF5FF), width: 1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 25.0.h, vertical: 20.0.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                          SizedBox(
                            height: height(17),
                          ),
                          CustomTextField(
                            title: "Email",
                            inputType: TextInputType.emailAddress,
                            hintText: "example@gmail.com",
                            filled: true,
                            controller: emailController,
                            containerHeight: emailHasError ? 76 : 60,
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
                            containerHeight: passwordHasError ? 76 : 60,
                            fieldHeight: passwordHasError ? 60 : 40,
                            validator: (v) {
                              if (v!.isEmpty) {
                                setState(() {
                                  passwordHasError = true;
                                });
                                return "Password cannot be empty";
                              } else {
                                setState(() {
                                  passwordHasError = false;
                                });
                                return null;
                              }
                            },
                          ),
                          verticalSpaceSmall,
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomButton(
                                    onPressed: (() {
                                      _navHandler.pushNamed("Forgot Password");
                                    }),
                                    isText: true,
                                    title: "forgot password?",
                                    titleFontSize: 13,
                                  ),
                                  SizedBox(
                                    width: width(16.0),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: height(38),
                          ),
                          CustomButton(
                            onPressed: (() {
                              if (_formKey.currentState!.validate()) {
                                vm.login(emailController.text,
                                    passwordController.text, (v) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(v)));
                                });
                              }
                            }),
                            title: "Login",
                            titleFontSize: 16.0,
                          ),
                          SizedBox(
                            height: height(105),
                          ),
                          RichText(
                            text: TextSpan(
                                style: defaultStyle,
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: "Don't have an account? "),
                                  TextSpan(
                                    text: "SignUp",
                                    style: clickableStyle,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _navHandler.pushNamed(Routes.SIGNUP);
                                      },
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
        if (vm.isLoading)
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
      ]),
    );
  }
}
