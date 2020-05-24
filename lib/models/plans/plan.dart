import '../base_model.dart';

class Plan extends BaseModel<Plan> {
  String name;
  double cost;
  int days;
  String description;

  Plan();

  Plan.fromMap(Map<dynamic, dynamic>  map) {
    id = map["_id"];
    name = map["name"];
    cost = map["cost"];
    days = map["days"];
    description = map["code"];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["cost"] = cost;
    map["days"] = days;
    map["description"] = description;
    return map;
  }

  @override
  update(Plan item) {
    id = item.id;
    name = item.name;
    cost = item.cost;
    days = item.days;
    description = item.description;
  }

}