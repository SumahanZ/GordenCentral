import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/providers/auth_personalization_provider.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class RegisterPageCustomer extends ConsumerStatefulWidget {
  const RegisterPageCustomer({super.key});

  @override
  ConsumerState<RegisterPageCustomer> createState() =>
      _RegisterPageCustomerState();
}

class _RegisterPageCustomerState extends ConsumerState<RegisterPageCustomer> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? storedPassword;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registration Customer",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onTap: () => Routemaster.of(context).pop(),
            child: backButtonStyle,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TopSectionAuth(
                    isAvatarNeeded: false,
                    name: 'Register',
                    description:
                        "Register sebagai customer to memakai aplikasi",
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                      hintText: "Masukkan nama Anda",
                      controller: _nameController,
                      labelText: "Nama",
                      obscureText: false,
                      validator: (value) {
                        if (!(value!.isNotEmpty && value.length > 6)) {
                          return "Format nama tidak valid. Harap masukkan nama yang valid.";
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    hintText: "Masukkan email Anda",
                    controller: _emailController,
                    labelText: "Email",
                    obscureText: false,
                    validator: (value) {
                      if (!(value?.isValidEmail() ?? false)) {
                        return "Format email tidak valid. Harap masukkan alamat email yang valid.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    hintText: "Masukkan kata sandi Anda",
                    controller: _passwordController,
                    obscureText: true,
                    labelText: "Kata Sandi",
                    validator: (value) {
                      if (!(value?.isValidPassword() ?? false)) {
                        return "Kata sandi harus terdiri dari minimal 8 karakter, termasuk setidaknya satu huruf besar dan kecil, dan satu angka";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    hintText: "Konfirmasi kata sandi Anda",
                    controller: _confirmPasswordController,
                    obscureText: false,
                    labelText: "Konfirmasi Kata Sandi",
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "Kolom konfirmasi kata sandi harus diisi.";
                      } else if (value != _passwordController.text) {
                        return "Nilai pada kolom konfirmasi kata sandi tidak sesuai dengan kata sandi.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final authCustomerPersonalization = AuthPersonalization(
                            name: _nameController.text,
                            password: _passwordController.text,
                            email: _emailController.text);
                        ref
                            .read(authNotifierProvider.notifier)
                            .setPersonalization(authCustomerPersonalization);

                        Routemaster.of(context).push("/confirmation-customer");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      "Register",
                      style: appStyle(
                          size: 18, color: Colors.white, fw: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Sudah memiliki akun?  ",
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
      ),
    );
  }
}
