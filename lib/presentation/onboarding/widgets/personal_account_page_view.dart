import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/personal_onboarding/campaign_preference_page.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/personal_onboarding/setup_profile_page.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/create_organization_page_view.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/personal_onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class OnboardingPersonalProfileScreen extends StatefulWidget {
  static const route = '/onboarding-personal';
  // static route() => SlideRoute(page: const OnboardingPersonalProfileScreen());
  const OnboardingPersonalProfileScreen({
    super.key,
  });

  @override
  State<OnboardingPersonalProfileScreen> createState() =>
      _OnboardingPersonalProfileScreenState();
}

class _OnboardingPersonalProfileScreenState
    extends State<OnboardingPersonalProfileScreen> {
  int currentPage = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _handlePageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void _handleNextPage() {
    setState(() {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    });
  }

  void _handlePreviousPage() {
    setState(() {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    });
  }

  void _handleBackButtonPressed() {
    if (currentPage == 0) {
      Navigator.pop(context);
      return;
    }
    _handlePreviousPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PersonalOnboardingBloc(updateUserProfile: serviceLocator()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pregress bar
                OnboardingProgressBar(
                  currentStep: currentPage,
                  totalStep: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: Dimensions.screenHorizontalPadding,
                    top: 16,
                  ),
                  child: InkWell(
                    onTap: _handleBackButtonPressed,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HeroIcon(
                          HeroIcons.arrowLeft,
                          style: HeroIconStyle.mini,
                          size: 20,
                          color: CustomColors.textGrey,
                        ),
                        6.kW,
                        Text(
                          "Back",
                          style: CustomFonts.labelMedium.copyWith(
                            color: CustomColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                16.kH,
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: _handlePageChange,
                    children: [
                      OnboardingPersonalProfilePage(
                        onNextPage: _handleNextPage,
                      ),
                      OnboardingCampaignPreferencePage(
                        onPreviousPage: _handlePreviousPage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
