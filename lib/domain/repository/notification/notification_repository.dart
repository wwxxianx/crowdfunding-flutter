import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/domain/model/notification/notification.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class NotificationRepository {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();

  Future<Either<Failure, NotificationModel>> readNotification({required String notificationId});
}