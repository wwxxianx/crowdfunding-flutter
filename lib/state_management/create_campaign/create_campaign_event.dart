import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@sealed
abstract class CreateCampaignEvent extends Equatable {
  const CreateCampaignEvent();

  @override
  List<Object> get props => [];
}

final class OnTargetAmountTextChanged extends CreateCampaignEvent {
  final String targetAmount;

  const OnTargetAmountTextChanged({required this.targetAmount});
}
