import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/internaltoko/repositories/implementations/internal_internaltoko_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/internaltoko/viewmodels/internal_internaltoko_viewmodel.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

class InternalInternalTokoAddPage extends ConsumerStatefulWidget {
  const InternalInternalTokoAddPage({super.key});

  @override
  ConsumerState<InternalInternalTokoAddPage> createState() =>
      _InternalInternalTokoAddPageState();
}

class _InternalInternalTokoAddPageState
    extends ConsumerState<InternalInternalTokoAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _targetUserCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen(internalTokoViewModelProvider, (_, state) {
      state.maybeWhen(
          data: (data) {
            showPopupModal(
                context: context,
                title: "Sukses",
                info: DialogType.success,
                animType: AnimType.scale,
                desc: "Berhasil menambahkan internal ke toko!",
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
            } else if (state is AsyncError) {
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
            "Tambah Internal Toko",
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
                    name: "Tambah Internal",
                    description: "Tambahkan internal ke toko Anda",
                    isAvatarNeeded: false),
                const SizedBox(height: 20),
                CustomTextField(
                    hintText: "Masukkan kode pengguna internal",
                    controller: _targetUserCodeController,
                    labelText: "Kode Pengguna",
                    obscureText: false,
                    validator: (value) {
                      if (!(value!.isNotEmpty && value.length == 8)) {
                        return "Format kode pengguna tidak valid. Silakan masukkan format kode pengguna yang valid.";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(internalTokoViewModelProvider.notifier)
                          .addInternalThroughUserCode(
                              targetUserCode: _targetUserCodeController.text)
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
                    "Tambah Internal",
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
