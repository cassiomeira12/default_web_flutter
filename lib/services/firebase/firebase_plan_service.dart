import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/plans/plan.dart';

import '../../contract/crud.dart';
import 'base_firebase_service.dart';

class FirebasePlanService implements Crud<Plan> {
  CollectionReference _collection;
  BaseFirebaseService _firebaseCrud;

  FirebasePlanService(String path) {
    _firebaseCrud = BaseFirebaseService(path);
    _collection = _firebaseCrud.collection;
  }

  @override
  Future<Plan> create(Plan item) async {
    return _firebaseCrud.create(item).then((response) {
      return Plan.fromMap(response);
    });
  }

  @override
  Future<Plan> read(Plan item) {
    return _firebaseCrud.read(item).then((response) {
      return Plan.fromMap(response);
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<Plan> update(Plan item) {
    return _firebaseCrud.update(item).then((response) {
      return Plan.fromMap(response);
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<Plan> delete(Plan item) {
    return _firebaseCrud.delete(item).then((response) {
      return Plan.fromMap(response);
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<List<Plan>> findBy(String field, value) async {
    return _firebaseCrud.findBy(field, value).then((response) {
      return response.map<Plan>((item) => Plan.fromMap(item)).toList();
    });
  }

  @override
  Future<List<Plan>> list() {
    return _firebaseCrud.list().then((response) {
      return response.map<Plan>((item) => Plan.fromMap(item)).toList();
    });
  }

}