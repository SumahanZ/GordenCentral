import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/token_push_notification_repository_impl.dart';
import 'package:tugas_akhir_project/core/auth/viewmodels/auth_viewmodel.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/horizontal_line.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authViewModelProvider, (_, state) {
      if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: (state.error as ApiError).message,
            onOkPress: () {});
      } else if (state is AsyncError && state.error is RequestError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: (state.error as ApiError).message,
            onOkPress: () {});
      } else if (state is AsyncError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: (state.error as ApiError).message,
            onOkPress: () {});
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Login",
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
            child: Column(
              children: [
                SizedBox(height: 15.h),
                const TopSectionAuth(
                  isAvatarNeeded: true,
                  name: 'Login',
                  description: "Login untuk melanjutkan penggunaan aplikasi",
                ),
                SizedBox(height: 15.h),
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
                SizedBox(height: 5.h),
                CustomTextField(
                  hintText: "Masukkan kata sandi Anda",
                  controller: _passwordController,
                  obscureText: true,
                  labelText: "Kata Sandi",
                  validator: (value) {
                    if (!(value?.isValidPassword() ?? false)) {
                      return "Kata sandi harus terdiri dari setidaknya 8 karakter, termasuk setidaknya satu huruf besar dan kecil, satu angka, dan satu karakter khusus.";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(pushNotificationRepositoryProvider)
                          .getTokenDatabase(ref)
                          .then((value) {
                        ref
                            .read(authViewModelProvider.notifier)
                            .login(
                                deviceToken: value ?? "",
                                password: _passwordController.text,
                                email: _emailController.text)
                            .then((value) {});
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Login",
                    style: appStyle(
                        size: 18, color: Colors.white, fw: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Belum punya akun? Daftar sebagai",
                        style: appStyle(
                            size: 14, color: mainBlack, fw: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Routemaster.of(context).push("/registration-internal");
                      },
                      child: Text(
                        "Internal Toko",
                        style: appStyle(
                            size: 14,
                            color: Theme.of(context).colorScheme.primary,
                            fw: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    const HorizontalOrLine(label: "ATAU", height: 1),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        Routemaster.of(context).push("/registration-customer");
                      },
                      child: Text(
                        "Customer",
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
