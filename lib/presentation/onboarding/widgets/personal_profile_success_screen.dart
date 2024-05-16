import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/presentation/navigation/navigation_screen.dart';
import 'package:flutter/material.dart';

class OnboardingProfileSuccessScreen extends StatelessWidget {
  static route() => MaterialPageRoute(
      builder: (context) => const OnboardingProfileSuccessScreen());
  const OnboardingProfileSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding),
          child: Column(
            children: [
              const Text("Welcome"),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: NavigationScreen.route(),
                      child: const Text("OK"),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
