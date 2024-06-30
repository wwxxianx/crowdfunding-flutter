import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/container/fundraiser_identification_card.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/setup_bank_account_bottom_sheet.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PrerequisiteContent extends StatelessWidget {
  final String campaignId;
  const PrerequisiteContent({
    super.key,
    required this.campaignId,
  });

  void _showSetupBankAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      isDismissible: true,
      context: context,
      builder: (modalContext) {
        return SetupBankAccountBottomSheet();
      },
    );
  }

  void _navigateToIdentificationScreen(BuildContext context) {
    context.push(
        '/manage-campaign-details/${campaignId}/fundraiser-identification');
  }

  void _navigateToBankScreen(BuildContext context) {
    final campaignResult =
        context.read<CampaignDetailsBloc>().state.campaignResult;
    if (campaignResult is ApiResultSuccess<Campaign>) {
      final stripeConnectId = campaignResult.data.user.stripeConnectId;
      context.pushNamed('connected-bank-account',
          queryParameters: {'connectedAccountId': stripeConnectId});
      return;
    }
    // context.push('/connected-bank-account');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
      builder: (context, state) {
        final campaignResult = state.campaignResult;
        if (campaignResult is ApiResultSuccess<Campaign>) {
          return SizedBox(
            height: 165,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: FundraiserIdentificationCard(
                    onPressed: () {
                      _navigateToIdentificationScreen(context);
                    },
                    status: FundraiserIdentificationStatusEnum.values.byName(
                      campaignResult.data.fundraiserIdentificationStatus,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _navigateToBankScreen(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: CustomColors.containerBorderSlate),
                        boxShadow: CustomColors.containerSlateShadow),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/bank-transfer.svg'),
                            4.kW,
                            Text(
                              "Setup Your Back Account",
                              style: CustomFonts.labelSmall,
                            ),
                          ],
                        ),
                        6.kH,
                        Text(
                          'Before you receive any donation, please set up a valid bank account in order to receive donation.',
                          style: CustomFonts.bodySmall,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
