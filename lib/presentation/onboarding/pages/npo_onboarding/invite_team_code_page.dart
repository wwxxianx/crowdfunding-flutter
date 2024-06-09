import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/response/create_organization_response.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/npo_onboarding/join_npo_success_page.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/create_npo/create_npo_bloc.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/create_npo/create_npo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:toastification/toastification.dart';

class OnboardingNPOInviteTeamCodePage extends StatelessWidget {
  const OnboardingNPOInviteTeamCodePage({super.key});

  void _navigateToSuccessPage(BuildContext context) {
    final createOrganizationResult =
        context.read<CreateNpoBloc>().state.createOrganizationResult;
    if (createOrganizationResult is ApiResultSuccess<UserModel>) {
      final userOrganization = createOrganizationResult.data.organization;
      if (userOrganization == null) {
        context.go(
          JoinNPOSuccessScreen.generateRoute(
            organizationId: '',
          ),
          extra: userOrganization,
        );
        return;
      }
      context.go(
        JoinNPOSuccessScreen.generateRoute(
          organizationId: userOrganization.id,
        ),
        extra: userOrganization,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNpoBloc, CreateNpoState>(
      builder: (context, state) {
        final createOrganizationResult = state.createOrganizationResult;
        final String? invitationCode =
            createOrganizationResult is ApiResultSuccess<UserModel>
                ? createOrganizationResult.data.organization?.invitationCode
                : null;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/organization-filled.svg"),
                  4.kW,
                  const Text(
                    "Invite your team!",
                    style: CustomFonts.titleLarge,
                  ),
                ],
              ),
              const Text(
                "Share the invitation code with your team to join.",
                style: CustomFonts.labelSmall,
              ),
              30.kH,
              InvitationCodeContainer(
                invitationCode: invitationCode,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        _navigateToSuccessPage(context);
                      },
                      child: const Text("Done"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class InvitationCodeContainer extends StatelessWidget {
  final String? invitationCode;
  const InvitationCodeContainer({
    super.key,
    required this.invitationCode,
  });

  void _handleCopyCode() {
    if (invitationCode == null) {
      return;
    }
    Clipboard.setData(ClipboardData(text: invitationCode!)).then((_) {
      toastification.show(
        title: Text("Copied to clipboard!"),
        description: Text("You can send the code to your team members now!"),
        type: ToastificationType.success,
        primaryColor: CustomColors.accentGreen,
        autoCloseDuration: const Duration(seconds: 3),
        boxShadow: lowModeShadow,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Invitation code", style: CustomFonts.labelSmall),
        4.kH,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              if (invitationCode == null)
                const Skeleton(
                  width: 100,
                  height: Dimensions.loadingBodyHeight,
                ),
              if (invitationCode != null)
                Text(
                  invitationCode!,
                  style: CustomFonts.labelSmall,
                ),
              const Spacer(),
              CustomButton(
                borderRadius: BorderRadius.circular(4),
                style: CustomButtonStyle.black,
                height: 32,
                onPressed: _handleCopyCode,
                child: Row(
                  children: [
                    const Icon(
                      Symbols.content_copy_rounded,
                      color: CustomColors.primaryGreen,
                      size: 16,
                    ),
                    2.kW,
                    Text(
                      "Copy",
                      style: CustomFonts.labelExtraSmall
                          .copyWith(color: CustomColors.primaryGreen),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
