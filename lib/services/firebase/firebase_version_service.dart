import 'package:cloud_firestore/cloud_firestore.dart';

import '../../contract/crud.dart';
import '../../models/version.dart';
import 'base_firebase_service.dart';

class FirebaseVersionService implements Crud<Version> {
  CollectionReference _collection;
  BaseFirebaseService _firebaseCrud;

  FirebaseVersionService(String path) {
    _firebaseCrud = BaseFirebaseService(path);
    _collection = _firebaseCrud.collection;
  }

  @override
  Future<Version> create(Version item) async {
    return _firebaseCrud.create(item).then((response) {
      return Version.fromMap(response);
    });
  }

  @override
  Future<Version> read(Version item) {
    return _firebaseCrud.read(item).then((response) {
      return Version.fromMap(response);
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<Version> update(Version item) {
    return _firebaseCrud.update(item).then((response) {
      return Version.fromMap(response);
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<Version> delete(Version item) {
    return _firebaseCrud.delete(item).then((response) {
      return Version.fromMap(response);
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<List<Version>> findBy(String field, value) async {
    return _firebaseCrud.findBy(field, value).then((response) {
      return response.map<Version>((item) => Version.fromMap(item)).toList();
    });
  }

  @override
  Future<List<Version>> list() {
    return _firebaseCrud.list().then((response) {
      return response.map<Version>((item) => Version.fromMap(item)).toList();
    });
  }

}