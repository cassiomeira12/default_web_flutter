import 'package:defaultwebflutter/models/plans/plan.dart';

import '../base_model.dart';

class CompanyPaymentHistory extends BaseModel<CompanyPaymentHistory> {
  String idCompany;
  DateTime dueDate;
  DateTime dayOfPayment;
  double cost;
  double discount;
  String receiptURL;
  bool paymentAccept;
  Plan plan;

  CompanyPaymentHistory();

  CompanyPaymentHistory.fromMap(Map<dynamic, dynamic>  map) {
    id = map["_id"];
    idCompany = map["idCompany"];
    dueDate = DateTime.parse(map["dueDate"]);
    dayOfPayment = DateTime.parse(map["dayOfPayment"]);
    cost = double.parse(map["cost"]);
    discount = double.parse(map["discount"]);
    receiptURL = map["receiptURL"];
    //paymentAccept = map["paymentAccept"];
    plan = Plan.fromMap(map["plan"]);
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["idCompany"] = idCompany;
    map["dueDate"] = dueDate.toString();
    map["dayOfPayment"] = dayOfPayment.toString();
    map["cost"] = cost;
    map["discount"] = discount;
    map["receiptURL"] = receiptURL;
    map["paymentAccept"] = paymentAccept;
    map["plan"] = plan.toMap();
    return map;
  }

  @override
  update(CompanyPaymentHistory item) {
    id = item.id;
    idCompany = item.idCompany;
    dueDate = item.dueDate;
    dayOfPayment = item.dayOfPayment;
    cost = item.cost;
    discount = item.discount;
    receiptURL = item.receiptURL;
    paymentAccept = item.paymentAccept;
    plan = item.plan;
  }

}