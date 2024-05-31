import 'package:crowdfunding_flutter/domain/model/gift_card/gift_card.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class GiftCardEvent {
  const GiftCardEvent();
}

final class OnFetchAllGiftCards extends GiftCardEvent {}

final class OnSelectGiftCardToUse extends GiftCardEvent {
  final GiftCard giftCard;

  const OnSelectGiftCardToUse({required this.giftCard});
}

final class OnRemoveSelectedGiftCard extends GiftCardEvent {}

final class OnCloseDialog extends GiftCardEvent {}