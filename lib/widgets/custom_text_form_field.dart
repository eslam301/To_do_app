import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String title;
  final int maxLines;
  const CustomTextFormField({super.key,
    required this.title,
    required this.controller,
    required this.validator,
    this.maxLines =1,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      validator:  validator ,
      decoration: InputDecoration(
          hintText: title
      ),
    );
  }
}
