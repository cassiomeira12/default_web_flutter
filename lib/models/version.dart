import 'package:defaultwebflutter/models/base_model.dart';

class Version extends BaseModel<Version> {
  String name;
  int currentCode;
  int minimumCode;
  String url;
  Map notification;

  Version();

  Version.fromMap(Map<String, dynamic>  map) {
    id = map["id"];
    name = map["name"];
    currentCode = map["currentCode"] as int;
    minimumCode = map["minimumCode"] as int;
    url = map["url"];
    notification = map["notification"];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["currentCode"] = currentCode;
    map["minimumCode"] = minimumCode;
    map["url"] = url;
    map["notification"] = notification;
    return map;
  }

  @override
  update(Version item) {
    id = item.id;
    name = item.name;
    currentCode = item.currentCode;
    minimumCode = item.minimumCode;
    url = item.url;
    notification = item.notification;
  }

}