import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/common/utils/show_snackbar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/onboarding_select_account_type_screen.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_bloc.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_event.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class SignUpForm extends StatefulWidget {
  final String? redirectPath;
  const SignUpForm({
    super.key,
    this.redirectPath,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with InputValidator {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();

  void _handleSignUpSubmit() {
    if (formKey.currentState!.validate()) {
      final appUserCubit = context.read<AppUserCubit>();
      context.read<SignUpBloc>().add(
            OnSignUp(
              email: emailController.text,
              password: passwordController.text,
              onSuccess: (user) {
                appUserCubit.updateUser(user);
                if (widget.redirectPath != null) {
                  context.go(widget.redirectPath!);
                  return;
                }
                context.go(OnboardingSelectAccountScreen.route);
              },
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                focusNode: focusNode,
                label: "Email",
                hintText: "email@gmail.com",
                controller: emailController,
                validator: (value) {
                  final validationResult = validateEmail(value);
                  if (validationResult.successful) {
                    return null;
                  }
                  return validationResult.errorMessage;
                },
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
                controller: passwordController,
                isObscureText: true,
                prefixIcon: const HeroIcon(
                  HeroIcons.lockClosed,
                  size: 20.0,
                ),
                validator: (value) => validatePassword(value),
                onFieldSubmitted: (p0) {
                  _handleSignUpSubmit();
                },
              ),
              20.kH,
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  isLoading: state is SignUpLoading,
                  enabled: state is! SignUpLoading,
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
