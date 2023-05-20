import 'dart:developer';

import 'package:amazone_clone/screens/sign_in-screen.dart';
import 'package:flutter/material.dart';

import '../resources/authentication_methods.dart';
import '../utils/colrs_theme.dart';
import '../utils/constats.dart';
import '../utils/utils.dart';
import '../widgets/custom_main_button.dart';
import '../widgets/text_feild_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      amazonLogo,
                      height: screenSize.height * 0.10,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.7,
                      child: FittedBox(
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          height: screenSize.height * 0.85,
                          width: screenSize.width * 0.8,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Sign-Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28,
                                ),
                              ),
                              TextFeildwidget(
                                controller: _nameController,
                                obscureText: false,
                                title: 'Name',
                                hintText: 'Enter your name',
                              ),
                              TextFeildwidget(
                                controller: _addressController,
                                obscureText: false,
                                title: 'Address',
                                hintText: 'Enter your  address',
                              ),
                              TextFeildwidget(
                                controller: _emailController,
                                obscureText: false,
                                title: 'Email',
                                hintText: 'Enter your email  address',
                              ),
                              TextFeildwidget(
                                controller: _passwordController,
                                obscureText: true,
                                title: 'Password',
                                hintText: 'Enter your password',
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: CustomMainButton(
                                  clolor: yellowColor,
                                  isLoading: isLoading,
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    String outPut =
                                        await authenticationMethods.signUpUser(
                                      name: _nameController.text,
                                      address: _addressController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    if (outPut == "success") {
                                      log("created");
                                      log(outPut);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else {
                                      Utils().showSnackBar(
                                        content: outPut,
                                        context: context,
                                      );
                                      log("faild");
                                      log(outPut);
                                    }
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        letterSpacing: 0.6,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CustomMainButton(
                      clolor: Colors.grey[200]!,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ));
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          letterSpacing: 0.6,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
