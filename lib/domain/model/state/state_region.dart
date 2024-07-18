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

  factory StateAndRegion.fromJson(Map<String, dynamic> json) =>
      _$StateAndRegionFromJson(json);

  Map<String, dynamic> toJson() => _$StateAndRegionToJson(this);

  static const sample = StateAndRegion(id: '1', name: 'Kuala Lumpur');
  static const samples = [
    StateAndRegion(id: '1', name: 'Kuala Lumpur'),
    StateAndRegion(id: '2', name: 'Johor Bahru'),
    StateAndRegion(id: '3', name: 'Penang'),
  ];
}
