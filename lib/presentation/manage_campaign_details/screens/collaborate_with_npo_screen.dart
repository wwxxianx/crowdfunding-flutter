import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/cancel_collaboration_sheet.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/reward_bottom_sheet.dart';
import 'package:crowdfunding_flutter/state_management/campaign_collaboration/campaign_collaboration_bloc.dart';
import 'package:crowdfunding_flutter/state_management/campaign_collaboration/campaign_collaboration_event.dart';
import 'package:crowdfunding_flutter/state_management/campaign_collaboration/campaign_collaboration_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:toastification/toastification.dart';

class CollaborateWithNPOScreen extends StatelessWidget {
  final String campaignId;
  static const route = '/collaborate-with-npo/:campaignId';
  static generateRoute({required String campaignId}) =>
      '/collaborate-with-npo/$campaignId';
  const CollaborateWithNPOScreen({
    super.key,
    required this.campaignId,
  });

  Widget _buildPendingCard(Collaboration collaboration) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: CustomColors.slate100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Waiting for help...',
            style:
                CustomFonts.labelMedium.copyWith(color: CustomColors.slate700),
          ),
          2.kH,
          Text(
            'We’ve sent your help request to the community. Once a team decided to help you, you’ll receive an update!',
            style: CustomFonts.bodySmall.copyWith(color: CustomColors.slate700),
          ),
          6.kH,
          _buildRewardTag(collaboration.reward),
        ],
      ),
    );
  }

  Widget _buildActiveCard(BuildContext context, Collaboration collaboration) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: CustomColors.containerLightGreen,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: CustomColors.textBlack),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(
                imageUrl: collaboration.organization?.imageUrl,
                placeholder: 'A',
                size: 45,
                border: Border.all(color: Colors.black),
              ),
              8.kW,
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                      text: collaboration.organization?.name,
                      style: CustomFonts.titleSmall.copyWith(
                        color: CustomColors.textDarkGreen,
                        decoration: TextDecoration.underline,
                      ),
                      children: [
                        TextSpan(
                          text:
                              ' now share the same responsibilities of organizing and managing your fundraiser.',
                          style: CustomFonts.bodySmall.copyWith(
                            color: CustomColors.textDarkGreen,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          8.kH,
          _buildRewardTag(collaboration.reward),
          8.kH,
          Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: CustomButton(
                  borderRadius: BorderRadius.circular(4),
                  onPressed: () {},
                  style: CustomButtonStyle.white,
                  child: const Text(
                    'Update Reward',
                    style: CustomFonts.labelSmall,
                  ),
                ),
              ),
              8.kH,
              SizedBox(
                width: double.maxFinite,
                child: CustomButton(
                  borderRadius: BorderRadius.circular(4),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      elevation: 0,
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return CancelCollaborationBottomSheet();
                      },
                    );
                  },
                  style: CustomButtonStyle.white,
                  border: Border.all(color: CustomColors.alert),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeroIcon(
                        HeroIcons.xCircle,
                        style: HeroIconStyle.solid,
                        size: 20,
                        color: CustomColors.alert,
                      ),
                      4.kW,
                      Text(
                        'Cancel Collaboration',
                        style: CustomFonts.labelSmall
                            .copyWith(color: CustomColors.alert),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCancelCard(Collaboration collaboration) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: CustomColors.alert.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: CustomColors.textBlack),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(
                imageUrl: collaboration.organization?.imageUrl,
                placeholder: 'A',
                size: 45,
                border: Border.all(color: Colors.black),
              ),
              8.kW,
              Expanded(
                child: Text(
                  'You cancelled the collaboration with ${collaboration.organization?.name}',
                  style: CustomFonts.bodySmall.copyWith(
                    color: CustomColors.alert,
                  ),
                ),
              ),
            ],
          ),
          8.kH,
          Text(
            'Reason: ${collaboration.cancellationReason ?? 'No reason provided'}',
            style: CustomFonts.labelSmall.copyWith(
              color: CustomColors.alert,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollaborationContent(BuildContext context) {
    final campaignCollaborationResult = context
        .read<CampaignCollaborationBloc>()
        .state
        .campaignCollaborationResult;
    if (campaignCollaborationResult is ApiResultSuccess<Collaboration>) {
      if (campaignCollaborationResult.data.organization == null) {
        // No organization help yet
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Status",
              style: CustomFonts.labelMedium,
            ),
            8.kH,
            _buildPendingCard(campaignCollaborationResult.data),
          ],
        );
      }
      if (campaignCollaborationResult.data.isCancelled) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Status",
              style: CustomFonts.labelMedium,
            ),
            8.kH,
            _buildCancelCard(campaignCollaborationResult.data),
          ],
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Status",
            style: CustomFonts.labelMedium,
          ),
          8.kH,
          _buildActiveCard(context, campaignCollaborationResult.data),
        ],
      );
    }
    return SizedBox();
  }

  Widget _buildRewardTag(double reward) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFD7FFE2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFBCECD3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/icons/percent-tag.svg'),
          4.kW,
          RichText(
            text: TextSpan(
              text: 'Share',
              style: CustomFonts.bodySmall.copyWith(
                color: CustomColors.textDarkGreen,
              ),
              children: [
                TextSpan(
                  text: ' ${(reward * 100).toStringAsFixed(0)}% ',
                  style: CustomFonts.labelSmall.copyWith(
                    color: CustomColors.textDarkGreen,
                  ),
                ),
                TextSpan(
                  text: 'of received donation',
                  style: CustomFonts.bodySmall.copyWith(
                    color: CustomColors.textDarkGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomAction(BuildContext context) {
    final campaignCollaborationState =
        context.watch<CampaignCollaborationBloc>().state;
    final campaignCollaborationResult =
        campaignCollaborationState.campaignCollaborationResult;
    if (campaignCollaborationState.isCollarationNull) {
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext modalContext) {
                    return BlocProvider.value(
                      value:
                          BlocProvider.of<CampaignCollaborationBloc>(context),
                      child: RewardBottomSheet(
                        campaignId: campaignId,
                      ),
                    );
                  },
                );
              },
              child: const Text("Send my help request"),
            ),
          ),
        ],
      );
    }
    if (campaignCollaborationResult is ApiResultSuccess<Collaboration>) {
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext modalContext) {
                    return BlocProvider.value(
                      value:
                          BlocProvider.of<CampaignCollaborationBloc>(context),
                      child: RewardBottomSheet(
                        isUpdate: true,
                        campaignId: campaignId,
                      ),
                    );
                  },
                );
              },
              child: const Text("Update my help request"),
            ),
          ),
        ],
      );
    }
    if (campaignCollaborationResult is ApiResultFailure<Collaboration>) {
      return Text(
          campaignCollaborationResult.errorMessage ?? "Something went wrong");
    }
    return Text("Nothing");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CampaignCollaborationBloc(
          fetchCollaborations: serviceLocator(),
          createCampaignCollaboration: serviceLocator(),
          updateCampaignCollaboration: serviceLocator(),
        )..add(OnFetchCampaignCollaboration(
            campaignId: campaignId,
          ));
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Collaborate",
            style: CustomFonts.labelMedium,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.screenHorizontalPadding,
              right: Dimensions.screenHorizontalPadding,
              bottom: Dimensions.screenHorizontalPadding,
            ),
            child: BlocConsumer<CampaignCollaborationBloc,
                CampaignCollaborationState>(
              listener: (context, state) {
                final campaignCollaborationResult =
                    state.campaignCollaborationResult;
                if (campaignCollaborationResult
                    is ApiResultFailure<Collaboration>) {
                  toastification.show(
                    type: ToastificationType.error,
                    autoCloseDuration: const Duration(seconds: 7),
                    title: Text(campaignCollaborationResult.errorMessage ??
                        "Something went wrong"),
                    showProgressBar: true,
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info header
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: CustomColors.containerBorderGrey),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/smile-emoji.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                          4.kW,
                          const Flexible(
                            child: Text(
                              "Don’t know how to manage your fundraiser and reach to more donors? Our community can help you!",
                              style: CustomFonts.bodyExtraSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.kH,
                    Text(
                      "How it works?",
                      style: CustomFonts.titleMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: CustomColors.containerBorderGrey),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/images/collaboration.svg'),
                          20.kH,
                          Text(
                            "The team will share the responsibilities of organizing and managing your fundraiser.",
                            textAlign: TextAlign.center,
                            style: CustomFonts.labelMedium,
                          ),
                          8.kH,
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/check-circle.svg'),
                              4.kW,
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    text: '3x ',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: CustomColors.textBlack),
                                    children: [
                                      TextSpan(
                                        text: 'your campaign performance',
                                        style: CustomFonts.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          4.kH,
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/check-circle.svg'),
                              4.kW,
                              const Flexible(
                                child: Text(
                                  'Share your campaign to reach to more donors',
                                  style: CustomFonts.bodySmall,
                                ),
                              ),
                            ],
                          ),
                          4.kH,
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/check-circle.svg'),
                              4.kW,
                              const Flexible(
                                child: Text(
                                  'Help to post campaign update to engage donors',
                                  style: CustomFonts.bodySmall,
                                ),
                              ),
                            ],
                          ),
                          4.kH,
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/check-circle.svg'),
                              4.kW,
                              const Flexible(
                                child: Text(
                                  'Manage your campaign data to make it more better',
                                  style: CustomFonts.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    12.kH,
                    _buildCollaborationContent(context),
                    24.kH,
                    buildBottomAction(context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
