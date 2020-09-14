import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class CustomForm extends StatefulWidget {
  final List<CustomTextFormFieldd> listTextFormField;

  const CustomForm({Key key, this.listTextFormField}) : super(key: key);

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView.builder(
        itemCount: widget.listTextFormField.length,
        itemBuilder: (context, index) {
          return new CustomTextFormFieldd(
            labelText: widget.listTextFormField[index].labelText,
            icon: widget.listTextFormField[index].icon,
            helpText: widget.listTextFormField[index].helpText,
            keyboardType: widget.listTextFormField[index].keyboardType,
          );
        },
      ),
    );
  }
}
