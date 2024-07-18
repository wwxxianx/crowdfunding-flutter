import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:crowdfunding_flutter/presentation/community_challenge/widgets/challenge_card.dart';
import 'package:crowdfunding_flutter/presentation/community_challenge/widgets/participated_challenge_list.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge/community_challenge_bloc.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge/community_challenge_event.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge/community_challenge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ExploreCommunityChallengeScreen extends StatelessWidget {
  const ExploreCommunityChallengeScreen({super.key});

  Widget _buildCommunityChallengesList(
      ApiResult<List<CommunityChallenge>> communityChallengesResult) {
    if (communityChallengesResult
        is ApiResultSuccess<List<CommunityChallenge>>) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: communityChallengesResult.data.length,
        itemBuilder: (context, index) {
          final communityChallenge = communityChallengesResult.data[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: CommunityChallengeCard(
              communityChallenge: communityChallenge,
              onPressed: () {
                context.push('/community-challenges/${communityChallenge.id}');
              },
            ),
          );
        },
      );
    }
    // Error
    if (communityChallengesResult
        is ApiResultFailure<List<CommunityChallenge>>) {
      return Text(communityChallengesResult.errorMessage ??
          'Failed to fetch challenges');
    }

    // Loading
    return Text('Loading...');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunityChallengeBloc(
        fetchCommunityChallenges: serviceLocator(),
        fetchParticipatedChallenges: serviceLocator(),
      )
        ..add(OnFetchCommunityChallenges())
        ..add(OnFetchParticipatedChallenges()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/icons/circus.svg"),
              6.kW,
              const Text(
                'Community Challenge',
                style: CustomFonts.labelMedium,
              ),
            ],
          ),
        ),
        body: BlocBuilder<CommunityChallengeBloc, CommunityChallengeState>(
          builder: (context, state) {
            final communityChallengesResult = state.communityChallengesResult;
            final participatedChallenges = state.participatedChallenges;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.screenHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ParticipatedChallengeList(),
                    if (participatedChallenges
                            is ApiResultSuccess<List<ChallengeParticipant>> &&
                        participatedChallenges.data.isNotEmpty)
                      24.kH,
                    const Text(
                      'Browse Featured Challenges',
                      style: CustomFonts.labelMedium,
                    ),
                    12.kH,
                    _buildCommunityChallengesList(communityChallengesResult),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}