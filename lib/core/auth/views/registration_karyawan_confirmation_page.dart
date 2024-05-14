import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class RegistrationConfirmationKaryawanPage extends ConsumerWidget {
  const RegistrationConfirmationKaryawanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Konfirmasi Karyawan",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                Image.asset(
                  "assets/images/auth-image.png",
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 5.h),
                Text(
                  "Hanya satu langkah lagi! Silakan masukkan kode pengguna dan kode undangan Anda untuk bergabung dengan toko secara instan.",
                  textAlign: TextAlign.center,
                  style:
                      appStyle(size: 16, color: mainBlack, fw: FontWeight.w300),
                ),
                SizedBox(height: 15.h),
                ElevatedButton(
                  onPressed: () {
                    Routemaster.of(context).push("/personalization-karyawan");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 20),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: const Size(0, 0),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Complete Detail Karyawan",
                    style: appStyle(
                        size: 14, color: Colors.white, fw: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
