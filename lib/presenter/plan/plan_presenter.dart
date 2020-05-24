import '../../contract/crud.dart';
import '../../models/plans/plan.dart';
import '../../services/firebase/firebase_plan_service.dart';

class PlanPresenter implements Crud<Plan> {

  var service = FirebasePlanService("plans");

  dispose() {
    service = null;
  }

  @override
  Future<Plan> create(Plan item) async {
    return await service.create(item);
  }

  @override
  Future<Plan> read(Plan item) async {
    return await service.read(item);
  }

  @override
  Future<Plan> update(Plan item) async {
    return await service.update(item);
  }

  @override
  Future<Plan> delete(Plan item) async {
    return await service.create(item);
  }

  @override
  Future<List<Plan>> findBy(String field, value) async {
    return await service.findBy(field, value).then((value) {
      return value;
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<List<Plan>> list() async {
    return await service.list().then((value) {
      return value;
    }).catchError((error) {
      return null;
    });
  }

}