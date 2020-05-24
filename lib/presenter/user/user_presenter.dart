import 'dart:io';

import '../../models/base_user.dart';
import '../../models/singleton/singleton_user.dart';
import '../../contract/crud.dart';
import '../../services/firebase/firebase_user_service.dart';
import '../../strings.dart';

class UserPresenter implements Crud<BaseUser> {

  var service = FirebaseUserService("users");

  dispose() {
    service = null;
  }

  @override
  Future<BaseUser> create(BaseUser item) async {
    return await service.create(item);
  }

  @override
  Future<BaseUser> read(BaseUser item) async {
    return await service.read(item);
  }

  @override
  Future<BaseUser> update(BaseUser item) async {
    return await service.update(item);
  }

  @override
  Future<BaseUser> delete(BaseUser item) async {
    return await service.create(item);
  }

  @override
  Future<List<BaseUser>> findBy(String field, value) async {
    return await service.findBy(field, value).then((value) {
      return value;
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<List<BaseUser>> list() {
    return null;
  }

  @override
  Future<bool> changeName(String name) async {
    await service.changeName(name);
  }

  @override
  Future<String> changeUserPhoto(File image) async {
//    await service.changeUserPhoto(image).then((URL) {
//      SingletonUser.instance.avatarURL = URL;
//      _view.onSuccess(SingletonUser.instance);
//    }).catchError((error) {
//      _view.onFailure(error.message);
//    });
  }

  @override
  Future<String> changePassword(String email, String password, String newPassword) async {
    await service.changePassword(email, password, newPassword);
  }

  @override
  Future<BaseUser> currentUser() async {
    return await service.currentUser();
  }

  @override
  Future<void> signOut() {
    return service.signOut();
  }

  @override
  Future<bool> isEmailVerified() {
    return service.isEmailVerified();
  }

  @override
  Future<void> sendEmailVerification() async {
    //await service.sendEmailVerification();
  }

}