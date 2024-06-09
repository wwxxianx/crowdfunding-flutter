import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/slide_route_transition.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/npo_onboarding/invite_team_code_page.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/npo_onboarding/organization_profile_page.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/npo_onboarding/organization_verify_page.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/create_npo/create_npo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrganizationPageView extends StatefulWidget {
  static const route = '/onboarding-create-organization';
  // static route() => SlideRoute(page: const CreateOrganizationPageView());
  // final VoidCallback onPreviousPage;
  const CreateOrganizationPageView({
    super.key,
    // required this.onPreviousPage,
  });

  @override
  State<CreateOrganizationPageView> createState() =>
      _CreateOrganizationPageViewState();
}

class _CreateOrganizationPageViewState
    extends State<CreateOrganizationPageView> {
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateNpoBloc(createOrganization: serviceLocator()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Pregress bar
                OnboardingProgressBar(
                  currentStep: currentPage,
                  totalStep: 3,
                ),
                24.kH,
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: _handlePageChange,
                    children: [
                      OrganizationVerifyPage(
                        onNextPage: _handleNextPage,
                      ),
                      OrganizationProfilePage(
                        onNextPage: _handleNextPage,
                        onPreviousPage: _handlePreviousPage,
                      ),
                      OnboardingNPOInviteTeamCodePage(),
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

class OnboardingProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalStep;
  const OnboardingProgressBar({
    super.key,
    required this.currentStep,
    required this.totalStep,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
      ),
      child: Row(
        children: [
          ...List.generate(
            totalStep,
            (index) => Flexible(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    margin: index != totalStep - 1
                        ? EdgeInsets.only(right: 8)
                        : null,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Color.fromARGB(255, 224, 224, 224),
                    ),
                  ),
                  AnimatedFractionallySizedBox(
                    duration: const Duration(milliseconds: 500),
                    widthFactor: currentStep >= index ? 1 : 0,
                    child: Container(
                      margin: index != totalStep - 1
                          ? EdgeInsets.only(right: 8)
                          : null,
                      height: 8,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xFF9DFF9D),
                          Color(0xFFE6FF82),
                        ]),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
