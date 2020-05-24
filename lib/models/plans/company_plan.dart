import 'package:defaultwebflutter/models/plans/plan.dart';

import '../base_model.dart';

class CompanyPlan extends BaseModel<CompanyPlan> {
  String idCompany;
  DateTime initiatedAt;
  int payDay;
  DateTime dueDate;
  double discount;
  Plan plan;

  CompanyPlan();

  CompanyPlan.fromMap(Map<dynamic, dynamic>  map) {
    id = map["_id"];
    idCompany = map["idCompany"];
    initiatedAt = DateTime.parse(map["initiatedAt"]);
    payDay = int.parse(map["payDay"]);
    dueDate = DateTime.parse(map["dueDate"]);
    discount = double.parse(map["discount"]);
    plan = Plan.fromMap(map["plan"]);
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["idCompany"] = idCompany;
    map["initiatedAt"] = initiatedAt.toString();
    map["payDay"] = payDay;
    map["dueDate"] = dueDate.toString();
    map["discount"] = discount;
    map["plan"] = plan.toMap();
    return map;
  }

  @override
  update(CompanyPlan item) {
    id = item.id;
    idCompany = item.idCompany;
    initiatedAt = item.initiatedAt;
    payDay = item.payDay;
    dueDate = item.dueDate;
    discount = item.discount;
    plan = item.plan;
  }

}