import 'package:equatable/equatable.dart';

final class DonateState extends Equatable {
  final bool isCreatingDonation;
  final String? createDonationError;

  const DonateState._({
    required this.isCreatingDonation,
    this.createDonationError,
  });

  const DonateState.initial() : this._(isCreatingDonation: false);

  DonateState copyWith({
    bool? isCreatingDonation,
    String? createDonationError,
  }) {
    return DonateState._(
      isCreatingDonation: isCreatingDonation!,
      createDonationError: createDonationError,
    );
  }

  @override
  List<Object?> get props => [isCreatingDonation, createDonationError];
}
