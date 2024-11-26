import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pushchino_app/domain/api/api.dart';
import 'package:pushchino_app/domain/controllers/app_controllers.dart';
import 'package:pushchino_app/domain/models/billing_data.dart';
import 'package:pushchino_app/domain/models/get_measuring_devices.dart';
import 'package:pushchino_app/domain/models/personal_user_data.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';


class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final BuildContext context;

  AuthorizationBloc(this.context) : super(AuthorizationInitial()) {
    on<AuthorizationLoadedEvent>(_authEvent);
  }

  Future<void> _authEvent(
      AuthorizationLoadedEvent event, Emitter<AuthorizationState> emit) async {
    try {
      final api = Api.instance;

      // Получаем персональные данные с новым токеном
      final personalDataResult = await api.fetchPersonalData(
        login: AppControllers.login.text,
        password: AppControllers.password.text,
        date: DateTime.now(),
      );

      if (personalDataResult != null) {
        final personalUserData = personalDataResult['personalData'];

        // Получаем данные по учету с новым токеном
        final billingDataResult = await api.fetchBillingData(
          login: AppControllers.login.text,
          password: AppControllers.password.text,
          date: DateTime.now(),
        );

        BillingData billingData;
        if (billingDataResult != null) {
          billingData = billingDataResult['billingData'];
        } else {
          throw Exception('Ошибка при получении данных учета');
        }

        // Получаем данные измерительных устройств с новым токеном
        final measuringDevices = await api.getMeasuringDevices(
          login: AppControllers.login.text,
          password: AppControllers.password.text,
          date: DateTime.now(),
        );

        if (measuringDevices != null) {
          emit(AuthorizationLoadedState(
            getMeasuringDevices: measuringDevices,
            personalUserData: personalUserData,
            billingData: billingData,
          ));
        } else {
          throw Exception('Ошибка при получении данных измерительных устройств');
        }
      } else {
        throw Exception('Ошибка при получении персональных данных');
      }
    } catch (e) {
      emit(AuthorizationErrorState(e.toString()));
    }
  }
}




