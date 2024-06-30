import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';

final class AccountPreferencesState extends Equatable {
  final List<String> selectedCategoryIds;
  final ApiResult<UserModel> updateUserResult;

  const AccountPreferencesState._({
    this.selectedCategoryIds = const [],
    this.updateUserResult = const ApiResultInitial(),
  });

  const AccountPreferencesState.initial() : this._();

  AccountPreferencesState copyWith({
    List<String>? selectedCategoryIds,
    ApiResult<UserModel>? updateUserResult,
  }) {
    return AccountPreferencesState._(
      selectedCategoryIds: selectedCategoryIds ?? this.selectedCategoryIds,
      updateUserResult: updateUserResult ?? this.updateUserResult,
    );
  }

  @override
  List<Object?> get props => [
        selectedCategoryIds,
        updateUserResult,
      ];
}
