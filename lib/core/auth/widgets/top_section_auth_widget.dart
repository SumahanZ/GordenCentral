import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          if (isAvatarNeeded) SizedBox(height: 20.h),
          if (isAvatarNeeded)
            Center(
              child: CircleAvatar(
                radius: 50.r,
                child: Icon(Icons.abc),
              ),
            ),
          if (isAvatarNeeded) SizedBox(height: 20.h),
          Text(
            name,
            style: appStyle(size: 26, color: mainBlack, fw: FontWeight.w600),
          ),
          SizedBox(height: 5.h),
          Text(
            description,
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
