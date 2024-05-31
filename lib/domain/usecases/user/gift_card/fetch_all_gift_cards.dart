import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/gift_cards_response.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchAllGiftCards implements UseCase<GiftCardsResponse, NoPayload> {
  final UserRepository userRepository;

  FetchAllGiftCards({required this.userRepository});
  @override
  Future<Either<Failure, GiftCardsResponse>> call(NoPayload payload) async {
    return await userRepository.getAllGiftCards();
  }
}
