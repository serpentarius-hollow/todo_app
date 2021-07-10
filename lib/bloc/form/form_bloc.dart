import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_event.dart';
part 'form_state.dart';

bool isNull(String? str) {
  return str == null || str.length == 0;
}

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormLoadSuccess());

  @override
  Stream<FormState> mapEventToState(
    FormEvent event,
  ) async* {
    final currentState = state;

    if (event is FormChanged) {
      if (currentState is FormLoadSuccess) {
        yield currentState.copyWith(
            taskName: event.taskName, taskDate: event.taskDate);
      }
    }

    if (event is FormValidate) {
      if (currentState is FormLoadSuccess) {
        final errorTaskName =
            currentState.taskName == null || currentState.taskName!.isEmpty
                ? 'Cannot be blank'
                : null;

        final errorTaskDate =
            currentState.taskDate == null ? 'Cannot be blank' : null;

        if (errorTaskName == null || errorTaskDate == null) {
          if (currentState.taskName != null && currentState.taskDate != null) {
            yield FormValidateSuccess(
              currentState.taskName!,
              currentState.taskDate!,
            );
          }
        }

        yield currentState.copyWith(
            error: FormErrorState(
          taskName: errorTaskName,
          taskDate: errorTaskDate,
        ));
      }
    }
  }
}
