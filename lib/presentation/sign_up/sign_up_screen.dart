import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/presentation/login/login_screen.dart';
import 'package:crowdfunding_flutter/presentation/sign_up/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  static const route = '/sign-up';
  final String? fromPath;
  const SignUpScreen({super.key, this.fromPath, });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE2FEDD),
                  Colors.white,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.only(
              left: Dimensions.screenHorizontalPadding,
              right: Dimensions.screenHorizontalPadding,
              top: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Register",
                  style: CustomFonts.titleExtraLarge,
                ),
                24.kH,
                SignUpForm(redirectPath: fromPath),
                24.kH,
                Row(
                  children: [
                    const Text(
                      "Already have an account?",
                      style: CustomFonts.labelMedium,
                    ),
                    InkWell(
                      onTap: () {
                        context.go(LoginScreen.route);
                      },
                      child: Ink(
                        child: Text(
                          "Sign in now",
                          style: CustomFonts.labelMedium.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
