import 'dart:io';
import '../../contract/crud.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/base_user.dart';
import '../../models/singleton/singleton_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'base_firebase_service.dart';

class FirebaseUserService implements Crud<BaseUser> {
  CollectionReference _collection;
  BaseFirebaseService _firebaseCrud;

  FirebaseUserService(String path) {
    _firebaseCrud = BaseFirebaseService(path);
    _collection = _firebaseCrud.collection;
  }

  @override
  Future<BaseUser> create(BaseUser item) async {
    item.password = null;
    return _firebaseCrud.create(item).then((response) {
      return BaseUser.fromMap(response);
    });
  }

  @override
  Future<BaseUser> read(BaseUser item) {
    return _firebaseCrud.read(item).then((response) {
      return BaseUser.fromMap(response);
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<BaseUser> update(BaseUser item) {
    return _firebaseCrud.update(item).then((response) {
      return BaseUser.fromMap(response);
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<BaseUser> delete(BaseUser item) {
    return _firebaseCrud.delete(item).then((response) {
      return BaseUser.fromMap(response);
    }).catchError((error) {
      return null;
    });
  }

  @override
  Future<List<BaseUser>> findBy(String field, value) async {
    return _firebaseCrud.findBy(field, value).then((response) {
      return response.map<BaseUser>((item) => BaseUser.fromMap(item)).toList();
    });
  }

  @override
  Future<List<BaseUser>> list() {
    return _firebaseCrud.list().then((response) {
      return response.map<BaseUser>((item) => BaseUser.fromMap(item)).toList();
    });
  }

  Future<BaseUser> findUserByEmail(String email) async {
    List<BaseUser> list =  await findBy("email", email);

    if (list == null) return null;

    if (list.length == 1) {
      return list[0];
    } else if (list.length == 0) {
      //Log.e("Usuário não encontrado");
      return null;
    } else {
      //Log.e("Mais de 1 usuário com mesmo email");
      return null;
    }
  }

  @override
  Future<BaseUser> createAccount(BaseUser user) async {
    return await create(user);
  }

  @override
  Future<void> changePassword(String email, String password, String newPassword) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((result) {
      result.user.updatePassword(newPassword);
    });
  }

  @override
  Future<bool> changeName(String name) async {
    SingletonUser.instance.name = name;
    return await update(SingletonUser.instance) == null ? false : true;
  }

  @override
  Future<String> changeUserPhoto(File image) async {
//    String baseName = Path.basename(image.path);
//    String uID = SingletonUser.instance.id + baseName.substring(baseName.length - 4);
//    StorageReference storageReference = FirebaseStorage.instance.ref().child("users/${uID}");
//    StorageUploadTask uploadTask = storageReference.putFile(image);
//    return await uploadTask.onComplete.then((value) async {
//      return await storageReference.getDownloadURL().then((fileURL) async {
//        SingletonUser.instance.avatarURL = fileURL;
//        return await update(SingletonUser.instance) == null ? null : fileURL;
//      }).catchError((error) {
//        print(error.message);
//        return null;
//      });
//    }).catchError((error) {
//      print(error.message);
//      return null;
//    });
  }

  @override
  Future<BaseUser> currentUser() async {
    await Future.delayed(Duration(seconds: 2));//Flutter web precisa aguardar
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    print(currentUser);
    if (currentUser == null) {
      return null;
    } else {
      BaseUser user = await findUserByEmail(currentUser.email);
      if (user == null) {
        return null;
      }
      user.emailVerified = currentUser.isEmailVerified;
      return user;
    }
  }

  @override
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  @override
  Future<bool> isEmailVerified() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    bool emailVerified = currentUser.isEmailVerified;
    BaseUser user = await findUserByEmail(currentUser.email);
    if (user != null) {
      user.emailVerified = emailVerified;
      _collection.document(user.id).updateData(user.toMap());
    }
    return emailVerified;
  }

  @override
  Future<void> sendEmailVerification() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser.sendEmailVerification();
  }

}