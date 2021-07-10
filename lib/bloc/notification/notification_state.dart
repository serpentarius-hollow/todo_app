part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationShowSuccess extends NotificationState {}

class NotificationShowFailure extends NotificationState {}

class NotificationScheduledSuccess extends NotificationState {
  final String message;

  NotificationScheduledSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class NotificationScheduledFailure extends NotificationState {}

class NotificationCancelSuccess extends NotificationState {}

class NotificationCancelFailure extends NotificationState {}
