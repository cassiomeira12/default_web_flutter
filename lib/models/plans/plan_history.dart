import 'package:defaultwebflutter/models/plans/plan.dart';

import '../base_model.dart';

class PlanHistory extends BaseModel<PlanHistory> {
  String name;
  double cost;
  int days;
  String description;
  DateTime initiatedAt;
  DateTime finishedAt;

  PlanHistory();

  PlanHistory.fromMap(Map<dynamic, dynamic>  map) {
    id = map["_id"];
    name = map["name"];
    cost = double.parse(map["cost"]);
    days = int.parse(map["days"]);
    description = map["description"];
    initiatedAt = DateTime.parse(map["initiatedAt"]);
    finishedAt = DateTime.parse(map["finishedAt"]);
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["cost"] = cost;
    map["days"] = days;
    map["description"] = description;
    map["initiatedAt"] = initiatedAt.toString();
    map["finishedAt"] = finishedAt.toString();
    return map;
  }

  @override
  update(PlanHistory item) {
    id = item.id;
    name = item.name;
    cost = item.cost;
    days = item.days;
    description = item.description;
    initiatedAt = item.initiatedAt;
    finishedAt = item.finishedAt;
  }

}