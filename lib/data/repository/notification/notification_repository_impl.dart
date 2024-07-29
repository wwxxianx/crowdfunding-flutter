import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/notification/notification.dart';
import 'package:crowdfunding_flutter/domain/repository/notification/notification_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final RestClient api;

  const NotificationRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      // return right(NotificationModel.samples);
      final res = await api.getNotifications();
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }

  @override
  Future<Either<Failure, NotificationModel>> readNotification(
      {required String notificationId}) async {
    try {
      final res = await api.readNotification(notificationId: notificationId);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }
}
