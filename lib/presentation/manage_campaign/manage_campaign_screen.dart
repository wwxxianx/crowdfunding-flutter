import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_loading_card.dart';
import 'package:crowdfunding_flutter/common/widgets/container/chip.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/enum/campaign_enum.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/create_campaign_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/manage_campaign_details_screen.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/my_campaign/my_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/my_campaign/my_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/my_campaign/my_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class ManageCampaignScreen extends StatelessWidget {
  static const route = 'manage-campaigns';
  const ManageCampaignScreen({super.key});

  Widget _buildContent(ApiResult<List<Campaign>> myCampaignResult) {
    if (myCampaignResult is ApiResultLoading ||
        myCampaignResult is ApiResultInitial) {
      return CampaignLoadingCard();
    }
    if (myCampaignResult is ApiResultSuccess<List<Campaign>>) {
      if (myCampaignResult.data.isEmpty) {
        // Empty state
        return Column(
          children: [
            SvgPicture.asset("assets/images/empty-illustration.svg"),
            16.kH,
            const Text(
              "Seems like you have not created any fundraiser yet!",
              style: CustomFonts.labelLarge,
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: myCampaignResult.data.length,
        itemBuilder: (context, index) {
          final campaign = myCampaignResult.data[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: CampaignCard(
              campaign: campaign,
              onPressed: () {
                context.push(ManageCampaignDetailsScreen.generateRoute(
                    campaignId: myCampaignResult.data[index].id));
              },
              headerLeadingTag: CustomChip(
                style: campaign.statusEnum.chipStyle,
                child: Text(campaign.statusEnum.displayTitle),
              ),
            ),
          );
        },
      );
    }
    if (myCampaignResult is ApiResultFailure) {
      return Text("Something went wrong");
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final appUserState = context.read<AppUserCubit>().state;
        String userId = '';
        if (appUserState.currentUser != null) {
          userId = appUserState.currentUser!.id;
        }
        return MyCampaignBloc(fetchCampaigns: serviceLocator())
          ..add(OnFetchMyCampaign(userId));
      },
      child: BlocBuilder<MyCampaignBloc, MyCampaignState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              foregroundColor: CustomColors.primaryGreen,
              shape: const CircleBorder(),
              onPressed: () {
                context.push(CreateCampaignScreen.route);
              },
              child: const HeroIcon(HeroIcons.plus),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.screenHorizontalPadding,
                  right: Dimensions.screenHorizontalPadding,
                  top: Dimensions.screenHorizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your fundraisers",
                      style: CustomFonts.titleMedium,
                    ),
                    24.kH,
                    _buildContent(state.myCampaignsResult),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
