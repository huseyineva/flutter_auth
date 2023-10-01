import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/components/customButton.dart';
import 'package:login_page/components/customInputField.dart';
import 'package:login_page/components/customLink.dart';
import 'package:login_page/pages/home.dart';
import 'package:login_page/pages/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "", password = "", name = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  userRegister() async {
    // ignore: unnecessary_null_comparison
    if (password != null) {
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            )));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == "email-already-in-use") {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
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
                      "Sign In",
                      style: TextStyle(
                        color: colorPurple,
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                ),
                CustomInputField(
                  controller: nameController,
                  colorInput: colorInput,
                  iconColor: colorPurple,
                  colorInputText: colorInputText,
                  hintText: 'Your Name',
                  prefixIcon: Icons.person_2_outlined,
                  validationMessage: 'Please Enter Name',
                ),
                const SizedBox(
                  height: 50.0,
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
                CustomButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        email = userEmailController.text;
                        name = nameController.text;
                        password = userPasswordController.text;
                      });
                    }
                    userRegister();
                  },
                  buttonText: 'Create',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomLink(
                    rowText: "Already Have An Account?",
                    navigatorText: 'Login',
                    navigatorWay: const Login())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
