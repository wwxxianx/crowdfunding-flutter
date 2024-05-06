import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  void _handleLoginSubmit() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomOutlinedTextfield(
            focusNode: _focusNode,
            label: "Email",
            hintText: "email@gmail.com",
            controller: _emailController,
            validator: (value) => InputValidators.emailValidator(value),
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
              // isLoading: state is LoginLoading,
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
      ),
    );
  }
}
