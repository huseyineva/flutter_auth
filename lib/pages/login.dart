import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/components/customButton.dart';
import 'package:login_page/components/customInputField.dart';
import 'package:login_page/components/customLink.dart';
import 'package:login_page/pages/forgot_password.dart';
import 'package:login_page/pages/home.dart';
import 'package:login_page/pages/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  void userLogin() async {
    try {
      final email = userEmailController.text;
      final password = userPasswordController.text;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "No User Found for that Email",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Wrong Password Provided by User",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
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
      body: SingleChildScrollView(
        child: Container(
          width: phoneWidth,
          height: phoneHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: colorPurple,
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 120.0,
                ),
                CustomInputField(
                  controller: userEmailController,
                  colorInput: colorInput,
                  iconColor: colorPurple,
                  colorInputText: colorInputText,
                  hintText: 'Your Email',
                  prefixIcon: Icons.email,
                  validationMessage: 'Please Enter E-Mail',
                ),
                const SizedBox(
                  height: 50.0,
                ),
                CustomInputField(
                  controller: userPasswordController,
                  colorInput: colorInput,
                  iconColor: colorPurple,
                  colorInputText: colorInputText,
                  hintText: 'Password',
                  prefixIcon: Icons.password_outlined,
                  validationMessage: 'Please Enter Password',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 50.0),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: colorPurple,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      userLogin();
                    }
                  },
                  buttonText: 'Login',
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomLink(
                    rowText: "Don't Have An Account?",
                    navigatorText: 'Sign Up',
                    navigatorWay: const Register())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
