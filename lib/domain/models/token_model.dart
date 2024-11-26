// class TokenModel {
// 	ReturnData? returndata;

// 	TokenModel({this.returndata});

// 	TokenModel.fromJson(Map<String, dynamic> json) {
// 		returndata = json['return'] != null ? new ReturnData.fromJson(json['return']) : null;
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = <String, dynamic>{};
// 		if (returndata != null) {
//       data['return'] = returndata!.toJson();
//     }
// 		return data;
// 	}
// }

// class ReturnData {
// 	String? token;

// 	ReturnData({this.token});

// 	ReturnData.fromJson(Map<String, dynamic> json) {
// 		token = json['Token'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = <String, dynamic>{};
// 		data['Token'] = token;
// 		return data;
// 	}
// }


// ***********************************


class TokenModel {
  String? token;

  TokenModel({this.token});

  // Метод, принимающий произвольный JSON и ищущий строку, похожую на токен
  TokenModel.fromJson(Map<String, dynamic> json) {
    token = _findToken(json);
  }

  Map<String, dynamic> toJson() {
    return {'Token': token};
  }

  // Метод для поиска строки токена по критериям длины и символов
  String? _findToken(Map<String, dynamic> json) {
    for (var key in json.keys) {
      var value = json[key];

      // Если значение — строка, проверим, похоже ли оно на токен
      if (value is String && _isValidToken(value)) {
        return value;
      }

      // Если значение — вложенный объект, рекурсивно ищем токен
      if (value is Map<String, dynamic>) {
        String? result = _findToken(value);
        if (result != null) return result;
      }
    }
    return null; // Возвращаем null, если токен не найден
  }

  // Проверяем, является ли значение похожим на токен
  bool _isValidToken(String value) {
    // Пример критерия: строка состоит из буквенно-цифровых символов и длиной более 20
    return value.length > 20 && RegExp(r'^[\w-]+$').hasMatch(value);
  }
}

// class TokenModel {
//   String? token;

//   TokenModel({this.token});

//   // Простой конструктор из JSON
//   TokenModel.fromJson(Map<String, dynamic> json) {
//     // Извлекаем токен по фиксированному пути
//     token = json['return']?['Token'];
//   }

//   Map<String, dynamic> toJson() {
//     return {'Token': token};
//   }
// }
