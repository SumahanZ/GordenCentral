import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/button_section_widget.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class PrelimenaryAuthPage extends ConsumerStatefulWidget {
  const PrelimenaryAuthPage({super.key});

  @override
  ConsumerState<PrelimenaryAuthPage> createState() =>
      _PrelimenaryAuthPageState();
}

class _PrelimenaryAuthPageState extends ConsumerState<PrelimenaryAuthPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Image.asset(
                  "assets/images/auth-image.png",
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: appStyle(
                            size: 24, color: Colors.black, fw: FontWeight.bold),
                        text: "Gorden",
                        children: [
                          TextSpan(
                            text: "Central",
                            style: appStyle(
                                size: 24,
                                color: Colors.black,
                                fw: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15.h),
                Text(
                  "Semua yang kamu butuhkan ada di satu tempat",
                  style:
                      appStyle(size: 28, color: mainBlack, fw: FontWeight.w600),
                ),
                SizedBox(height: 15.h),
                Text(
                  "Temukan kebutuhan produk gorden favorit Anda di Brand. E-commerce gorden terbesar di dunia telah tiba dalam bentuk mobile. Belanja sekarang!",
                  style:
                      appStyle(size: 16, color: mainBlack, fw: FontWeight.w300),
                ),
                SizedBox(height: 30.h),
                const ButtonSection(),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Sudah punya akun?  ",
                        style: appStyle(
                            size: 14, color: mainBlack, fw: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Routemaster.of(context).push("/login");
                      },
                      child: Text(
                        "Login",
                        style: appStyle(
                            size: 14,
                            color: Theme.of(context).colorScheme.primary,
                            fw: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
