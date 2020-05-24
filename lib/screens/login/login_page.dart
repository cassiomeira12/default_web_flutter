import 'package:defaultwebflutter/contract/base_progress_contract.dart';
import 'package:defaultwebflutter/contract/base_result_contract.dart';
import 'package:defaultwebflutter/models/base_user.dart';
import 'package:defaultwebflutter/models/singleton/singleton_user.dart';
import 'package:defaultwebflutter/presenter/login/login_presenter.dart';
import 'package:defaultwebflutter/screens/home/home_page.dart';
import 'package:defaultwebflutter/services/firebase/firebase_login_service.dart';
import 'package:defaultwebflutter/utils/page_router.dart.dart';
import 'package:defaultwebflutter/widgets/primary_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../strings.dart';
import '../../widgets/inputField.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.loginCallback});

  final VoidCallback loginCallback;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements BaseProgressContract, BaseResultContract<BaseUser> {
  final _formKey = new GlobalKey<FormState>();

  LoginPresenter presenter;

  String _email;
  String _password;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    presenter = LoginPresenter();
  }

  @override
  void dispose() {
    super.dispose();
    presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        child: body(),
        inAsyncCall: loading,
        progressIndicator: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget body() {
    return Stack(
      children: [
        Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
            ),
          ],
        ),
        Center(
          child: loginCard(),
        ),
      ],
    );
  }

  Widget loginCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
//      constraints: BoxConstraints(
//        minWidth: 200,
//        maxHeight: 200,
//      ),
//      width: MediaQuery.of(context).size.width / 2.5,
//      height: MediaQuery.of(context).size.height / 1.5,
      width: 380,
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //logoImage(),
                  titleText(),
                  emailInput(),
                  passwordInput(),
                  loginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logoImage() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.green,
    );
  }

  Widget titleText() {
    return Container(
      child: Text(
        LOGIN,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: InputField(
        labelText: EMAIL,
        validator: (value) => value.isEmpty ? EMAIL_INVALIDO : null,
        onSaved: (value) => _email = value.trim(),
      ),
//      child: TextFormField(
//        textAlign: TextAlign.center,
//        maxLines: 1,
//        keyboardType: TextInputType.text,
//        style: Theme.of(context).textTheme.body2,
//        decoration: InputDecoration(
//          labelText: EMAIL,
//          labelStyle: Theme.of(context).textTheme.body2,
//          //hintText: "",
//          errorBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(8),
//            borderSide: BorderSide(color: Theme.of(context).errorColor),
//          ),
//          focusedErrorBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(8),
//            borderSide: BorderSide(color: Theme.of(context).errorColor),
//          ),
//          enabledBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(8),
//            borderSide: BorderSide(color: Theme.of(context).hintColor),
//          ),
//          focusedBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(8),
//            borderSide: BorderSide(color: Theme.of(context).primaryColor),
//          ),
//        ),
//        validator: (value) => value.isEmpty ? EMAIL_INVALIDO : null,
//        onSaved: (value) => _email = value.trim(),
//      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: InputField(
        labelText: SENHA,
        obscureText: true,
        validator: (value) => value.isEmpty ? SENHA_INVALIDA : null,
        onSaved: (value) => _password = value.trim(),
      ),
//
//      child: TextFormField(
//        textAlign: TextAlign.center,
//        maxLines: 1,
//        keyboardType: TextInputType.text,
//        obscureText: true,
//        style: Theme.of(context).textTheme.body2,
//        decoration: InputDecoration(
//          labelText: SENHA,
//          labelStyle: Theme.of(context).textTheme.body2,
//          //hintText: "",
//          errorBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(8),
//            borderSide: BorderSide(color: Theme.of(context).errorColor),
//          ),
//          focusedErrorBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(8),
//            borderSide: BorderSide(color: Theme.of(context).errorColor),
//          ),
//          enabledBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(8),
//            borderSide: BorderSide(color: Theme.of(context).hintColor),
//          ),
//          focusedBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(8),
//            borderSide: BorderSide(color: Theme.of(context).primaryColor),
//          ),
//        ),
//        validator: (value) => value.isEmpty ? SENHA_INVALIDA : null,
//        onSaved: (value) => _password = value.trim(),
//      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: PrimaryButton(
        text: ENTRAR,
        onPressed: validateAndSubmit,
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    //if (validateAndSave()) {
    if (true) {
      showProgress();
      var result = await presenter.signIn("cassiomeirasilva12@gmail.com", "123456");
      //var result = await presenter.signIn(_email, _password);
      if (result == null) {
        onFailure("Erro ao fazer Login");
      } else {
        onSuccess(result);
      }
    }
  }

  @override
  hideProgress() {
    setState(() {
      loading = false;
    });
  }

  @override
  showProgress() {
    setState(() {
      loading = true;
    });
  }

  @override
  onFailure(String error) {
    hideProgress();
    print(error);
  }

  @override
  onSuccess(BaseUser result) {
    hideProgress();
    SingletonUser.instance.update(result);
    widget.loginCallback();
  }

}
