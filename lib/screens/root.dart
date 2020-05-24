import 'package:defaultwebflutter/screens/tabs_page.dart';

import '../models/base_user.dart';
import '../models/singleton/singleton_user.dart';
import '../presenter/user/user_presenter.dart';
import '../strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'login/login_page.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  EMAIL_NOT_VERIFIED,
  LOGGED_IN,
}

class Root extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _RootState();
}

class _RootState extends State<Root> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;

  UserPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = UserPresenter();
    getCurrentUser();
  }

  void getCurrentUser() async {
    var user = await presenter.currentUser();
    if (user == null) {
      onFailure("");
    } else {
      onSuccess(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
      case AuthStatus.NOT_LOGGED_IN:
        return LoginPage(loginCallback: loginCallback,);
      case AuthStatus.LOGGED_IN:
        return TabsPage(logoutCallback: logoutCallback,);
      default:
        return buildWaitingScreen();
    }
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Hero(
                tag: APP_NAME,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 100,
                    child: Image.asset("assets/logo_app.png"),
                  ),
                ),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

//  void checkLastVersionApp() async {
//    var last = await PreferencesUtil.getLastCheckUpdate();
//    if (last == null) {//First check
//      checkCurrentVersion();
//    } else {
//      var now = DateTime.now();
//      var dif = now.difference(last);
//      if (dif.inDays > 3) {//Check update
//        checkCurrentVersion();
//      }
//      checkCurrentVersion();
//    }
//  }

//  void checkCurrentVersion() async {
//    PackageInfo packageInfo = await PackageInfo.fromPlatform();
//    String packageName = packageInfo.packageName;
//    int buildNumber = int.parse(packageInfo.buildNumber);
//    versionApp = await VersionAppPresenter().checkCurrentVersion(packageName);
//    if (versionApp != null) {
//      if (versionApp.currentCode > buildNumber) {
//        setState(() => authStatus = AuthStatus.UPDATE_APP);
//      }
//      if (versionApp.minimumCode > buildNumber) {
//        setState(() {
//          minimumUpdate = false;
//        });
//      }
//    }
//    PreferencesUtil.setLastCheckUpdate(DateTime.now());//Atualizando ultimo check de versao
//  }

  void loginCallback() {
    if (SingletonUser.instance.emailVerified) {
      setState(() {
        authStatus = AuthStatus.LOGGED_IN;
      });
    } else {
      setState(() {
        authStatus = AuthStatus.EMAIL_NOT_VERIFIED;
      });
    }
    //updateNotificationToken();
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
    });
  }

  @override
  onFailure(String error) {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
    });
  }

  @override
  onSuccess(BaseUser user) async {
    SingletonUser.instance.update(user);
    if (user.emailVerified) {
      setState(() {
        authStatus = AuthStatus.LOGGED_IN;
      });
      //checkLastVersionApp();
    } else {
      setState(() {
        authStatus = AuthStatus.EMAIL_NOT_VERIFIED;
      });
    }
    //updateNotificationToken();
  }

//  void updateNotificationToken() async {
//    String notificationToken = await PreferencesUtil.getNotificationToken();
//    NotificationToken token = SingletonUser.instance.notificationToken;
//    if (token == null || token.token != notificationToken) {
//      SingletonUser.instance.notificationToken = NotificationToken(notificationToken);
//      presenter.update(SingletonUser.instance);
//    }
//  }

}