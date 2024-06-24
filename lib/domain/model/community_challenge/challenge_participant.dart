import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'challenge_participant.g.dart';

@JsonSerializable()
class ChallengeParticipant {
  final String userId;
  final String communityChallengeId;
  final UserModel user;
  final CommunityChallenge? communityChallenge;
  final Map<String, dynamic>? metadata;
  final String? rewardEmailId;
  final String? rejectReason;
  final bool? challengeIsSuccess;

  const ChallengeParticipant({
    required this.userId,
    required this.communityChallengeId,
    required this.user,
    required this.communityChallenge,
    required this.metadata,
    this.rewardEmailId,
    this.rejectReason,
    this.challengeIsSuccess,
  });

  factory ChallengeParticipant.fromJson(Map<String, dynamic> json) =>
      _$ChallengeParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeParticipantToJson(this);

  static final samples = [
    ChallengeParticipant(
      userId: '1',
      communityChallengeId: '1',
      user: UserModel.sample,
      communityChallenge: CommunityChallenge.samples[0],
      metadata: {},
    ),
    ChallengeParticipant(
      userId: '1',
      communityChallengeId: '1',
      user: UserModel.sample,
      communityChallenge: CommunityChallenge.samples[0],
      metadata: {
        'imageUrl':
            'https://dopwacnojucwkhhdoiqd.supabase.co/storage/v1/object/public/scam-report/8b62bda5-71bf-425d-98c1-04899bb57fb6/images/1678058075559.png'
      },
      rewardEmailId: null,
      rejectReason: null,
    ),
    ChallengeParticipant(
      userId: '1',
      communityChallengeId: '1',
      user: UserModel.sample,
      communityChallenge: CommunityChallenge.samples[0],
      metadata: {
        'imageUrl':
            'https://dopwacnojucwkhhdoiqd.supabase.co/storage/v1/object/public/scam-report/8b62bda5-71bf-425d-98c1-04899bb57fb6/images/1678058075559.png'
      },
      rewardEmailId: null,
      rejectReason: 'This is not our campaign',
    ),
    ChallengeParticipant(
      userId: '1',
      communityChallengeId: '1',
      user: UserModel.sample,
      communityChallenge: CommunityChallenge.samples[0],
      metadata: {
        'imageUrl':
            'https://dopwacnojucwkhhdoiqd.supabase.co/storage/v1/object/public/scam-report/8b62bda5-71bf-425d-98c1-04899bb57fb6/images/1678058075559.png'
      },
      rewardEmailId: 'wjis',
      rejectReason: null,
    ),
  ];
}
