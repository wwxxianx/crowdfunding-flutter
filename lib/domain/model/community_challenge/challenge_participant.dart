// ignore_for_file: constant_identifier_names

import 'package:crowdfunding_flutter/common/widgets/container/chip.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'challenge_participant.g.dart';

enum ChallengeStatus {
  IN_PROGRESS,
  UNDER_REVIEW,
  REJECTED,
  COMPLETED,
}

extension ChallengeStatusExtension on ChallengeStatus {
  String get displayLabel {
    switch (this) {
      case ChallengeStatus.IN_PROGRESS:
        return "In Progress";
      case ChallengeStatus.UNDER_REVIEW:
        return "Under Review";
      case ChallengeStatus.REJECTED:
        return "Rejected";
      case ChallengeStatus.COMPLETED:
        return "Completed";
    }
  }

  CustomChipStyle get chipStyle {
    switch (this) {
      case ChallengeStatus.IN_PROGRESS:
        return CustomChipStyle.slate;
      case ChallengeStatus.UNDER_REVIEW:
        return CustomChipStyle.amber;
      case ChallengeStatus.REJECTED:
        return CustomChipStyle.red;
      case ChallengeStatus.COMPLETED:
        return CustomChipStyle.green;
    }
  }

  Widget buildChip() {
    return CustomChip(
      style: chipStyle,
      child: Text(displayLabel),
    );
  }
}

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
  final String status;

  const ChallengeParticipant({
    required this.userId,
    required this.communityChallengeId,
    required this.user,
    required this.communityChallenge,
    required this.metadata,
    required this.status,
    this.rewardEmailId,
    this.rejectReason,
    this.challengeIsSuccess,
  });

  ChallengeStatus get statusEnum {
    try {
      return ChallengeStatus.values.byName(status);
    } catch (e) {
      return ChallengeStatus.IN_PROGRESS;
    }
  }

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
        status: "IN_PROGRESS"),
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
        status: "UNDER_REVIEW"),
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
        status: "REJECTED"),
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
        status: "COMPLETED"),
  ];
}
