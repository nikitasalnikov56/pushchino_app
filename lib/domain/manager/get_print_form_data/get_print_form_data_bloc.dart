import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:pushchino_app/domain/api/api.dart';

part 'get_print_form_data_event.dart';
part 'get_print_form_data_state.dart';


class GetPrintFormDataBloc extends Bloc<GetPrintFormDataEvent, GetPrintFormDataState> {
  

  GetPrintFormDataBloc() : super(GetPrintFormDataInitial()) {
    on<GetPrintFormDataLoadedEvent>((event, emit) async {
      try {

        emit(GetPrintFormDataLoadingState());
        

        final api = Api.instance;
        final pdfBytes = await api.fetchPrintFormAsBytes(
          login: event.login,
          password: event.password,
          date: event.date,
          type: event.type,
        );

        if (pdfBytes == null) {
          throw Exception('Не удалось загрузить PDF данные.');
        }

        // Сохраняем файл
        final currentDate = DateFormat('yyyy-MM-dd').format(event.date);
        final filePath =
            '/storage/emulated/0/Download/Квитанция-$currentDate.pdf';
        final file = File(filePath);
        var res = await file.writeAsBytes(pdfBytes);

        // Эмитируем состояние с результатом
        emit(GetPrintFormDataLoadedState(res: res));

        // Логирование для проверки
        print('File saved: $filePath');
      } catch (e) {
        // Логируем ошибку
        print('Error occurred: $e');
        
        // Эмитируем ошибку
        emit(GetPrintFormDataErrorState(error: e.toString()));
      }
    });
  }
}
