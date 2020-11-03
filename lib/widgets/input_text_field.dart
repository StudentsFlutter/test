import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final Function onChanged;
  final Function validator;
  final String hintText;
  final bool isObscure;
  final TextInputType textInputType;
  const InputTextField({
    Key key,
    this.onChanged,
    this.hintText,
    this.isObscure,
    this.validator,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:6),
      width: 250,
      child: TextFormField(
        
        style : TextStyle(fontFamily: 'Scholar', fontSize: 20.0),
          validator: validator,
          obscureText: isObscure ?? false ,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          keyboardType: textInputType,
          onChanged: onChanged,
           decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hintText,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          // decoration: InputDecoration(
          //   hintText: hintText,
          //   contentPadding:
          //       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          //   border: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(9.0)),
          //   ),
          //   enabledBorder: OutlineInputBorder(
          //     borderSide:
          //         BorderSide(color: Theme.of(context).accentColor, width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(9.0)),
          //   ),
          //   focusedBorder: OutlineInputBorder(
          //     borderSide:
          //         BorderSide(color: Theme.of(context).accentColor, width: 2.0),
          //     borderRadius: BorderRadius.all(Radius.circular(9.0)),
          //   ),
          // )
          ),
    );
  }
}
