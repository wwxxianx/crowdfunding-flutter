import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/npo_onboarding/invite_team_code_page.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_bloc.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class InvitationCodeBottomSheet extends StatelessWidget {
  const InvitationCodeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditOrganizationBloc, EditOrganizationState>(
      builder: (context, state) {
        final organizationResult = state.organizationResult;
        final invitationCode =
            organizationResult is ApiResultSuccess<Organization>
                ? organizationResult.data.invitationCode
                : null;
        return CustomBottomSheet(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                  child:
                      InvitationCodeContainer(invitationCode: invitationCode)),
              4.kH,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeroIcon(
                    HeroIcons.informationCircle,
                    size: 20,
                  ),
                  4.kW,
                  Flexible(
                    child: Text(
                      'Use this invitation code to join your team seamlessly. Go to “account > my team > join a team > use invitation code”.',
                      style: CustomFonts.bodySmall,
                    ),
                  ),
                ],
              ),
              20.kH,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {},
                      child: Text("OK"),
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
