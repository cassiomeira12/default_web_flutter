import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String labelText;
  final TextInputType inputType;

  TextAlign textAlign;
  bool obscureText;
  TextCapitalization textCapitalization;

  TextEditingController controller;
  FormFieldValidator<String> validator;
  FormFieldSetter<String> onSaved;
  ValueChanged<String> onChanged;

  InputField({
    @required this.labelText,

    this.inputType = TextInputType.text,
    this.textAlign = TextAlign.center,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,

    this.controller,
    this.validator,
    this.onSaved,
    this.onChanged,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      style: Theme.of(context).textTheme.body2,
      textAlign: TextAlign.center,
      obscureText: widget.obscureText,
      textCapitalization: widget.textCapitalization,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.body2,
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
      controller: widget.controller,
      validator: widget.validator == null ? (value) => value.isEmpty ? "${widget.labelText} não pode ser vazio" : null : widget.validator,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
    );
  }
}
