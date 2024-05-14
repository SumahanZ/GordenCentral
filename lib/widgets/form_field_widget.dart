import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.labelText,
      this.validator,
      this.keyboard,
      this.suffixIcon,
      this.readOnly = false,
      this.onChanged,
      required this.obscureText,
      this.initialValue,
      this.onSaved})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? initialValue;
  final String labelText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 10),
          child: Text(widget.labelText,
              style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500)),
        ),
        TextFormField(
            onFieldSubmitted: widget.onSaved,
            readOnly: widget.readOnly ? true : false,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboard,
            obscureText: widget.obscureText ? !isOn : isOn,
            initialValue: widget.initialValue,
            decoration: InputDecoration(
              helperText: "",
              errorMaxLines: 3,
              filled: true,
              fillColor: const Color.fromARGB(255, 243, 243, 243),
              // labelText: labelText,
              // labelStyle: appStyle(size: 16, color: mainBlack, fw: FontWeight.w500),
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: widget.hintText,
              suffixIcon: widget.obscureText == true
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                      child: GestureDetector(
                        onTap: () {
                          if (widget.obscureText) {
                            setState(
                              () {
                                isOn = !isOn;
                              },
                            );
                          }
                        },
                        child: Icon(isOn
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                    )
                  : null,
              suffixIconColor: Colors.black,
              hintStyle:
                  appStyle(size: 16, color: Colors.grey, fw: FontWeight.w500),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.red, width: 0.5.w),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.red, width: 0.5.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 2.w),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.black, width: 0.5.w),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.black, width: 0.5.w),
              ),
            ),
            controller: widget.controller,
            cursorHeight: 20,
            style: appStyle(size: 16, color: Colors.black, fw: FontWeight.w500),
            validator: widget.validator),
      ],
    );
  }
}
