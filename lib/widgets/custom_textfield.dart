import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
class CustomTextfield extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  String? Function(String? input)? validator;
  int minLine;
  int? maxLine;
  List<TextInputFormatter>? inputFormats;
  TextInputType? keyboardType;
  TextCapitalization textCapitalization;
  CustomTextfield({
    Key? key,
    this.controller,
    this.validator,
    required this.hintText,
    this.minLine = 1,
    this.maxLine,
    this.inputFormats,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      minLines: minLine,
      maxLines: maxLine,
      inputFormatters: inputFormats,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xff2084E9), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xff2084E9), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.red, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.red, width: 1)),
      ),
    );
  }
}

class TextFieldForAddProduct extends StatelessWidget {
  const TextFieldForAddProduct({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final FormFieldValidator? validator;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
        fillColor: Colors.grey.shade200,
        filled: true,
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey.shade600,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent)),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onChanged: onChanged,
      inputFormatters: [
        if (suffixIcon != null) MaskTextInputFormatter(mask: "####-##-##"),
      ],
    );
  }
}
