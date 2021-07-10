part of 'form_bloc.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class FormChanged extends FormEvent {
  final String? taskName;
  final DateTime? taskDate;

  FormChanged({this.taskName, this.taskDate});
}

class FormValidate extends FormEvent {}
