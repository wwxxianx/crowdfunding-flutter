// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_grouped_donations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDonationsResponse _$UserDonationsResponseFromJson(
        Map<String, dynamic> json) =>
    UserDonationsResponse(
      groupedDonations: (json['groupedDonations'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map(
                    (e) => CampaignDonation.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$UserDonationsResponseToJson(
        UserDonationsResponse instance) =>
    <String, dynamic>{
      'groupedDonations': instance.groupedDonations,
    };
