import 'package:crowdfunding_flutter/domain/model/gift_card/gift_card.dart';
import 'package:equatable/equatable.dart';

final class GiftCardState extends Equatable {
  final List<GiftCard> sentGiftCards;
  final List<GiftCard> receivedGiftCards;
  final GiftCard? selectedGiftCardToUse;
  final bool shouldShowGiftCardDialog;

  const GiftCardState._({
    this.sentGiftCards = const [],
    this.receivedGiftCards = const [],
    this.selectedGiftCardToUse,
    this.shouldShowGiftCardDialog = false,
  });

  const GiftCardState.initial() : this._();

  GiftCardState copyWith({
    List<GiftCard>? sentGiftCards,
    List<GiftCard>? receivedGiftCards,
    GiftCard? selectedGiftCardToUse,
    bool? shouldShowGiftCardDialog,
  }) {
    return GiftCardState._(
      sentGiftCards: sentGiftCards ?? this.sentGiftCards,
      receivedGiftCards: receivedGiftCards ?? this.receivedGiftCards,
      selectedGiftCardToUse: selectedGiftCardToUse,
      shouldShowGiftCardDialog: shouldShowGiftCardDialog ?? false,
    );
  }

  @override
  List<Object?> get props => [
        sentGiftCards,
        receivedGiftCards,
        selectedGiftCardToUse,
        shouldShowGiftCardDialog,
      ];
}
