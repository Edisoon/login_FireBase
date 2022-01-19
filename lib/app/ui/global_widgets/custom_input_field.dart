// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  CustomInputField(
      {Key? key,
      this.onChanged,
      required this.label,
      this.inputType,
      this.isPassword = false,
      this.validator})
      : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: "",
        validator: widget.validator,
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (text) {
                  if (widget.validator != null) {
                    state.setValue(text);
                    state.validate();
                  }
                  if (widget.onChanged != null) {
                    widget.onChanged!(text);
                  }
                },
                obscureText: _obscureText,
                keyboardType: widget.inputType,
                decoration: InputDecoration(
                  suffixIcon: widget.isPassword
                      ? CupertinoButton(
                          child: Icon(_obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () {
                            _obscureText = !_obscureText;
                            setState(() {});
                          },
                        )
                      : Container(
                          width: 0,
                        ),
                  labelText: widget.label,
                  border: const OutlineInputBorder(),
                ),
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
            ],
          );
        });
  }
}
