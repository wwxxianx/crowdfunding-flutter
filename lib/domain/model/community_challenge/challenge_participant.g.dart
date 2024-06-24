// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeParticipant _$ChallengeParticipantFromJson(
        Map<String, dynamic> json) =>
    ChallengeParticipant(
      userId: json['userId'] as String,
      communityChallengeId: json['communityChallengeId'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      communityChallenge: json['communityChallenge'] == null
          ? null
          : CommunityChallenge.fromJson(
              json['communityChallenge'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>?,
      rewardEmailId: json['rewardEmailId'] as String?,
      rejectReason: json['rejectReason'] as String?,
      challengeIsSuccess: json['challengeIsSuccess'] as bool?,
    );

Map<String, dynamic> _$ChallengeParticipantToJson(
        ChallengeParticipant instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'communityChallengeId': instance.communityChallengeId,
      'user': instance.user,
      'communityChallenge': instance.communityChallenge,
      'metadata': instance.metadata,
      'rewardEmailId': instance.rewardEmailId,
      'rejectReason': instance.rejectReason,
      'challengeIsSuccess': instance.challengeIsSuccess,
    };
