import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';

// @immutable
// sealed class AppUserState {}

// final class AppUserInitial extends AppUserState {}

// final class AppUserLoggedIn extends AppUserState {
//   final UserModel user;
//   final int numOfReceivedUnusedGiftCards;
//   AppUserLoggedIn({
//     required this.user,
//     this.numOfReceivedUnusedGiftCards = 0,
//   });
// }

final class AppUserState extends Equatable {
  final UserModel? currentUser;
  final int numOfReceivedUnusedGiftCards;

  const AppUserState._({
    this.currentUser,
    this.numOfReceivedUnusedGiftCards = 0,
  });

  const AppUserState.initial() : this._();

  AppUserState copyWith({
    UserModel? currentUser,
    int? numOfReceivedUnusedGiftCards,
  }) {
    return AppUserState._(
      currentUser: currentUser ?? this.currentUser,
      numOfReceivedUnusedGiftCards:
          numOfReceivedUnusedGiftCards ?? this.numOfReceivedUnusedGiftCards,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        numOfReceivedUnusedGiftCards,
      ];
}
