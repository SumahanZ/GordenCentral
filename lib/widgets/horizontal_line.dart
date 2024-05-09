import 'package:flutter/material.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';

class HorizontalOrLine extends StatelessWidget {
  const HorizontalOrLine({super.key, 
    required this.label,
    required this.height,
  });

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
      // const SizedBox(
      //   height: 10,
      //     margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      //     child: VerticalDivider(
      //       color: Colors.grey,
      //     )),
      Text(label, style: appStyle(size: 14, color: Colors.black, fw: FontWeight.w500)),
      // const SizedBox(
      //   height: 10,
      //     margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      //     child: VerticalDivider(
      //       color: Colors.grey,
      //     )),
    ]);
  }
}
