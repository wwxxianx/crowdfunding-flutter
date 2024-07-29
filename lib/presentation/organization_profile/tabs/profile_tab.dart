import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/presentation/organization_profile/widgets/organization_bank_account_bottom_sheet.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrganizationProfileTabContent extends StatelessWidget {
  const OrganizationProfileTabContent({super.key});

  void _showOrganizationBankAccountBottomSheet(BuildContext context) {
    final organizationResult =
        context.read<OrganizationProfileBloc>().state.organizationResult;
    if (organizationResult is ApiResultSuccess<Organization>) {
      showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        elevation: 0,
        builder: (modalContext) {
          return BlocProvider.value(
            value: BlocProvider.of<OrganizationProfileBloc>(context),
            child: OrganizationBankAccuontBottomSheet(
                connectedAccountId: organizationResult.data.bankAccount?.id),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.screenHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _showOrganizationBankAccountBottomSheet(context);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: CustomColors.containerBorderSlate),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/bank-transfer.svg'),
                      6.kW,
                      Text(
                        "Organization Bank Account",
                        style: CustomFonts.titleMedium,
                      ),
                    ],
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
