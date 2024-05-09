import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir_project/utils/enums/role_selection_enum.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class NoLabelCustomDropdown extends StatefulWidget {
  const NoLabelCustomDropdown(
      {Key? key,
      required this.hintText,
      this.values,
      this.validator,
      this.preValue,
      this.keyboard,
      required this.onChanged})
      : super(key: key);
  final Function(String?) onChanged;
  final TextInputType? keyboard;
  final List<String>? values;
  final String? preValue;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  State<NoLabelCustomDropdown> createState() => _NoLabelCustomDropdownState();
}

class _NoLabelCustomDropdownState extends State<NoLabelCustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      value: widget.preValue,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 243, 243, 243),
        contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(30),
        ),
        // Add more decoration..
      ),
      hint: Text(
        widget.hintText,
        style: appStyle(size: 16, color: Colors.grey, fw: FontWeight.w500),
      ),
      items: widget.values != null
          ? widget.values!
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: appStyle(
                        size: 14, color: mainBlack, fw: FontWeight.w500),
                  ),
                ),
              )
              .toList()
          : RoleSelection.values
              .map(
                (item) => DropdownMenuItem(
                  value: item.name,
                  child: Text(
                    item.name,
                    style: appStyle(
                        size: 14, color: mainBlack, fw: FontWeight.w500),
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
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
