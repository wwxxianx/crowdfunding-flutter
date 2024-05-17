import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/common/utils/show_snackbar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/onboarding_select_account_type_screen.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_bloc.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_event.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with InputValidator {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  void _handleSignUpSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpBloc>().add(
            OnSignUp(
              email: _emailController.text,
              password: _passwordController.text,
              navigateToOnboarding: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  OnboardingSelectAccountScreen.route(),
                  (route) => false,
                );
              },
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            context.showSnackBar("Failed to register");
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              CustomOutlinedTextfield(
                focusNode: _focusNode,
                label: "Email",
                hintText: "email@gmail.com",
                controller: _emailController,
                validator: (value) => emailValidator(value),
                prefixIcon: const HeroIcon(
                  HeroIcons.envelope,
                  size: 20.0,
                ),
                textInputAction: TextInputAction.next,
              ),
              16.kH,
              CustomOutlinedTextfield(
                label: "Password",
                hintText: "********",
                controller: _passwordController,
                isObscureText: true,
                prefixIcon: const HeroIcon(
                  HeroIcons.lockClosed,
                  size: 20.0,
                ),
                validator: (value) => passwordValidator(value),
                onFieldSubmitted: (p0) {
                  _handleSignUpSubmit();
                },
              ),
              20.kH,
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  isLoading: state is SignUpLoading,
                  onPressed: _handleSignUpSubmit,
                  child: const Text("Sign Up"),
                ),
              ),
              24.kH,
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      indent: 0,
                      endIndent: 8,
                      color: CustomColors.divider,
                    ),
                  ),
                  Text(
                    "or",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFB0B0B0),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      indent: 8,
                      endIndent: 0,
                      color: CustomColors.divider,
                    ),
                  ),
                ],
              ),
              24.kH,
              SizedBox(
                width: double.maxFinite,
                child: CustomButton(
                  style: CustomButtonStyle.white,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/google-logo.png",
                        height: 20.0,
                        width: 20.0,
                        fit: BoxFit.cover,
                      ),
                      10.kW,
                      Text("Continue with Google")
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
