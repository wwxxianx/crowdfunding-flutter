import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/num_gift_card_response.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchNumOfReceivedUnusedGiftCards implements UseCase<NumOfGiftCardsResponse, NoPayload> {
  final UserRepository userRepository;

  FetchNumOfReceivedUnusedGiftCards({required this.userRepository});

  @override
  Future<Either<Failure, NumOfGiftCardsResponse>> call(NoPayload payload) async {
    return await userRepository.getNumOfReceivedUnusedGiftCards();
  }
}
