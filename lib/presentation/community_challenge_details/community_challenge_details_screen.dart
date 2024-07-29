import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/animated_bg_container.dart';
import 'package:crowdfunding_flutter/common/widgets/container/dialog.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/presentation/community_challenge_details/widgets/challenge_stepper.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge_details/community_challenge_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge_details/community_challenge_details_event.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge_details/community_challenge_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:toastification/toastification.dart';

class CommunityChallengeDetailsScreen extends StatelessWidget {
  final String id;
  const CommunityChallengeDetailsScreen({
    super.key,
    required this.id,
  });

  Widget _buildBottomSheet(BuildContext context) {
    final bloc = context.read<CommunityChallengeDetailsBloc>();
    final communityChallengeResult = bloc.state.communityChallengeResult;
    final challengeProgressResult = bloc.state.challengeProgressResult;
    if (bloc.state.isChallengeNotStarted) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CustomButton(
              isLoading: bloc.state.participateResult is ApiResultLoading,
              enabled: bloc.state.participateResult is! ApiResultLoading,
              onPressed: () {
                bloc.add(OnParticipateChallenge(communityChallengeId: id));
              },
              child: const Text('Accept Challenge'),
            ),
          ),
        ],
      );
    }
    if (communityChallengeResult is ApiResultSuccess<CommunityChallenge> &&
        challengeProgressResult is ApiResultSuccess<ChallengeParticipant>) {
      final challengeType = CommunityChallengeType.values
          .byName(communityChallengeResult.data.challengeType);
      final challengeProgress = challengeProgressResult.data;
      if (challengeType == CommunityChallengeType.PHOTO) {
        final canGetReward = (challengeProgress.rewardEmailId != null);
        return _buildBottomSheetRewardButton(context,
            user: challengeProgress.user, canCollectReward: canGetReward);
      }
      if (challengeType == CommunityChallengeType.DONATION) {
        return _buildBottomSheetRewardButton(context,
            user: challengeProgress.user,
            canCollectReward:
                challengeProgressResult.data.challengeIsSuccess ?? false);
      }
      // Can get reward
    }
    return const SizedBox();
  }

  Widget _buildBottomSheetRewardButton(
    BuildContext context, {
    required UserModel user,
    required bool canCollectReward,
  }) {
    if (canCollectReward) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CustomButton(
              onPressed: () {
                context.displayDialog(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Collect Challenge Reward!',
                        style: CustomFonts.titleMedium,
                      ),
                      12.kH,
                      Text(
                        'Reward has sent to your account email, ${user.email}, please check your mail inbox.',
                        style: CustomFonts.bodyMedium,
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Get my reward'),
            ),
          ),
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: CustomButton(
            backgroundColor: CustomColors.containerBorderGrey,
            enabled: false,
            onPressed: null,
            child: Text(
              'Get my reward',
              style: CustomFonts.titleMedium
                  .copyWith(color: Colors.black.withOpacity(0.4)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuidelines(
      ApiResult<CommunityChallenge> communityChallengeResult) {
    if (communityChallengeResult is ApiResultSuccess<CommunityChallenge>) {
      final challengeType = CommunityChallengeType.values
          .byName(communityChallengeResult.data.challengeType);
      switch (challengeType) {
        case CommunityChallengeType.DONATION:
          {
            return Text(communityChallengeResult.data.rule,
                style: CustomFonts.bodySmall);
          }
        case CommunityChallengeType.PHOTO:
          {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: communityChallengeResult.data.requirements.length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${(index + 1)}.",
                      style: CustomFonts.bodySmall,
                    ),
                    6.kW,
                    Flexible(
                      child: Text(
                          communityChallengeResult.data.requirements[index],
                          style: CustomFonts.bodySmall),
                    ),
                  ],
                );
              },
            );
          }
      }
    }
    return const SizedBox();
  }

  Widget _buildSponsorContent(
      ApiResult<CommunityChallenge> communityChallengeResult) {
    if (communityChallengeResult is ApiResultSuccess<CommunityChallenge>) {
      return Row(
        children: [
          Text(
            'Sponsored by:',
            style: CustomFonts.bodySmall.copyWith(
              color: CustomColors.textGrey,
            ),
          ),
          4.kW,
          Avatar(
            imageUrl: communityChallengeResult.data.sponsorImageUrl,
            placeholder: communityChallengeResult.data.sponsorName[0],
            size: 25,
          ),
          Text(communityChallengeResult.data.sponsorName),
        ],
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunityChallengeDetailsBloc(
        fetchCommunityChallenge: serviceLocator(),
        fetchChallengeProgress: serviceLocator(),
        createChallengeParticipant: serviceLocator(),
        updateChallengeParticipant: serviceLocator(),
      )
        ..add(OnFetchCommunityChallenge(id: id))
        ..add(OnFetchChallengeProgress(communityChallengeId: id)),
      child: BlocConsumer<CommunityChallengeDetailsBloc,
          CommunityChallengeDetailsState>(
        listener: (context, state) {
          final updateProgressResult = state.updateProgressResult;
          if (updateProgressResult is ApiResultFailure<ChallengeParticipant>) {
            toastification.show(
              type: ToastificationType.error,
              title: Text(
                  updateProgressResult.errorMessage ?? "Something went wrong"),
            );
          }
        },
        builder: (context, state) {
          // final communityChallengeResult = state.communityChallengeResult;
          final communityChallengeResult = context
              .read<CommunityChallengeDetailsBloc>()
              .state
              .communityChallengeResult;
          final challengeProgressResult = state.challengeProgressResult;
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<CommunityChallengeDetailsBloc>()
                  .add(OnRefreshChallengeProgress(communityChallengeId: id));
            },
            child: Scaffold(
              extendBodyBehindAppBar: true,
              bottomSheet: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.screenHorizontalPadding,
                    vertical: 8),
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal:
                        BorderSide(color: CustomColors.containerBorderGrey),
                  ),
                ),
                child: _buildBottomSheet(context),
              ),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton.filled(
                  color: Colors.black,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.white.withOpacity(0.6)),
                  ),
                  icon: const HeroIcon(
                    HeroIcons.arrowLeft,
                    size: 20,
                    style: HeroIconStyle.mini,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: Dimensions.bottomActionBarHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1.35 / 1,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: communityChallengeResult
                                  is ApiResultSuccess<CommunityChallenge>
                              ? communityChallengeResult.data.imageUrl
                              : '',
                          placeholder: (context, url) {
                            return Skeleton();
                          },
                          errorWidget: (context, url, error) {
                            return Skeleton();
                          },
                        ),
                      ),
                      12.kH,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.screenHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSponsorContent(communityChallengeResult),
                            8.kH,
                            Text(
                              'Expires on 2020/19/09',
                              style: CustomFonts.bodySmall.copyWith(
                                color: CustomColors.textGrey,
                              ),
                            ),
                            12.kH,
                            if (communityChallengeResult
                                is ApiResultSuccess<CommunityChallenge>)
                              Text(
                                communityChallengeResult.data.title,
                                style: CustomFonts.titleLarge,
                              ),
                            4.kH,
                            if (communityChallengeResult
                                is ApiResultSuccess<CommunityChallenge>)
                              Text(
                                communityChallengeResult.data.description,
                                style: CustomFonts.labelMedium,
                              ),
                            8.kH,
                            AnimatedBGContainer(
                              startColor: const Color(0xFFF1FAEA),
                              endColor: const Color(0xFFB7FF87),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.black),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/confetti.svg'),
                                      6.kW,
                                      Text(
                                        'Final Rewards!',
                                        style: CustomFonts.titleMedium.copyWith(
                                          color: const Color(0xFF335B17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  6.kH,
                                  if (communityChallengeResult
                                      is ApiResultSuccess<CommunityChallenge>)
                                    Text(
                                      communityChallengeResult.data.reward,
                                      style: CustomFonts.labelSmall.copyWith(
                                        color: const Color(0xFF335B17),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            12.kH,
                            ChallengeStepper(),
                            20.kH,
                            const Text(
                              'How it works?',
                              style: CustomFonts.labelMedium,
                            ),
                            8.kH,
                            _buildGuidelines(communityChallengeResult),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
