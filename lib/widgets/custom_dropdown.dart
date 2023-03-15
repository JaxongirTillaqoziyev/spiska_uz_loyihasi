import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<DropdownMenuItem>? items;
  final ValueChanged onChanged;
  final String hint;
  const CustomDropDown(
      {Key? key,
      required this.items,
      required this.onChanged,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isDense: true,
      isExpanded: true,
      decoration: InputDecoration(
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
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 25)),
      items: items,
      onChanged: onChanged,
      hint: Text(hint),
    );
  }
}
