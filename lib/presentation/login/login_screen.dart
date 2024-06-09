import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/presentation/login/widgets/login_form.dart';
import 'package:crowdfunding_flutter/presentation/sign_up/sign_up_screen.dart';
import 'package:crowdfunding_flutter/state_management/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  static const route = '/login';
  final String? fromPath;
  const LoginScreen({
    super.key,
    this.fromPath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(login: serviceLocator()),
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
                  "Login",
                  style: CustomFonts.titleExtraLarge,
                ),
                24.kH,
                LoginForm(
                  redirectPath: fromPath,
                ),
                24.kH,
                Row(
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: CustomFonts.labelMedium,
                    ),
                    InkWell(
                      onTap: () {
                        context.goNamed('sign-up',
                            queryParameters: {'from': fromPath});
                      },
                      child: Ink(
                        child: Text(
                          "Sign up now",
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
