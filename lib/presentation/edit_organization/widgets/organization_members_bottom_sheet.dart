import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/presentation/edit_organization/edit_organization_screen.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_bloc.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizationMembersBottomSheet extends StatelessWidget {
  const OrganizationMembersBottomSheet({super.key});

  Widget _buildMemberList(ApiResult<List<UserModel>> membersResult) {
    if (membersResult is ApiResultSuccess<List<UserModel>>) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: membersResult.data.length,
        itemBuilder: (context, index) {
          return MemberItem(user: membersResult.data[index]);
        },
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Skeleton(
          width: 200,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      contentAlignment: Alignment.topCenter,
      child: BlocBuilder<EditOrganizationBloc, EditOrganizationState>(
        builder: (context, state) {
          final membersResult = state.membersResult;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your team members",
                style: CustomFonts.labelMedium,
              ),
              12.kH,
              _buildMemberList(membersResult),
            ],
          );
        },
      ),
    );
  }
}
