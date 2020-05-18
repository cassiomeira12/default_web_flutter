import 'package:flutter/material.dart';

class InputField extends StatefulWidget {



  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      style: Theme.of(context).textTheme.body2,
      decoration: InputDecoration(
        labelText: "Email",
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
      //validator: (value) => value.isEmpty ? EMAIL_INVALIDO : null,
      //onSaved: (value) => _email = value.trim(),
    );
  }
}
