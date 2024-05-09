import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class RegistrationConfirmationCustomerPage extends StatelessWidget {
  const RegistrationConfirmationCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Konfirmasi Pelanggan",
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
                const SizedBox(height: 30),
                Image.asset(
                  "assets/images/auth-image.png",
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 5),
                Text(
                  "Hanya satu langkah lagi! Silakan masukkan beberapa penyesuaian lebih lanjut untuk menikmati pengalaman kami.",
                  textAlign: TextAlign.center,
                  style:
                      appStyle(size: 16, color: mainBlack, fw: FontWeight.w300),
                ),
                const SizedBox(height: 30),
        
                ElevatedButton(
                  onPressed: () {
                    Routemaster.of(context).push('/personalization-customer');
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: const Size(0, 0),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Complete Detail Pengiriman",
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
