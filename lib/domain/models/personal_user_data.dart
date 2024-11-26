class PersonalUserData {
  ReturnPersonalUserData? returnPersonalUserData;

  PersonalUserData({this.returnPersonalUserData});

  PersonalUserData.fromJson(Map<String, dynamic> json) {
    returnPersonalUserData = json['return'] != null
        ? ReturnPersonalUserData.fromJson(json['return'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (returnPersonalUserData != null) {
      data['return'] = returnPersonalUserData!.toJson();
    }
    return data;
  }
}

class ReturnPersonalUserData {
  PersonalData? personalData;

  ReturnPersonalUserData({this.personalData});

  ReturnPersonalUserData.fromJson(Map<String, dynamic> json) {
    personalData = json['PersonalData'] != null
        ? PersonalData.fromJson(json['PersonalData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (personalData != null) {
      data['PersonalData'] = personalData!.toJson();
    }
    return data;
  }
}

class PersonalData {
  String? personalAccount;
  String? name;
  String? address;
  String? flat;
  String? telephone;
  String? mobilePhone;
  String? eMail;
  String? square;
  int? residents;
  int? absentResidents;
  int? temporaryResidents;
  bool? isResidential;

  PersonalData(
      {this.personalAccount,
      this.name,
      this.address,
      this.flat,
      this.telephone,
      this.mobilePhone,
      this.eMail,
      this.square,
      this.residents,
      this.absentResidents,
      this.temporaryResidents,
      this.isResidential});

  PersonalData.fromJson(Map<String, dynamic> json) {
    personalAccount = json['PersonalAccount'];
    name = json['Name'];
    address = json['Address'];
    flat = json['Flat'];
    telephone = json['Telephone'];
    mobilePhone = json['MobilePhone'];
    eMail = json['EMail'];
    square = json['Square'];
    residents = json['Residents'];
    absentResidents = json['AbsentResidents'];
    temporaryResidents = json['TemporaryResidents'];
    isResidential = json['IsResidential'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PersonalAccount'] = personalAccount;
    data['Name'] = name;
    data['Address'] = address;
    data['Flat'] = flat;
    data['Telephone'] = telephone;
    data['MobilePhone'] = mobilePhone;
    data['EMail'] = eMail;
    data['Square'] = square;
    data['Residents'] = residents;
    data['AbsentResidents'] = absentResidents;
    data['TemporaryResidents'] = temporaryResidents;
    data['IsResidential'] = isResidential;
    return data;
  }
}
