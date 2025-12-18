// screens/sign_up_screen.dart
import 'dart:developer';

import 'package:e_commerce_app/widgets/custom_text_form_field_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isActive = false;
  bool? isCheckBoxActive = false;
  GlobalKey<FormState> key = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(27, 40, 28, 0),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create an account',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Connect with your friends today!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff999EA1),
                    ),
                  ),
                  SizedBox(height: 52),
                  CustomTextFormFieldWithTitle(
                    fieldLabel: 'Email',
                    controller: emailController,
                    hint: 'Enter your email',
                    validator: (value) {
                      // return Validator.validateEmail(value!);
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextFormFieldWithTitle(
                    fieldLabel: 'Phone number',
                    controller: phoneController,
                    hint: 'Enter your phone number',
                    validator: (value) {
                      // return Validator.validatePhoneNumber(value!);
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextFormFieldWithTitle(
                    fieldLabel: 'Password',
                    controller: passwordController,
                    hint: 'Enter your password',
                    validator: (value) {
                      // return Validator.validatePassword(value!);
                    },
                    obscureText: isActive,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isActive = !isActive;
                        });
                      },
                      icon: Icon(
                        isActive ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  ListTile(
                    leading: Checkbox(
                      value: isCheckBoxActive,
                      onChanged: (newValue) {
                        setState(() {
                          isCheckBoxActive = newValue;
                        });
                        log(isCheckBoxActive.toString());
                      },
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Remember Me',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 46),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff4E0189),
                      minimumSize: Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        log("Email: ${emailController.text}");
                        log("Phone: ${phoneController.text}");
                        log("Password: ${passwordController.text}");
                        log("============");
                        Navigator.of(
                          context,
                        ).pushReplacementNamed('/product_screen');

                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return ProductsScreen();
                        //     },
                        //   ),
                        // );
                      }
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 2)),
                      Text(
                        '  Or With  ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(child: Divider(thickness: 2)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                              side: BorderSide(color: Colors.grey, width: 2),
                            ),
                          ),
                          label: Text(
                            'Githhub',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          icon: SvgPicture.asset(
                            'assets/icons/github_icon.svg',
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                              side: BorderSide(color: Colors.grey, width: 2),
                            ),
                          ),
                          label: Text(
                            'Githlab',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          icon: SvgPicture.asset(
                            'assets/icons/gitlab_icon.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account ?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff999EA1),
                        ),
                      ),
                      TextButton(onPressed: () {}, child: Text('Login')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
