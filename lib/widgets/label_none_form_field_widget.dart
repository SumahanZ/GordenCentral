import 'package:flutter/material.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';

class NoLabelCustomTextField extends StatefulWidget {
  const NoLabelCustomTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.validator,
      this.keyboard,
      this.suffixIcon,
      this.initialValue, this.onChanged})
      : super(key: key);


  final Function(String value)? onChanged;
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? initialValue;

  @override
  State<NoLabelCustomTextField> createState() => _NoLabelCustomTextFieldState();
}

class _NoLabelCustomTextFieldState extends State<NoLabelCustomTextField> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
        keyboardType: widget.keyboard,
        initialValue: widget.initialValue,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          hintStyle:
              appStyle(size: 16, color: Colors.grey, fw: FontWeight.w500),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: widget.hintText,
          fillColor: const Color.fromARGB(255, 243, 243, 243),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2),
          ),
        ),
        controller: widget.controller,
        cursorHeight: 20,
        style: appStyle(size: 16, color: Colors.black, fw: FontWeight.w500),
        validator: widget.validator);
  }
}
