import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/providers/auth_personalization_provider.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/token_push_notification_repository_impl.dart';
import 'package:tugas_akhir_project/core/auth/viewmodels/auth_viewmodel.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/widgets/global_providers/user_state.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class KaryawanPersonalizationPage extends ConsumerStatefulWidget {
  const KaryawanPersonalizationPage({super.key});

  @override
  ConsumerState<KaryawanPersonalizationPage> createState() =>
      _KaryawanPersonalizationPageState();
}

class _KaryawanPersonalizationPageState
    extends ConsumerState<KaryawanPersonalizationPage> {
  final _formKey = GlobalKey<FormState>();
  final _userCodeController = TextEditingController();
  final _inviteCodeController = TextEditingController();


  @override
  void dispose() {
    _userCodeController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCustomer = ref.watch(authNotifierProvider);
    ref.listen(authViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Berhasil",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Berhasil mendaftarkan akun internal!",
            onOkPress: () {
              ref.read(userStateProvider.notifier).update((state) {
                final newState = state?.copyWith(personalizationFinished: true);
                return newState;
              });
            });
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: (state.error as ResponseAPIError).message,
            onOkPress: () {
              // Routemaster.of(context).pop();
            });
      } else if (state is AsyncError && state.error is RequestError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Error jaringan telah terjadi!",
            onOkPress: () {
              // Routemaster.of(context).pop();
            });
      } else if (state is AsyncError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: (state.error as ApiError).message,
            onOkPress: () {
              // Routemaster.of(context).pop();
            });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personalisasi Internal",
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
                    name: 'Informasi Internal',
                    description:
                        "Lengkapi personalisasi informasi internal Anda",
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: "Masukkan kode undangan toko",
                    controller: _inviteCodeController,
                    labelText: "Kode Undangan Toko (Opsional)",
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return null;
                      }
                      if (!(value.isNotEmpty && value.length > 6)) {
                        return "Format kode undangan toko tidak valid. Harap masukkan kode undangan yang valid.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          authCustomer.role != null) {
                        ref
                            .read(pushNotificationRepositoryProvider)
                            .getTokenDatabase(ref)
                            .then((value) {
                          ref
                              .read(authViewModelProvider.notifier)
                              .signUpKaryawanPersonalization(
                                  authPersonalization: authCustomer,
                                  code: _userCodeController.text,
                                  role: authCustomer.role!,
                                  inviteCode: _inviteCodeController.text == ""
                                      ? null
                                      : _inviteCodeController.text,
                                  deviceToken: value ?? "")
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
                      "Selesaikan Personalisasi",
                      style: appStyle(
                          size: 18, color: Colors.white, fw: FontWeight.w500),
                    ),
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
