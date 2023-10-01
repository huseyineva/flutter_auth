import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/components/customInputField.dart';
import 'package:login_page/components/customLink.dart';
import 'package:login_page/pages/login.dart';
import 'package:login_page/pages/register.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  // ignore: unnecessary_new
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Password Reset Email has been sent !",
        style: TextStyle(fontSize: 18.0),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "No user found for that email.",
          style: TextStyle(fontSize: 18.0),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    Color colorPurple = const Color(0xFF5C27FE);
    Color colorInput = const Color(0xFFF2F2F2);
    Color colorInputText = const Color(0xFF646060);
    return Scaffold(
      body: Container(
        width: phoneWidth,
        height: phoneHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 250.0,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Password Recovery",
                  style: TextStyle(
                    color: colorPurple,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              Expanded(
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: ListView(
                      children: [
                        CustomInputField(
                            controller: mailcontroller,
                            colorInput: colorInput,
                            iconColor: colorPurple,
                            colorInputText: colorInputText,
                            hintText: 'E-mail',
                            prefixIcon: Icons.email,
                            validationMessage: 'Please Enter E-mail'),
                        const SizedBox(height: 50.0),
                        Container(
                          margin: const EdgeInsets.only(left: 60.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      email = mailcontroller.text;
                                    });
                                    resetPassword();
                                  }
                                },
                                child: Container(
                                    width: 140,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: colorPurple,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "Send Email",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, a, b) =>
                                            const Login(),
                                        transitionDuration:
                                            const Duration(seconds: 0),
                                      ),
                                      (route) => false);
                                },
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        CustomLink(
                            rowText: "Don't Have An Account?",
                            navigatorText: ' Create',
                            navigatorWay: const Register())
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
