part of 'get_print_form_data_bloc.dart';

@immutable
sealed class GetPrintFormDataEvent {}
class GetPrintFormDataLoadedEvent extends GetPrintFormDataEvent {
  final String login;
  final String password;
  final DateTime date;
  final int type;

  GetPrintFormDataLoadedEvent({
    required this.login,
    required this.password,
    required this.date,
    required this.type,
  });
}