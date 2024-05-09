import 'package:flutter/material.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class TopSectionAuth extends StatelessWidget {
  final String name;
  final bool isAvatarNeeded;
  final String description;
  const TopSectionAuth(
      {super.key,
      required this.name,
      required this.description,
      required this.isAvatarNeeded});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAvatarNeeded) const SizedBox(height: 20),
          if (isAvatarNeeded)
            const Center(
              child: CircleAvatar(
                radius: 50,
                child: Icon(Icons.abc),
              ),
            ),
          if (isAvatarNeeded) const SizedBox(height: 20),
          Text(
            name,
            style: appStyle(size: 26, color: mainBlack, fw: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
