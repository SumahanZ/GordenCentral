import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class DisableCustomTextField extends StatefulWidget {
  const DisableCustomTextField(
      {Key? key,
      required this.labelText,
      required this.defaultValue,
      this.validator,
      this.keyboard,
      required this.value,
      this.textEditingController})
      : super(key: key);
  final TextEditingController? textEditingController;
  final TextInputType? keyboard;
  final String defaultValue;
  final String? Function(String?)? validator;
  final String? value;
  final String labelText;

  @override
  State<DisableCustomTextField> createState() => _DisableCustomTextFieldState();
}

class _DisableCustomTextFieldState extends State<DisableCustomTextField> {
  @override
  void initState() {
    super.initState();
    widget.textEditingController?.value = widget.textEditingController!.value
        .copyWith(text: widget.value ?? widget.defaultValue);
  }

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
            key: widget.key,
            enabled: false,
            controller: widget.textEditingController,
            keyboardType: widget.keyboard,
            decoration: InputDecoration(
              helperText: "",
              errorMaxLines: 3,
              filled: true,
              fillColor: Colors.grey.withOpacity(0.3),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.red, width: 0.5.w),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.black, width: 0.5.w),
              ),
            ),
            cursorHeight: 20,
            style: appStyle(
                size: 16,
                color: Colors.grey.withOpacity(1),
                fw: FontWeight.w500),
            validator: widget.validator),
      ],
    );
  }
}
