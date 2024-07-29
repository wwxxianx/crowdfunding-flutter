import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/selectable_container.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/presentation/home/home_screen.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/npo_onboarding/join_npo_success_page.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/join_npo/join_npo_bloc.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/join_npo/join_npo_event.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/join_npo/join_npo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:toastification/toastification.dart';

class MatchedCodeNPOPage extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  const MatchedCodeNPOPage({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<MatchedCodeNPOPage> createState() => _MatchedCodeNPOPageState();
}

class _MatchedCodeNPOPageState extends State<MatchedCodeNPOPage> {
  bool isSelected = true;

  void _handleJoinOrganization(Organization organization) {
    if (!isSelected) {
      //
      toastification.show(
        title: Text("Please select your organization to join"),
        type: ToastificationType.success,
        primaryColor: CustomColors.accentGreen,
        autoCloseDuration: const Duration(seconds: 3),
        boxShadow: lowModeShadow,
      );
      return;
    }
    context.read<JoinNPOBloc>().add(
          OnJoinOrganization(
            organizationId: organization.id,
            onSuccess: () {
              context.go(
                JoinNPOSuccessScreen.generateRoute(
                  organizationId: organization.id,
                ),
                extra: organization,
              );
            },
          ),
        );
  }

  void _handleOnboardCompleteWithoutJoinNPO() {
    context
        .read<JoinNPOBloc>()
        .add(OnboardCompleteWithoutJoinNPO(onSuccess: () {
      context.go("/home");
    }));
  }

  Widget _buildContent(JoinNPOState state) {
    final organizationResult = state.searchOrganizationResult;
    if (organizationResult is ApiResultSuccess<Organization>) {
      final organization = organizationResult.data;
      if (organization.isVerified) {
        return _buildVerifiedContent(organization, state);
      }
      return _buildUnverifiedContent(organization, state);
    }

    // Loading
    return Column();
  }

  Widget _buildUnverifiedContent(
      Organization organization, JoinNPOState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: CustomColors.amber50,
            border: Border.all(color: CustomColors.amber500),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const HeroIcon(
                    HeroIcons.shieldCheck,
                    color: CustomColors.amber700,
                    style: HeroIconStyle.solid,
                    size: 20,
                  ),
                  4.kW,
                  Flexible(
                    child: Text(
                      "You can’t join into Bill Gates Foundation yet",
                      style: CustomFonts.labelSmall
                          .copyWith(color: CustomColors.amber700),
                    ),
                  ),
                ],
              ),
              6.kH,
              Text(
                "We’re still verifying the organization. You can join once it’s verified. Don’t worry, it won’t take too long.",
                style: CustomFonts.bodySmall
                    .copyWith(color: CustomColors.amber700),
              ),
              6.kH,
              Row(
                children: [
                  Avatar(
                    imageUrl: organization.imageUrl,
                    placeholder: organization.name[0],
                    size: 45,
                  ),
                  4.kW,
                  Text(
                    organization.name,
                    style: CustomFonts.labelMedium.copyWith(
                      color: CustomColors.amber700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                style: CustomButtonStyle.white,
                onPressed: widget.onPreviousPage,
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
                isLoading: state.joinOrganizationResult is ApiResultLoading,
                enabled: state.joinOrganizationResult is! ApiResultLoading,
                onPressed: _handleOnboardCompleteWithoutJoinNPO,
                child: const Text("OK, Continue to the app"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerifiedContent(Organization organization, JoinNPOState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Is this your NPO / Charity?",
          style: CustomFonts.titleLarge,
        ),
        12.kH,
        Text(
          "Please select your NPO / Charity",
          style: CustomFonts.labelMedium.copyWith(
            color: CustomColors.textGrey,
          ),
        ),
        8.kH,
        SelectableContainer(
          isSelected: isSelected,
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          child: Row(
            children: [
              Avatar(
                imageUrl: organization.imageUrl,
                placeholder: organization.name[0],
              ),
              12.kW,
              Text(
                organization.name,
                style: CustomFonts.titleMedium,
              ),
            ],
          ),
        ),
        24.kH,
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                style: CustomButtonStyle.white,
                onPressed: widget.onPreviousPage,
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
                isLoading: state.joinOrganizationResult is ApiResultLoading,
                enabled: state.joinOrganizationResult is! ApiResultLoading,
                onPressed: () {
                  _handleJoinOrganization(organization);
                },
                child: const Text("Next"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoinNPOBloc, JoinNPOState>(
      listener: (context, state) {
        final joinOrganizationResult = state.joinOrganizationResult;
        if (joinOrganizationResult is ApiResultFailure<UserModel>) {
          toastification.show(
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
            showProgressBar: true,
            applyBlurEffect: true,
            boxShadow: lowModeShadow,
            title: Text(
                joinOrganizationResult.errorMessage ?? "Something went wrong"),
          );
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
            child: _buildContent(state),
          ),
        );
      },
    );
  }
}
