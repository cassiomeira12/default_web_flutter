import '../../models/base_user.dart';
import '../../services/firebase/firebase_login_service.dart';

class LoginPresenter {

  var service = FirebaseLoginService();

  dispose() {
    service = null;
  }

  @override
  signIn(String email, String password) {
    return service.signIn(email, password);
  }

  @override
  signInWithGoogle() {
    return service.signInWithGoogle();
  }

}