import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/notification/notification.dart';
import 'package:crowdfunding_flutter/domain/repository/notification/notification_repository.dart';
import 'package:fpdart/src/either.dart';

class ToggleReadNotification implements UseCase<NotificationModel, String> {
  final NotificationRepository notificationRepository;

  const ToggleReadNotification({required this.notificationRepository});

  @override
  Future<Either<Failure, NotificationModel>> call(String payload) async {
    return await notificationRepository.readNotification(
        notificationId: payload);
  }
}
