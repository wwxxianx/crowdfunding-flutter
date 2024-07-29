import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/show_snackbar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/campaign_category_toggle_button.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/presentation/home/home_screen.dart';
import 'package:crowdfunding_flutter/presentation/navigation/navigation_screen.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/personal_onboarding_bloc.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/personal_onboarding_event.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/personal_onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingCampaignPreferencePage extends StatefulWidget {
  final VoidCallback onPreviousPage;
  const OnboardingCampaignPreferencePage({
    super.key,
    required this.onPreviousPage,
  });

  @override
  State<OnboardingCampaignPreferencePage> createState() =>
      _OnboardingCampaignPreferencePageState();
}

class _OnboardingCampaignPreferencePageState
    extends State<OnboardingCampaignPreferencePage> {
  void _handleSelectCategory(String categoryId) {
    context
        .read<PersonalOnboardingBloc>()
        .add(OnSelectCategories(categoryId: categoryId));
  }

  void _handleUpdateProfile() {
    context.read<PersonalOnboardingBloc>().add(OnUpdateProfile(onSuccess: () {
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   NavigationScreen.route(),
      //   (route) => false,
      // );
      context.go("/home");
    }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalOnboardingBloc, PersonalOnboardingState>(
      listener: (context, state) {
        if (state.updateProfileError != null) {
          context.showSnackBar("${state.updateProfileError}");
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            widget.onPreviousPage();
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      "We can’t help everyone,\nbut everyone can help someone",
                      style: CustomFonts.titleLarge,
                    ),
                  ],
                ),
                4.kH,
                const Text(
                  "Choose your desired campaign to help more!",
                  style: CustomFonts.labelSmall,
                ),
                28.kH,
                CampaignCategoryList(
                  onPressed: (campaignCategory) {
                    _handleSelectCategory(campaignCategory.id);
                  },
                  selectedCategoryIds: state.selectedCategoriesId,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        style: CustomButtonStyle.white,
                        onPressed: _handleUpdateProfile,
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
                        isLoading: state.isUpdatingProfile,
                        enabled: !state.isUpdatingProfile,
                        onPressed: _handleUpdateProfile,
                        child: const Text("Done"),
                        // isLoading: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
