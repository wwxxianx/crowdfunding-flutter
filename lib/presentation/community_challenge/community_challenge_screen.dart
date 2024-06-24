import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
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
          return CommunityChallengeCard(
            communityChallenge: communityChallenge,
            onPressed: () {
              context.push('/community-challenges/${communityChallenge.id}');
            },
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
      )..add(OnFetchCommunityChallenges()),
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
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.screenHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
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

class CommunityChallengeCard extends StatelessWidget {
  final CommunityChallenge communityChallenge;
  final VoidCallback? onPressed;
  const CommunityChallengeCard({
    super.key,
    required this.communityChallenge,
    this.onPressed,
  });

  Widget _buildParticipantsList() {
    if (communityChallenge.participants?.isNotEmpty ?? false) {
      return Row(
        children: [
          SizedBox(
            height: 25,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: communityChallenge.participants!.length,
              itemBuilder: (context, index) {
                final participant =
                    communityChallenge.participants![index].user;
                return Container(
                  margin: const EdgeInsets.only(right: 2),
                  child: Avatar(
                    imageUrl: participant.profileImageUrl,
                    placeholder: participant.fullName[0],
                    size: 25,
                    border: Border.all(color: Colors.black),
                  ),
                );
              },
            ),
          ),
          Text(
            'Participated',
            style: CustomFonts.bodySmall.copyWith(color: CustomColors.textGrey),
          ),
        ],
      );
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            // Header
            Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Sponsored by:',
                        style: CustomFonts.bodySmall.copyWith(
                          color: CustomColors.textGrey,
                        ),
                      ),
                      4.kW,
                      Avatar(
                        imageUrl: communityChallenge.sponsorImageUrl,
                        placeholder: communityChallenge.sponsorName[0],
                        size: 25,
                      ),
                      const Spacer(),
                      Text(
                        'Expires on ${communityChallenge.expiredAt.toISODate()}',
                        style: CustomFonts.bodySmall.copyWith(
                          color: CustomColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset('assets/images/header-two-lines-shape.svg'),
              ],
            ),
            const Divider(
              color: Colors.black,
              height: 1,
            ),
            Stack(
              children: [
                Positioned(
                  bottom: 19,
                  left: 22,
                  child: SvgPicture.asset(
                    'assets/images/asterisk-shape.svg',
                    color: CustomColors.accentGreen,
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 180,
                  child:
                      SvgPicture.asset('assets/images/curve-spring-shape.svg'),
                ),
                Positioned(
                  bottom: 6,
                  left: 240,
                  child: Transform.rotate(
                    angle: 0,
                    child: SvgPicture.asset(
                      'assets/images/asterisk-shape.svg',
                      color: Color(0xFFD3D3D3),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: communityChallenge.imageUrl,
                                errorWidget: (context, url, error) {
                                  return Skeleton();
                                },
                              ),
                            ),
                          ),
                          12.kW,
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  communityChallenge.title,
                                  style: CustomFonts.titleMedium,
                                ),
                                6.kH,
                                Text(
                                  communityChallenge.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      12.kH,
                      _buildParticipantsList(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
