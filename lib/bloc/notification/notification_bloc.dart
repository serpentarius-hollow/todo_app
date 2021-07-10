import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/bloc/todo/todo_bloc.dart';
import 'package:todo_app/notification_service.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final TodoBloc _todoBloc;
  final NotificationService _notificationService;

  late StreamSubscription _todoBlocSub;

  NotificationBloc(this._todoBloc, this._notificationService)
      : super(NotificationInitial()) {
    _todoBlocSub = _todoBloc.stream.listen((state) {
      if (state is TodoAddedSuccess) {
        add(NotificationPushed(
          state.todo.id,
          state.todo.taskName,
          'Task is in 5 minutes',
          scheduledDate: state.todo.taskDate,
        ));
      }

      if (state is TodoUpdatedSuccess) {
        add(NotificationPushed(
          state.todo.id,
          state.todo.taskName,
          'Task is in 5 minutes',
          scheduledDate: state.todo.taskDate,
        ));
      }

      if (state is TodoDeletedSuccess) {
        add(NotificationCancelled(state.todo.id));
      }
    });
  }

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    final currentState = state;

    if (event is NotificationPushed) {
      if (currentState is NotificationInitial) {
        if (event.scheduledDate != null) {
          final difference = event.scheduledDate!.difference(DateTime.now());

          if (difference.inMinutes >= 5) {
            _notificationService.scheduleNotification(
              event.id,
              event.title,
              'Task is in 5 minutes',
              event.scheduledDate!,
            );

            yield NotificationScheduledSuccess('Setting a reminder...');
          }
        }

        yield currentState;
      }
    }

    if (event is NotificationCancelled) {
      if (currentState is NotificationInitial) {
        _notificationService.cancelNotification(event.id);

        yield NotificationCancelSuccess();
        yield currentState;
      }
    }

    if (event is NotificationStarted) {
      _notificationService.init();
    }
  }

  // Stream<NotificationState> _mapNotificationPushedToState(
  //   NotificationState currentState,
  //   NotificationPushed event,
  // ) async* {
  //   if (currentState is NotificationInitial) {
  //     if (event.scheduledDate != null) {
  //       _scheduleNotification(event);
  //     }

  //     yield currentState;
  //   }
  // }

  // Stream<NotificationState> _scheduleNotification(
  //   NotificationPushed event,
  // ) async* {
  //   final difference = event.scheduledDate!.difference(DateTime.now());

  //   if (difference.inMinutes >= 5) {
  //     _notificationService.scheduleNotification(
  //       event.id,
  //       event.title,
  //       'Task is in 5 minutes',
  //       event.scheduledDate!,
  //     );

  //     yield NotificationScheduledSuccess('Setting a reminder...');
  //   }
  // }

  // Stream<NotificationState> _mapNotificationCancelledToState(
  //   NotificationState currentState,
  //   NotificationCancelled event,
  // ) async* {
  //   if (currentState is NotificationInitial) {
  //     _notificationService.cancelNotification(event.id);

  //     yield NotificationCancelSuccess();
  //     yield currentState;
  //   }
  // }

  @override
  Future<void> close() {
    _todoBlocSub.cancel();
    return super.close();
  }
}
