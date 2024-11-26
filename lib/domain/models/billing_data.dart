class BillingData {
	BillingPersonData? billingPersonData;

	BillingData({this.billingPersonData});

	BillingData.fromJson(Map<String, dynamic> json) {
		billingPersonData = json['return'] != null ? BillingPersonData.fromJson(json['return']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (billingPersonData != null) {
      data['return'] = billingPersonData!.toJson();
    }
		return data;
	}
}

class BillingPersonData {
	AccountingInformationList? accountingInformationList;

	BillingPersonData({this.accountingInformationList});

	BillingPersonData.fromJson(Map<String, dynamic> json) {
		accountingInformationList = json['AccountingInformationList'] != null ? AccountingInformationList.fromJson(json['AccountingInformationList']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (accountingInformationList != null) {
      data['AccountingInformationList'] = accountingInformationList!.toJson();
    }
		return data;
	}
}

class AccountingInformationList {
	Service? service;
	String? quantity;
	String? price;
	String? sum;
	String? recalculation;
	String? sumTotal;
	String? payment;
	String? debt;

	AccountingInformationList({this.service, this.quantity, this.price, this.sum, this.recalculation, this.sumTotal, this.payment, this.debt});

	AccountingInformationList.fromJson(Map<String, dynamic> json) {
		service = json['Service'] != null ? Service.fromJson(json['Service']) : null;
		quantity = json['Quantity'];
		price = json['Price'];
		sum = json['Sum'];
		recalculation = json['Recalculation'];
		sumTotal = json['SumTotal'];
		payment = json['Payment'];
		debt = json['Debt'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (service != null) {
      data['Service'] = service!.toJson();
    }
		data['Quantity'] = quantity;
		data['Price'] = price;
		data['Sum'] = sum;
		data['Recalculation'] = recalculation;
		data['SumTotal'] = sumTotal;
		data['Payment'] = payment;
		data['Debt'] = debt;
		return data;
	}
}

class Service {
	String? gUID;
	String? serviceName;
	String? unitOfMeasurement;

	Service({this.gUID, this.serviceName, this.unitOfMeasurement});

	Service.fromJson(Map<String, dynamic> json) {
		gUID = json['GUID'];
		serviceName = json['ServiceName'];
		unitOfMeasurement = json['UnitOfMeasurement'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['GUID'] = gUID;
		data['ServiceName'] = serviceName;
		data['UnitOfMeasurement'] = unitOfMeasurement;
		return data;
	}
}
