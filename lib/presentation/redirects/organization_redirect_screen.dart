import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/onboarding_select_npo_join_method_screen.dart';
import 'package:crowdfunding_flutter/presentation/organization_profile/organization_profile_screen.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrganizationRedirectScreen extends StatelessWidget {
  static const route = '/redirect/organization';
  const OrganizationRedirectScreen({super.key});

  Widget _buildContent(BuildContext context) {
    final userProfileResult =
        context.read<AppUserCubit>().state.userProfileResult;
    if (userProfileResult is ApiResultSuccess<UserModel> &&
        userProfileResult.data.organization == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.screenHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Looks like you haven't join any organization yet",
              style: CustomFonts.labelLarge,
              textAlign: TextAlign.center,
            ),
            16.kH,
            CustomButton(
              onPressed: () {
                context
                    .pushReplacement(OnboardingSelectNPOJoinMethodScreen.route);
                return;
              },
              child: Text("Yes, I want join"),
            ),
          ],
        ),
      );
    }
    return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppUserCubit, AppUserState>(
      bloc: serviceLocator<AppUserCubit>()..fetchCurrentUserProfile(),
      listener: (context, state) {
        final userProfileResult = state.userProfileResult;
        if (userProfileResult is ApiResultSuccess<UserModel>) {
          if (userProfileResult.data.organization != null) {
            context.go(OrganizationProfileScreen.generateRoute(
                organizationId: userProfileResult.data.organization!.id));
            return;
          }
        }
      },
      builder: (context, state) {
        final userProfileResult = state.userProfileResult;
        return Scaffold(
          appBar: (userProfileResult is ApiResultSuccess<UserModel> &&
                  userProfileResult.data.organization == null)
              ? AppBar(
                  title: Text(
                    "Join Organization",
                    style: CustomFonts.titleMedium,
                  ),
                )
              : null,
          body: SafeArea(
            child: Center(
              child: _buildContent(context),
            ),
          ),
        );
      },
    );
  }
}
