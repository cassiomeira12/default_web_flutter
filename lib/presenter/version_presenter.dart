import '../services/firebase/firebase_version_service.dart';
import '../contract/crud.dart';
import '../models/version.dart';

class VersionPresenter implements Crud<Version> {

  var service = FirebaseVersionService("versions");

  dispose() {
    service = null;
  }

  @override
  Future<Version> create(Version item) async {
    return await service.create(item);
  }

  @override
  Future<Version> read(Version item) async {
    return await service.read(item);
  }

  @override
  Future<Version> update(Version item) async {
    return await service.update(item);
  }

  @override
  Future<Version> delete(Version item) async {
    return await service.create(item);
  }

  @override
  Future<List<Version>> findBy(String field, value) async {
    return await service.findBy(field, value).then((value) {
      return value;
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<List<Version>> list() async {
    return await service.list().then((value) {
      return value;
    }).catchError((error) {
      return null;
    });
  }

}