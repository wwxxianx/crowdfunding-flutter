import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/presentation/community_challenge/widgets/challenge_card.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge/community_challenge_bloc.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge/community_challenge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ParticipatedChallengeList extends StatelessWidget {
  const ParticipatedChallengeList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityChallengeBloc, CommunityChallengeState>(
      builder: (context, state) {
        final participatedChallenges = state.participatedChallenges;
        if (participatedChallenges
            is ApiResultSuccess<List<ChallengeParticipant>>) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Participated Challenges',
                style: CustomFonts.labelMedium,
              ),
              12.kH,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: participatedChallenges.data.length,
                itemBuilder: (context, index) {
                  final communityChallenge =
                      participatedChallenges.data[index].communityChallenge;
                  if (communityChallenge == null) {
                    return const SizedBox();
                  }
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: CommunityChallengeCard(
                      communityChallenge: communityChallenge,
                      onPressed: () {
                        context.push(
                            '/community-challenges/${communityChallenge.id}');
                      },
                      challengeStatus: ChallengeStatus.values
                          .byName(participatedChallenges.data[index].status),
                    ),
                  );
                },
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
