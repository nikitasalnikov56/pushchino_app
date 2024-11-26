import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:pushchino_app/domain/models/billing_data.dart';
import 'package:pushchino_app/domain/models/get_measuring_devices.dart';
import 'package:pushchino_app/domain/models/personal_user_data.dart';

class Api {
  static const String city = 'dmitrov';
  static final Api instance = Api._internal();

  final Dio _dio;

  // Приватный конструктор для инициализации Dio
  Api._internal()
      : _dio = Dio(
            BaseOptions(baseUrl: 'https://dmitrov.moya-kvitanciya.ru/api/'));

  // Метод для получения нового токена
  Future<String?> fetchNewToken(String login, String password) async {
    try {
      log('Запрашиваем новый токен для пользователя: $login');
      final authResponse = await _dio.post(
        'Authentication?Login=$login&Password=$password',
      );

      if (authResponse.statusCode != 200) {
        throw Exception('Ошибка авторизации: ${authResponse.statusCode}');
      }

      final authData = authResponse.data;
      final token = authData['return']['Token'];
      if (token == null || token.isEmpty) {
        throw Exception('Ошибка: токен не получен.');
      }

      log('Получен новый токен: $token');
      return token;
    } catch (e) {
      log('Ошибка при получении токена: $e');
      return null;
    }
  }

  // Метод для получения персональных данных с новым токеном
  Future<Map<String, dynamic>?> fetchPersonalData({
    required String login,
    required String password,
    required DateTime date,
  }) async {
    try {
      final token = await fetchNewToken(login, password);
      if (token == null) {
        throw Exception('Не удалось получить токен.');
      }

      // 2-й запрос: Получение персональных данных с новым токеном
      final currentDate = DateFormat('yyyy-MM-dd').format(date);
      log('Запрашиваем персональные данные с токеном $token на дату $currentDate');
      final dataResponse = await _dio.get(
        'GetPersonalData?Token=$token&Date=$currentDate',
      );
      if (dataResponse.statusCode != 200) {
        throw Exception(
            'Ошибка при получении персональных данных: ${dataResponse.statusCode}');
      }

      final personalData = dataResponse.data;

      // Возвращаем персональные данные
      return {
        'personalData': PersonalUserData.fromJson(personalData),
      };
    } catch (e) {
      log('Ошибка при запросе персональных данных: $e');
      return null;
    }
  }

  // Метод для получения данных учета с новым токеном
  Future<Map<String, dynamic>?> fetchBillingData({
    required String login,
    required String password,
    required DateTime date,
  }) async {
    try {
      final token = await fetchNewToken(login, password);
      if (token == null) {
        throw Exception('Не удалось получить токен.');
      }
      log('Token для fetchBillingData: $token');
      // 3-й запрос: Получение данных по учету с тем же токеном
      final currentDate = DateFormat('yyyy-MM-dd').format(date);
      log('Запрашиваем данные учета с токеном $token на период $currentDate');
      final billingResponse = await _dio.get(
        'GetAccountingInformation',
        queryParameters: {
          'Token': token.trim(),
          'Period': currentDate,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (billingResponse.statusCode != 200) {
        throw Exception(
            'Ошибка при получении данных: ${billingResponse.statusCode}');
      }

      final billingData = billingResponse.data;
      log('Billing Data: $billingData');
      // Возвращаем данные учета
      return {
        'billingData': BillingData.fromJson(billingData),
      };
    } catch (e) {
      log('Ошибка при запросе данных учета: $e');
      return null;
    }
  }

  // Метод для получения данных измерительных устройств с новым токеном
  Future<GetMeasuringDevices?> getMeasuringDevices({
    required String login,
    required String password,
    required DateTime date,
  }) async {
    try {
      final token = await fetchNewToken(login, password);
      if (token == null) {
        throw Exception('Не удалось получить токен.');
      }

      // Получаем данные измерительных устройств с новым токеном
      log('Запрашиваем данные измерительных устройств с токеном $token');
      final response = await _dio.get('GetMeasuringDevices?Token=$token');
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          print('Данные измерительных устройств успешно получены');
          return GetMeasuringDevices.fromJson(response.data);
        } else {
          log('Ответ не в формате Map<String, dynamic>');
        }
      } else {
        log('Ошибка при получении данных измерительных устройств: ${response.statusCode}');
      }
    } catch (e) {
      log('Ошибка при запросе данных измерительных устройств: $e');
    }
    return null;
  }
}
