import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/account/viewmodels/internal_account_viewmodel.dart';
import 'package:tugas_akhir_project/core/internal/account/widgets/internal_edit_profile_image_widget.dart';
import 'package:tugas_akhir_project/core/internal/settings/repositories/implementations/internal_settings_repository_impl.dart';
import 'package:tugas_akhir_project/models/account_request.dart';
import 'package:tugas_akhir_project/models/internal.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';

class InternalEditProfilePage extends ConsumerStatefulWidget {
  const InternalEditProfilePage({super.key});

  @override
  ConsumerState<InternalEditProfilePage> createState() =>
      _InternalEditProfilePageState();
}

class _InternalEditProfilePageState
    extends ConsumerState<InternalEditProfilePage> {
  bool imageFromfile = false;
  bool initializeFirst = true;
  File? selectedImage;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void pickTheImage() async {
    final image = await pickImage();
    if (image != null) {
      imageFromfile = true;
    }
    setState(() {
      selectedImage = image;
    });
  }

  void initializeTextControllers(Internal internal) {
    _nameController.text = internal.user?.name ?? "";
    _emailController.text = internal.user?.email ?? "";
    _phoneNumberController.text = internal.user?.phoneNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final internalInformationData = ref.watch(fetchInternalInformation);
    final manageStateProfile = ref.watch(internalAccountViewModelProvider);

    ref.listen(internalAccountViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
          context: context,
          title: "Berhasil",
          info: DialogType.success,
          animType: AnimType.scale,
          desc: "Berhasil mengonfigurasi informasi profil!",
          onOkPress: () {
            Routemaster.of(context).replace('/internal-account');
            ref.invalidate(fetchInternalInformation);
          },
        );
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
          context: context,
          title: "Peringatan",
          info: DialogType.error,
          animType: AnimType.scale,
          desc: "Telah terjadi kesalahan respons!",
          onOkPress: () {},
        );
      } else if (state is AsyncError && state.error is RequestError) {
        showPopupModal(
          context: context,
          title: "Peringatan",
          info: DialogType.error,
          animType: AnimType.scale,
          desc: "Error jaringan telah terjadi!",
          onOkPress: () {},
        );
      } else if (state is AsyncError) {
        showPopupModal(
          context: context,
          title: "Peringatan",
          info: DialogType.error,
          animType: AnimType.scale,
          desc: (state.error as ApiError).message,
          onOkPress: () {},
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: internalInformationData.when(data: (data) {
          return data.match((l) {
            return Center(child: Text(l.toString()));
          }, (r) {
            if (initializeFirst) {
              initializeTextControllers(r);
              initializeFirst = false;
            }
            return manageStateProfile.when(data: (data) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const TopSectionAuth(
                          isAvatarNeeded: false,
                          name: 'Edit Profile',
                          description: "Konfigurasikan profil internal.",
                        ),
                        const SizedBox(height: 20),
                        InternalEditProfileImage(
                          internal: r,
                          pickTheImage: pickTheImage,
                          selectedImage: selectedImage,
                          imageFromfile: imageFromfile,
                        ),
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
                        CustomTextField(
                          hintText: "Masukkan kata sandi Anda",
                          controller: _passwordController,
                          obscureText: true,
                          labelText: "Kata Sandi",
                          validator: (value) {
                            if (!(value?.isValidPassword() ?? false)) {
                              return "Kata sandi harus mengandung setidaknya 8 karakter, termasuk setidaknya satu huruf besar dan kecil, dan satu angka";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final accountRequest = AccountRequest(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  profilePhotoUrl: selectedImage?.path,
                                  password: _passwordController.text,
                                  phoneNumber: _phoneNumberController.text);

                              ref
                                  .read(
                                      internalAccountViewModelProvider.notifier)
                                  .editProfileInformation(
                                      request: accountRequest)
                                  .then((value) {});
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          child: Text(
                            "Confirm",
                            style: appStyle(
                                size: 16,
                                color: Colors.white,
                                fw: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }, error: (error, stackTrace) {
              return Center(child: Text(error.toString()));
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            });
          });
        }, error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
