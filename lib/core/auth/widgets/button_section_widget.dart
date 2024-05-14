import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Routemaster.of(context).push("/registration-internal");
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            minimumSize: const Size.fromHeight(50),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: Text(
            "Daftar sebagai internal toko",
            style: appStyle(size: 16, color: Colors.white, fw: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Routemaster.of(context).push("/registration-customer");
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: mainBlack,
                width: 1.w,
              ),
            ),
          ),
          child: Text(
            "Daftar sebagai customer",
            style: appStyle(size: 16, color: mainBlack, fw: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
