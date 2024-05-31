import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/gift_card/fetch_all_gift_cards.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_event.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GiftCardBloc extends Bloc<GiftCardEvent, GiftCardState> {
  final FetchAllGiftCards _fetchAllGiftCards;
  GiftCardBloc({
    required FetchAllGiftCards fetchAllGiftCards,
  })  : _fetchAllGiftCards = fetchAllGiftCards,
        super(const GiftCardState.initial()) {
    on<GiftCardEvent>(_onEvent);
  }

  Future<void> _onEvent(
    GiftCardEvent event,
    Emitter<GiftCardState> emit,
  ) async {
    return switch (event) {
      final OnFetchAllGiftCards e => _onFetchAllGiftCards(e, emit),
      final OnSelectGiftCardToUse e => _onSelectGiftCardToUse(e, emit),
      final OnCloseDialog e => _onCloseDialog(e, emit),
      final OnRemoveSelectedGiftCard e => _onRemoveSelectedGiftCard(e, emit),
    };
  }

  void _onRemoveSelectedGiftCard(
    OnRemoveSelectedGiftCard event,
    Emitter<GiftCardState> emit,
  ) {
    emit(state.copyWith(selectedGiftCardToUse: null));
  }

  void _onCloseDialog(
    OnCloseDialog event,
    Emitter<GiftCardState> emit,
  ) {
    emit(state.copyWith(
        shouldShowGiftCardDialog: false,
        selectedGiftCardToUse: state.selectedGiftCardToUse));
  }

  void _onSelectGiftCardToUse(
    OnSelectGiftCardToUse event,
    Emitter<GiftCardState> emit,
  ) {
    emit(state.copyWith(
      selectedGiftCardToUse: event.giftCard,
      shouldShowGiftCardDialog: true,
    ));
  }

  Future<void> _onFetchAllGiftCards(
    OnFetchAllGiftCards event,
    Emitter<GiftCardState> emit,
  ) async {
    final res = await _fetchAllGiftCards.call(NoPayload());
    res.fold(
      (failure) => null,
      (giftCardsRes) {
        if (giftCardsRes.sent.isNotEmpty) {
          emit(state.copyWith(sentGiftCards: giftCardsRes.sent));
        }
        if (giftCardsRes.received.isNotEmpty) {
          emit(state.copyWith(receivedGiftCards: giftCardsRes.received));
        }
      },
    );
  }
}
