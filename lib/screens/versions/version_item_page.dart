import 'package:defaultwebflutter/models/version.dart';
import 'package:defaultwebflutter/services/firebase/firebase_version_service.dart';
import 'package:defaultwebflutter/strings.dart';
import 'package:defaultwebflutter/widgets/inputField.dart';
import 'package:defaultwebflutter/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class VersionItemPage extends StatefulWidget {

  @override
  _VersionItemPageState createState() => _VersionItemPageState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "Versão de App";
  }
}

class _VersionItemPageState extends State<VersionItemPage> {
  final _formKey = new GlobalKey<FormState>();

  String name, package, url, titulo, mensagem;
  int currentCode, minimumCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: form(),
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 10,),
          InputField(
            labelText: "App Name",
            onSaved: (value) {
              name = value;
            },
          ),
          SizedBox(height: 10,),
          InputField(
            labelText: "Package",
            onSaved: (value) {
              package = value;
            },
          ),
          SizedBox(height: 10,),
          InputField(
            labelText: "Store Url",
            onSaved: (value) {
              url = value;
            },
          ),
          SizedBox(height: 10,),
          InputField(
            labelText: "Current code",
            inputType: TextInputType.number,
            onSaved: (value) {
              currentCode = int.parse(value);
            },
          ),
          SizedBox(height: 10,),
          InputField(
            labelText: "Minimum code",
            inputType: TextInputType.number,
            onSaved: (value) {
              minimumCode = int.parse(value);
            },
          ),
          SizedBox(height: 30,),
          InputField(
            labelText: "Titulo",
            onSaved: (value) {
              titulo = value;
            },
          ),
          SizedBox(height: 10,),
          InputField(
            labelText: "Mensagem",
            onSaved: (value) {
              mensagem = value;
            },
          ),
          SizedBox(height: 10,),
          PrimaryButton(
            text: SALVAR,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
              } else {
                return;
              }

              Version version = Version()
                ..id = package
                ..name = name
                ..url = url
                ..currentCode = currentCode
                ..minimumCode = minimumCode
                ..notification = {
                  "title": titulo,
                  "body": mensagem,
                };

              FirebaseVersionService service = FirebaseVersionService("versions");
              service.create(version);
            },
          ),
        ],
      ),
    );
  }

}
