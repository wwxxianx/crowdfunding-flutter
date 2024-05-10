import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/slide_route_transition.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/selectable_container.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/onboarding_select_npo_join_method_screen.dart';
import 'package:flutter/material.dart';

class OnboardingSelectAccountScreen extends StatefulWidget {
  static route() => SlideRoute(page: const OnboardingSelectAccountScreen());
  const OnboardingSelectAccountScreen({super.key});

  @override
  State<OnboardingSelectAccountScreen> createState() =>
      _OnboardingSelectAccountScreenState();
}

class _OnboardingSelectAccountScreenState
    extends State<OnboardingSelectAccountScreen> {
  bool isPersonalSelected = true;

  void _handleSelectPersonal() {
    setState(() {
      isPersonalSelected = true;
    });
  }

  void _handleSelectNPO() {
    setState(() {
      isPersonalSelected = false;
    });
  }

  void _handleNextPage() {
    if (isPersonalSelected) {
    } else {
      Navigator.push(context, OnboardingSelectNPOJoinMethodScreen.route());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          padding: EdgeInsets.only(
            left: Dimensions.screenHorizontalPadding,
            right: Dimensions.screenHorizontalPadding,
            bottom: 20,
            top: MediaQuery.of(context).viewPadding.top,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Finish setting up your account!",
                style: CustomFonts.titleLarge,
              ),
              20.kH,
              SelectableContainer(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 14,
                  bottom: 0,
                ),
                isSelected: isPersonalSelected,
                onTap: _handleSelectPersonal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Personal",
                            style: CustomFonts.titleMedium,
                          ),
                          4.kH,
                          const Text(
                            "You can help anyone and fundraise for yourself!",
                            style: CustomFonts.labelSmall,
                          )
                        ],
                      ),
                    ),
                    // const Spacer(),
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        "assets/images/home-banner-human-donate.png",
                        width: 140,
                        height: 140,
                      ),
                    ),
                  ],
                ),
              ),
              18.kH,
              SelectableContainer(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 14,
                  bottom: 0,
                ),
                isSelected: !isPersonalSelected,
                onTap: _handleSelectNPO,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "NPO / Charity",
                            style: CustomFonts.titleMedium,
                          ),
                          4.kH,
                          const Text(
                            "Fundraise with your team and help others together!",
                            style: CustomFonts.labelSmall,
                          )
                        ],
                      ),
                    ),
                    // const Spacer(),
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        "assets/images/bank.png",
                        width: 160,
                        height: 160,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: _handleNextPage,
                      child: const Text("Next"),
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
