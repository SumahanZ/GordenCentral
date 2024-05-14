import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/internaltoko/repositories/implementations/internal_internaltoko_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/internaltoko/viewmodels/internal_internaltoko_viewmodel.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

class InternalInternalTokoJoinPage extends ConsumerStatefulWidget {
  const InternalInternalTokoJoinPage({super.key});

  @override
  ConsumerState<InternalInternalTokoJoinPage> createState() =>
      _InternalInternalTokoJoinPageState();
}

class _InternalInternalTokoJoinPageState
    extends ConsumerState<InternalInternalTokoJoinPage> {
  final _formKey = GlobalKey<FormState>();
  final _inviteCodeController = TextEditingController();

  @override
  void dispose() {
    _inviteCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(internalTokoViewModelProvider, (_, state) {
      state.maybeWhen(
          data: (data) {
            showPopupModal(
                context: context,
                title: "Berhasil",
                info: DialogType.success,
                animType: AnimType.scale,
                desc: "Berhasil mengirim permintaan bergabung ke toko!",
                onOkPress: () {
                  ref.invalidate(fetchInternals);
                  Routemaster.of(context).pop();
                });
          },
          error: (error, stackTrace) {
            if (error is ResponseAPIError) {
              showPopupModal(
                  context: context,
                  title: "Peringatan",
                  info: DialogType.error,
                  animType: AnimType.scale,
                  desc: error.message,
                  onOkPress: () {});
            } else if (error is RequestError) {
              showPopupModal(
                  context: context,
                  title: "Peringatan",
                  info: DialogType.error,
                  animType: AnimType.scale,
                  desc: "Error jaringan telah terjadi!",
                  onOkPress: () {});
            } else if (state is ApiError) {
              showPopupModal(
                  context: context,
                  title: "Peringatan",
                  info: DialogType.error,
                  animType: AnimType.scale,
                  desc: (error as ApiError).message,
                  onOkPress: () {});
            }
          },
          orElse: () => null);
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Join Toko Internal",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(children: [
                const TopSectionAuth(
                    name: "Join Toko",
                    description:
                        "Masukkan kode undangan untuk mengirim permintaan bergabung ke toko",
                    isAvatarNeeded: false),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: "Masukkan kode undangan toko",
                  controller: _inviteCodeController,
                  labelText: "Masukkan kode undangan toko",
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    }
                    if (!(value.isNotEmpty && value.length > 6)) {
                      return "Format kode undangan toko tidak valid. Silakan masukkan kode undangan yang valid.";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(internalTokoViewModelProvider.notifier)
                          .joinInternalThroughInviteCode(
                              inviteCode: _inviteCodeController.text)
                          .then((value) {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.purple,
                  ),
                  child: Text(
                    "Kirim Permintaan Join",
                    style: appStyle(
                        size: 16, color: Colors.white, fw: FontWeight.w500),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
