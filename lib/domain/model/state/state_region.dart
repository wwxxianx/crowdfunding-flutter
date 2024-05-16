import 'package:json_annotation/json_annotation.dart';

part 'state_region.g.dart';

@JsonSerializable()
class StateAndRegion {
  final String id;
  final String name;

  const StateAndRegion({
    required this.id,
    required this.name,
  });

  factory StateAndRegion.fromJson(Map<String, dynamic> json) => _$StateAndRegionFromJson(json);

  Map<String, dynamic> toJson() => _$StateAndRegionToJson(this);
}
