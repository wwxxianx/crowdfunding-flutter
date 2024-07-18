import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/state_management/user_donations/user_donations_bloc.dart';
import 'package:crowdfunding_flutter/state_management/user_donations/user_donations_event.dart';
import 'package:crowdfunding_flutter/state_management/user_donations/user_donations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class MyDonationsScreen extends StatelessWidget {
  static const route = "/account/donation";
  const MyDonationsScreen({super.key});

  Widget _buildContent(BuildContext context) {
    final bloc = context.read<UserDonationsBloc>();
    final userDonationsResult = bloc.state.userDonationsResult;
    if (userDonationsResult is ApiResultSuccess<List<CampaignDonation>>) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: userDonationsResult.data.length,
          itemBuilder: (context, index) {
            final userDonation = userDonationsResult.data[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: CustomColors.containerBorderSlate, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Flexible(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                imageUrl:
                                    userDonation.campaign?.thumbnailUrl ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        8.kW,
                        Flexible(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userDonation.campaign?.title ?? "",
                                style: CustomFonts.labelMedium,
                              ),
                              6.kH,
                              Text(
                                userDonation.displayAmount,
                                style: CustomFonts.labelMedium,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  12.kH,
                  // Date
                  Transform.translate(
                    offset: const Offset(1, 1),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                          border: Border.all(
                            color: CustomColors.containerBorderSlate,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HeroIcon(
                              HeroIcons.calendar,
                              size: 20,
                              color: CustomColors.slate700,
                            ),
                            4.kW,
                            Text(
                              userDonation.createdAt.toISODate(),
                              style: CustomFonts.labelSmall
                                  .copyWith(color: CustomColors.slate700),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    if (userDonationsResult is ApiResultLoading) {
      return CircularProgressIndicator();
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDonationsBloc(
        fetchUserDonations: serviceLocator(),
        fetchTaxReceipt: serviceLocator(),
      )..add(OnFetchUserDonations()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Donations",
            style: CustomFonts.titleMedium,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<UserDonationsBloc, UserDonationsState>(
          builder: (context, state) {
            return _buildContent(context);
          },
        ),
      ),
    );
  }
}
