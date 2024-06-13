import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/notification/notification.dart';
import 'package:crowdfunding_flutter/domain/repository/notification/notification_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchNotifications
    implements UseCase<List<NotificationModel>, NoPayload> {
  final NotificationRepository notificationRepository;

  const FetchNotifications({required this.notificationRepository});
  
  @override
  Future<Either<Failure, List<NotificationModel>>> call(
      NoPayload payload) async {
    return await notificationRepository.getNotifications();
  }
}
