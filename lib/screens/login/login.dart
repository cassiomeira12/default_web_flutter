import 'package:defaultwebflutter/contract/base_progress_contract.dart';
import 'package:defaultwebflutter/contract/base_result_contract.dart';
import 'package:defaultwebflutter/contract/login/login_contract.dart';
import 'package:defaultwebflutter/models/base_user.dart';
import 'package:defaultwebflutter/screens/home/home.dart';
import 'package:defaultwebflutter/services/firebase/firebase_login_service.dart';
import 'package:defaultwebflutter/utils/page_router.dart.dart';
import 'package:defaultwebflutter/widgets/primary_button.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';

import '../../strings.dart';
import '../../widgets/inputField.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements BaseProgressContract, BaseResultContract<BaseUser> {
  final _formKey = new GlobalKey<FormState>();

  FirebaseLoginService service;

  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    service = FirebaseLoginService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
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
                  logoImage(),
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
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: TextFormField(
        textAlign: TextAlign.center,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        style: Theme.of(context).textTheme.body2,
        decoration: InputDecoration(
          labelText: EMAIL,
          labelStyle: Theme.of(context).textTheme.body2,
          //hintText: "",
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).hintColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        validator: (value) => value.isEmpty ? EMAIL_INVALIDO : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: TextFormField(
        textAlign: TextAlign.center,
        maxLines: 1,
        keyboardType: TextInputType.text,
        obscureText: true,
        style: Theme.of(context).textTheme.body2,
        decoration: InputDecoration(
          labelText: SENHA,
          labelStyle: Theme.of(context).textTheme.body2,
          //hintText: "",
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).hintColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        validator: (value) => value.isEmpty ? SENHA_INVALIDA : null,
        onSaved: (value) => _password = value.trim(),
      ),
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
    if (validateAndSave()) {
      showProgress();
      var result = await service.signIn(_email, _password);
      if (result == null) {
        onFailure("Erro ao fazer Login");
      } else {
        onSuccess(result);
      }
    }
  }

  @override
  hideProgress() {
    print("hide Progress");
  }

  @override
  showProgress() {
    print("show Progress");
  }

  @override
  onFailure(String error) {
    hideProgress();
    print(error);
  }

  @override
  onSuccess(BaseUser result) {
    hideProgress();
    PageRouter.push(context, Home());
  }

}
