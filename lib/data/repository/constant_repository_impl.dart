import 'dart:convert';

import 'package:crowdfunding_flutter/common/constants/constants.dart';
import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/local/shared_preference.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
import 'package:crowdfunding_flutter/domain/repository/constant_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';

class ConstantRepositoryImpl implements ConstantRepository {
  final RestClient api;
  final MySharedPreference sp;

  const ConstantRepositoryImpl({
    required this.api,
    required this.sp,
  });

  @override
  Future<Either<Failure, List<StateAndRegion>>> getStateAndRegions() async {
    try {
      final savedDataInJson = await sp.getDataIfNotExpired(
        Constants.sharedPreferencesKey.stateAndRegion,
        Constants.sharedPreferencesKey.stateAndRegionExpiration,
      );
      if (savedDataInJson != null) {
        final data = List<StateAndRegion>.from(
          (jsonDecode(savedDataInJson) as List).map(
            (post) => StateAndRegion.fromJson(post),
          ),
        );
        if (data.isNotEmpty) {
          return right(data);
        }
      }
      // Failed to get data from cache
      final res = await api.getStateAndRegions();
      if (res.isNotEmpty) {
        sp.saveDataWithExpiration(
          Constants.sharedPreferencesKey.stateAndRegion,
          Constants.sharedPreferencesKey.stateAndRegionExpiration,
          jsonEncode(res),
        );
      }
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }
}
