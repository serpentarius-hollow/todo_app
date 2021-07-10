part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationStarted extends NotificationEvent {}

class NotificationSelected extends NotificationEvent {}

class NotificationPushed extends NotificationEvent {
  final String id;
  final String title;
  final String body;
  final DateTime? scheduledDate;

  NotificationPushed(this.id, this.title, this.body, {this.scheduledDate});
}

class NotificationCancelled extends NotificationEvent {
  final String id;

  NotificationCancelled(this.id);
}
