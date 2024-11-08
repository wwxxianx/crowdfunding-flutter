import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/common/utils/show_snackbar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/presentation/home/home_screen.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/onboarding_select_account_type_screen.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_event.dart';
import 'package:crowdfunding_flutter/state_management/login/login_bloc.dart';
import 'package:crowdfunding_flutter/state_management/login/login_event.dart';
import 'package:crowdfunding_flutter/state_management/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:logger/logger.dart';

class LoginForm extends StatefulWidget {
  final String? redirectPath;
  const LoginForm({
    super.key,
    this.redirectPath,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with InputValidator {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  void _handleLoginSubmit() {
    if (_formKey.currentState!.validate()) {
      final appUserCubit = context.read<AppUserCubit>();
      context.read<LoginBloc>().add(OnLogin(
            email: _emailController.text,
            password: _passwordController.text,
            onSuccess: (user) {
              appUserCubit.updateUser(user);
              // Brings user directly back where they landed on
              if (widget.redirectPath != null) {
                context.go(widget.redirectPath!);
                return;
              }
              if (user.isOnboardingCompleted) {
                // Init app state
                context.read<GiftCardBloc>().add(OnFetchAllGiftCards());
                context.read<AppUserCubit>().fetchNotifications();
                context.go('/home');
              } else {
                context.go(OnboardingSelectAccountScreen.route);
              }
            },
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              CustomOutlinedTextfield(
                focusNode: _focusNode,
                label: "Email",
                hintText: "email@gmail.com",
                controller: _emailController,
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
                controller: _passwordController,
                isObscureText: true,
                prefixIcon: const HeroIcon(
                  HeroIcons.lockClosed,
                  size: 20.0,
                ),
                onFieldSubmitted: (p0) {
                  _handleLoginSubmit();
                },
              ),
              20.kH,
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  isLoading: state is LoginLoading,
                  enabled: state is! LoginLoading,
                  onPressed: _handleLoginSubmit,
                  child: const Text("Login"),
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
                  onPressed: () {
                    final state = context.read<AppUserCubit>().state;
                    var logger = Logger();
                    logger.w(state);
                    if (state.currentUser != null) {
                      logger.w(state.currentUser!.isOnboardingCompleted);
                    }
                  },
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
          ),
        );
      },
    );
  }
}
