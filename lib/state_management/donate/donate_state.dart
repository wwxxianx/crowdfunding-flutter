import 'package:equatable/equatable.dart';

final class DonateState extends Equatable {
  final bool isCreatingDonation;

  const DonateState._({required this.isCreatingDonation});

  const DonateState.initial() : this._(isCreatingDonation: false);

  DonateState copyWith({
    bool? isCreatingDonation,
  }) {
    return DonateState._(
      isCreatingDonation: isCreatingDonation!,
    );
  }

  @override
  List<Object?> get props => [isCreatingDonation];
}
