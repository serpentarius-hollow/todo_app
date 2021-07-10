part of 'form_bloc.dart';

abstract class FormState extends Equatable {
  const FormState();

  @override
  List<Object?> get props => [];
}

class FormLoadSuccess extends FormState {
  final String? taskName;
  final DateTime? taskDate;
  final FormErrorState? error;

  const FormLoadSuccess({this.taskName, this.taskDate, this.error});

  FormState copyWith({
    String? taskName,
    DateTime? taskDate,
    FormErrorState? error,
  }) {
    return FormLoadSuccess(
      taskName: taskName ?? this.taskName,
      taskDate: taskDate ?? this.taskDate,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [taskName, taskDate, error];
}

class FormValidateSuccess extends FormState {
  final String taskName;
  final DateTime taskDate;

  FormValidateSuccess(this.taskName, this.taskDate);

  @override
  List<Object?> get props => [taskName, taskDate];
}

class FormValidateFailure extends FormState {}

class FormErrorState extends Equatable {
  final String? taskName;
  final String? taskDate;

  FormErrorState({this.taskName, this.taskDate});

  bool get hasErrors => this.taskName != null || this.taskDate != null;

  @override
  List<Object?> get props => [taskName, taskDate];
}
