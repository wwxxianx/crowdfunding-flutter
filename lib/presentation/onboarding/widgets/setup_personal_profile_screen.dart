import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/slide_route_transition.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/single_image_picker.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/personal_profile_success_screen.dart';
import 'package:flutter/material.dart';

class OnboardingPersonalProfileScreen extends StatefulWidget {
  static route() => SlideRoute(page: const OnboardingPersonalProfileScreen());
  const OnboardingPersonalProfileScreen({
    super.key,
  });

  @override
  State<OnboardingPersonalProfileScreen> createState() =>
      _OnboardingPersonalProfileScreenState();
}

class _OnboardingPersonalProfileScreenState
    extends State<OnboardingPersonalProfileScreen> {
  final fullNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  // SvgPicture.asset("assets/icons/organization-filled.svg"),
                  // 4.kW,
                  Text(
                    "Set up your account profile",
                    style: CustomFonts.titleLarge,
                  ),
                ],
              ),
              const Text(
                "Other people on __ can see your name and profile image. Don’t worry, you can change your account profile at any time.",
                style: CustomFonts.labelSmall,
              ),
              30.kH,
              //Form
              const Align(
                alignment: Alignment.center,
                child: SingleImagePicker(
                  size: 130,
                ),
              ),
              24.kH,
              CustomOutlinedTextfield(
                controller: fullNameTextController,
                label: "Full name",
              ),

              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      style: CustomButtonStyle.white,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          OnboardingProfileSuccessScreen.route(),
                          (route) => false,
                        );
                      },
                      child: const Text("Skip"),
                    ),
                  ),
                ],
              ),
              8.kH,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          OnboardingProfileSuccessScreen.route(),
                          (route) => false,
                        );
                      },
                      child: const Text("Next"),
                      // isLoading: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
