part of 'get_print_form_data_bloc.dart';

@immutable
sealed class GetPrintFormDataState {}

final class GetPrintFormDataInitial extends GetPrintFormDataState {}

final class GetPrintFormDataLoadingState extends GetPrintFormDataState {}

final class GetPrintFormDataLoadedState extends GetPrintFormDataState {
  // final String? pdfFile; // Возвращаемый файл
  final File res;
  GetPrintFormDataLoadedState({required this.res});
}

final class GetPrintFormDataErrorState extends GetPrintFormDataState {
  final String error; // Возвращаемый файл
  GetPrintFormDataErrorState({required this.error});
}
