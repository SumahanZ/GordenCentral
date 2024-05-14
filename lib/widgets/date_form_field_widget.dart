import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class DateCustomTextField extends StatefulWidget {
  const DateCustomTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.labelText,
      this.validator,
      this.keyboard,
      this.initialValue,
      this.onChangedDate,
      this.minTime,
      this.isDisabled = false,
      this.maxTime})
      : super(key: key);

  final TextEditingController controller;
  final DateTime? minTime;
  final bool isDisabled;
  final DateTime? maxTime;
  final String hintText;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Function(DateTime)? onChangedDate;
  final String labelText;

  @override
  State<DateCustomTextField> createState() => _DateCustomTextFieldState();
}

class _DateCustomTextFieldState extends State<DateCustomTextField> {
  String? dateText;

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
            readOnly: true,
            keyboardType: widget.keyboard,
            initialValue: widget.initialValue,
            decoration: InputDecoration(
              helperText: "",
              errorMaxLines: 3,
              filled: true,
              fillColor: const Color.fromARGB(255, 243, 243, 243),
              hintText: widget.hintText,
              suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                child: GestureDetector(
                  onTap: () async {
                    widget.isDisabled == false
                        ? await DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            //promos should only last max a month for safety measures
                            maxTime: widget.maxTime,
                            minTime: widget.minTime,
                            onConfirm: widget.onChangedDate,
                            locale: LocaleType.en)
                        : () {};
                  },
                  child: const Icon(AntIcons.calendarOutlined),
                ),
              ),
              suffixIconColor: !widget.isDisabled ? Colors.black : Colors.grey,
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
