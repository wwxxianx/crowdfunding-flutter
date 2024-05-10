import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/slide_route_transition.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/selectable_container.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/create_organization_page_view.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/join_with_code_page_view.dart';
import 'package:flutter/material.dart';

class OnboardingSelectNPOJoinMethodScreen extends StatefulWidget {
  static route() =>
      SlideRoute(page: const OnboardingSelectNPOJoinMethodScreen());
  const OnboardingSelectNPOJoinMethodScreen({
    super.key,
  });

  @override
  State<OnboardingSelectNPOJoinMethodScreen> createState() =>
      _OnboardingSelectNPOJoinMethodScreenState();
}

class _OnboardingSelectNPOJoinMethodScreenState
    extends State<OnboardingSelectNPOJoinMethodScreen> {
  bool isUseCodeSelected = false;

  void _handleSelectUseCode() {
    setState(() {
      isUseCodeSelected = true;
    });
  }

  void _handleSelectCreateNewNPO() {
    setState(() {
      isUseCodeSelected = false;
    });
  }

  void _handleNextPage() {
    if (isUseCodeSelected) {
      Navigator.push(context, JoinWithCodePageView.route());
    } else {
      Navigator.push(context, CreateOrganizationPageView.route());
    }
  }

  void _handlePreviousPage() {
    Navigator.pop(context);
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
                "Do you have your NPO invitation code?",
                style: CustomFonts.titleLarge,
              ),
              const Text(
                "You can use invitation code to join existing NPO account",
                style: CustomFonts.labelSmall,
              ),
              20.kH,
              Row(
                children: [
                  Expanded(
                    child: SelectableContainer(
                      isSelected: !isUseCodeSelected,
                      onTap: _handleSelectCreateNewNPO,
                      child: Text(
                        "No. I want to create a new NPO account",
                        style: CustomFonts.labelMedium,
                      ),
                    ),
                  ),
                ],
              ),
              18.kH,
              Row(
                children: [
                  Expanded(
                    child: SelectableContainer(
                      isSelected: isUseCodeSelected,
                      onTap: _handleSelectUseCode,
                      child: Text(
                        "Yes. I want to use invitation code",
                        style: CustomFonts.labelMedium,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      style: CustomButtonStyle.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Back"),
                    ),
                  ),
                ],
              ),
              8.kH,
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
