import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/media_picker.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:crowdfunding_flutter/presentation/community_challenge_details/widgets/custom_stepper.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge_details/community_challenge_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge_details/community_challenge_details_event.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge_details/community_challenge_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class ChallengeStepper extends StatelessWidget {
  const ChallengeStepper({super.key});

  Widget _buildPhotoStepper(
    BuildContext context,
    CommunityChallenge communityChallenge,
    ChallengeParticipant challengeProgress,
  ) {
    final bloc = context.read<CommunityChallengeDetailsBloc>();

    int _getCurrentStep() {
      if (challengeProgress.metadata?['imageUrl'] != null &&
          challengeProgress.rewardEmailId != null) {
        // Reward sent
        return 4;
      }
      if (challengeProgress.rejectReason != null) {
        // Rejected
        return 2;
      }
      if (challengeProgress.metadata?['imageUrl'] != null) {
        // Reward pending OR verifying
        return 3;
      }
      return 2;
    }

    return CustomStepper(
      currentStep: _getCurrentStep(),
      steps: <CustomStep>[
        const CustomStep(
          title: Text(
            'Challenge begin',
            style: CustomFonts.labelSmall,
          ),
        ),
        CustomStep(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                communityChallenge.rule,
                style: CustomFonts.labelSmall,
              ),
              8.kH,
              if (challengeProgress.rejectReason != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: CustomColors.red100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const HeroIcon(
                            HeroIcons.exclamationTriangle,
                            style: HeroIconStyle.mini,
                            color: CustomColors.alert,
                            size: 18,
                          ),
                          4.kW,
                          Text(
                            'Please upload a valid photo',
                            style: CustomFonts.labelExtraSmall
                                .copyWith(color: CustomColors.alert),
                          ),
                        ],
                      ),
                      2.kH,
                      Text(
                        "Rejected: ${challengeProgress.rejectReason}",
                        style: CustomFonts.labelExtraSmall
                            .copyWith(color: CustomColors.alert),
                      ),
                    ],
                  ),
                ),
              if (challengeProgress.rejectReason != null) 8.kH,
              MediaPicker(
                limit: 1,
                // Reward sended, don't allow image remove
                canRemove: challengeProgress.rewardEmailId == null,
                previewImageUrls:
                    challengeProgress.metadata?['imageUrl'] != null
                        ? [challengeProgress.metadata?['imageUrl']]
                        : [],
                onSelected: (files) {
                  if (challengeProgress.rewardEmailId != null) {
                    return;
                  }
                  final imageFile = files.first;
                  bloc.add(OnChallengeImageFileChanged(imageFile: imageFile));
                },
              ),
              8.kH,
              CustomButton(
                isLoading: bloc.state.updateProgressResult is ApiResultLoading,
                enabled: challengeProgress.rewardEmailId == null &&
                    bloc.state.updateProgressResult is! ApiResultLoading,
                height: 40,
                onPressed: () {
                  bloc.add(
                    OnUpdateChallengeProgress(
                        communityChallengeId: communityChallenge.id),
                  );
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
        const CustomStep(
          title: Text(
            "Your photo is being verified. Don't worry, it won't take too long.",
            style: CustomFonts.labelSmall,
          ),
        ),
        const CustomStep(
          title: Text(
            'Get your rewards!',
            style: CustomFonts.labelSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildDonationStepper(CommunityChallenge communityChallenge,
      ChallengeParticipant challengeProgress) {
    return CustomStepper(
      currentStep: challengeProgress.challengeIsSuccess == true ? 3 : 1,
      steps: <CustomStep>[
        const CustomStep(
          title: Text(
            'Challenge begin',
            style: CustomFonts.labelSmall,
          ),
        ),
        CustomStep(
          title: Text(
            communityChallenge.displayRule,
            style: CustomFonts.labelSmall,
          ),
        ),
        const CustomStep(
          title: Text(
            'Get your rewards!',
            style: CustomFonts.labelSmall,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityChallengeDetailsBloc,
        CommunityChallengeDetailsState>(
      builder: (context, state) {
        final communityChallengeResult = state.communityChallengeResult;
        final challengeProgressResult = state.challengeProgressResult;
        if (communityChallengeResult is ApiResultSuccess<CommunityChallenge> &&
            challengeProgressResult is ApiResultSuccess<ChallengeParticipant>) {
          final challengeType = CommunityChallengeType.values
              .byName(communityChallengeResult.data.challengeType);
          switch (challengeType) {
            case CommunityChallengeType.PHOTO:
              {
                return _buildPhotoStepper(
                    context,
                    communityChallengeResult.data,
                    challengeProgressResult.data);
              }
            case CommunityChallengeType.DONATION:
              {
                return _buildDonationStepper(communityChallengeResult.data,
                    challengeProgressResult.data);
              }
            default:
          }
        }
        return SizedBox();
      },
    );
  }
}
