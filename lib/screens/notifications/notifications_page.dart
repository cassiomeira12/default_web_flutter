import 'package:defaultwebflutter/services/notifications/firebase_push_notifications.dart';
import 'package:defaultwebflutter/widgets/inputField.dart';
import 'package:defaultwebflutter/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../strings.dart';

class NotificationsPage extends StatefulWidget {

  @override
  _NotificationsPageState createState() => _NotificationsPageState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return NOTIFICATIONS;
  }
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _formKey = new GlobalKey<FormState>();

  String topic, token, title, message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        //width: MediaQuery.of(context).size.width / 2,
        width: 300,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: formNotification(),
          ),
        ),
      ),
    );
  }

  Widget formNotification() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputField(
            labelText: "Topico",
            inputType: TextInputType.text,
            //validator: (value) => value.isEmpty ? "Digite o topico" : null,
            onSaved: (result) {
              topic = result;
            },
          ),
          SizedBox(height: 10,),
          InputField(
            labelText: "Token",
            inputType: TextInputType.text,
            //validator: (value) => value.isEmpty ? "Digite o topico" : null,
            onSaved: (result) {
              token = result;
            },
          ),
          SizedBox(height: 20,),
          InputField(
            labelText: "Titulo",
            inputType: TextInputType.text,
            validator: (value) => value.isEmpty ? "Digite o titulo aqui" : null,
            onSaved: (result) {
              title = result;
            },
          ),
          SizedBox(height: 10,),
          InputField(
            labelText: "Mensagem",
            inputType: TextInputType.text,
            //textCapitalization: TextCapitalization.,
            validator: (value) => value.isEmpty ? "Digite a mensagem aqui" : null,
            onSaved: (result) {
              message = result;
            },
          ),
          SizedBox(height: 10,),
          PrimaryButton(
            text: "Salvar",
            onPressed: () {
              if (validateAndSave()) {
                FirebasePushNotifications.sendNotification(title, message, token.isEmpty ? null : token, topic.isEmpty ? null : topic);
              }
            },
          ),
        ],
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

}
