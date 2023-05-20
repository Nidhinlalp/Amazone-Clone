import 'package:amazone_clone/resources/authentication_methods.dart';
import 'package:amazone_clone/screens/sign_up_screen.dart';
import 'package:amazone_clone/utils/colrs_theme.dart';
import 'package:amazone_clone/utils/utils.dart';
import 'package:amazone_clone/widgets/custom_main_button.dart';
import 'package:flutter/material.dart';
import 'package:amazone_clone/widgets/text_feild_widget.dart';

import '../utils/constats.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
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
                    Container(
                      padding: const EdgeInsets.all(18),
                      height: screenSize.height * 0.6,
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
                            'Sign-In',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                            ),
                          ),
                          TextFeildwidget(
                            controller: _emailController,
                            obscureText: false,
                            title: 'Email',
                            hintText: 'Enter your email address',
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
                                    await authenticationMethods.signInUser(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                if (outPut == "success") {
                                  print(outPut);
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  Utils().showSnackBar(
                                    context: context,
                                    content: outPut,
                                  );
                                }
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'New To Amazon',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    CustomMainButton(
                      clolor: Colors.grey[200]!,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ));
                      },
                      child: const Text(
                        'Create an Account',
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
