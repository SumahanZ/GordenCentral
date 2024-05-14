import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomDropdownChart extends StatefulWidget {
  const CustomDropdownChart(
      {Key? key,
      this.values,
      this.validator,
      this.keyboard,
      this.initialValue,
      required this.onChanged})
      : super(key: key);
  final Function(String?) onChanged;
  final List<String>? values;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final String? initialValue;

  @override
  State<CustomDropdownChart> createState() => _CustomDropdownChartState();
}

class _CustomDropdownChartState extends State<CustomDropdownChart> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      isExpanded: true,
      value: widget.values?[0] ?? "Weekly",
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 243, 243, 243),
        contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5.w),
          borderRadius: BorderRadius.circular(5),
        ),
        // Add more decoration..
      ),
      items: (widget.values ?? ["Weekly", "Monthly", "Yearly"])
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style:
                    appStyle(size: 12, color: mainBlack, fw: FontWeight.w500),
              ),
            ),
          )
          .toList(),
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onChanged,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
