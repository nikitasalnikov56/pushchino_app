class GetMeasuringDevices {
  ReturnDevicesData? returnDevicesData;

  GetMeasuringDevices({this.returnDevicesData});

  GetMeasuringDevices.fromJson(Map<String, dynamic> json) {
    returnDevicesData = json['return'] != null
        ? ReturnDevicesData.fromJson(json['return'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (returnDevicesData != null) {
      data['return'] = returnDevicesData!.toJson();
    }
    return data;
  }
}

class ReturnDevicesData {
  List<MeasuringDevicesList>? measuringDevicesList;

  ReturnDevicesData({this.measuringDevicesList});

  ReturnDevicesData.fromJson(Map<String, dynamic> json) {
    if (json['MeasuringDevicesList'] != null) {
      measuringDevicesList = <MeasuringDevicesList>[];
      json['MeasuringDevicesList'].forEach((v) {
        measuringDevicesList!.add(MeasuringDevicesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (measuringDevicesList != null) {
      data['MeasuringDevicesList'] =
          measuringDevicesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MeasuringDevicesList {
  String? gUID;
  String? deviceName;
  String? dateBegin;
  String? dateEnd;
  String? verificationDate;
  String? deviceNumber;
  String? actualReadings;
  dynamic readingsList;

  MeasuringDevicesList(
      {this.gUID,
      this.deviceName,
      this.dateBegin,
      this.dateEnd,
      this.verificationDate,
      this.deviceNumber,
      this.actualReadings,
      this.readingsList});

  MeasuringDevicesList.fromJson(Map<String, dynamic> json) {
    gUID = json['GUID'];
    deviceName = json['DeviceName'];
    dateBegin = json['DateBegin'];
    dateEnd = json['DateEnd'];
    verificationDate = json['VerificationDate'];
    deviceNumber = json['DeviceNumber'];
    actualReadings = json['ActualReadings'];
    // Проверка типа данных ReadingsList
    // if (json['ReadingsList'] != null && json['ReadingsList'] is Map<String, dynamic>) {
    //   readingsList = ReadingsList.fromJson(json['ReadingsList']);
    // } else {
    //   readingsList = null;
    // }
    // Обработка `ReadingsList` как объекта или массива
    if (json['ReadingsList'] != null) {
      if (json['ReadingsList'] is Map<String, dynamic>) {
        readingsList = [ReadingsList.fromJson(json['ReadingsList'])];
      } else if (json['ReadingsList'] is List) {
        readingsList = (json['ReadingsList'] as List)
            .map((item) => ReadingsList.fromJson(item))
            .toList();
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GUID'] = gUID;
    data['DeviceName'] = deviceName;
    data['DateBegin'] = dateBegin;
    data['DateEnd'] = dateEnd;
    data['VerificationDate'] = verificationDate;
    data['DeviceNumber'] = deviceNumber;
    data['ActualReadings'] = actualReadings;
    // if (readingsList != null) {
    //   data['ReadingsList'] = readingsList!.toJson();
    // }
    if (readingsList != null) {
      if (readingsList is List) {
        data['ReadingsList'] = readingsList.map((v) => v.toJson()).toList();
      } else if (readingsList is ReadingsList) {
        data['ReadingsList'] = readingsList.toJson();
      }
    }
    return data;
  }
}

class ReadingsList {
  String? date;
  String? forPeriod;
  String? correcting;
  String? actual;

  ReadingsList({this.date, this.forPeriod, this.correcting, this.actual});

  ReadingsList.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    forPeriod = json['ForPeriod'];
    correcting = json['Correcting'];
    actual = json['Actual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    data['ForPeriod'] = forPeriod;
    data['Correcting'] = correcting;
    data['Actual'] = actual;
    return data;
  }
}
