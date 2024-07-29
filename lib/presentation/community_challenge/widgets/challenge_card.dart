import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunityChallengeCard extends StatelessWidget {
  final CommunityChallenge communityChallenge;
  final ChallengeParticipant? challengeProgress;
  final VoidCallback? onPressed;
  const CommunityChallengeCard({
    super.key,
    required this.communityChallenge,
    this.onPressed,
    this.challengeProgress,
  });

  Widget _buildStatusChip() {
    if (challengeProgress?.statusEnum != null) {
      return challengeProgress!.statusEnum.buildChip();
    }
    return const SizedBox.shrink();
  }

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
          border: Border.all(color: CustomColors.slate300),
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
                      6.kW,
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
              color: CustomColors.slate300,
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
                                if (challengeProgress?.statusEnum != null) _buildStatusChip(),
                                if (challengeProgress?.statusEnum != null) 4.kH,
                                Text(
                                  communityChallenge.title,
                                  style: CustomFonts.titleMedium,
                                ),
                                8.kH,
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
