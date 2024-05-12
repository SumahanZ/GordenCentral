import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/customer/account/viewmodels/customer_account_viewmodel.dart';
import 'package:tugas_akhir_project/core/customer/account/widgets/customer_edit_profile_image_widget.dart';
import 'package:tugas_akhir_project/core/customer/settings/repositories/implementations/customer_setting_repository_impl.dart';
import 'package:tugas_akhir_project/models/account_request.dart';
import 'package:tugas_akhir_project/models/customer.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';

class CustomerEditProfilePage extends ConsumerStatefulWidget {
  const CustomerEditProfilePage({super.key});

  @override
  ConsumerState<CustomerEditProfilePage> createState() =>
      _CustomerEditProfilePageState();
}

class _CustomerEditProfilePageState
    extends ConsumerState<CustomerEditProfilePage> {
  File? selectedImage;
  bool imageFromfile = false;
  bool initializeFirst = true;
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

  void initializeTextControllers(Customer customer) {
    _nameController.text = customer.user?.name ?? "";
    _emailController.text = customer.user?.email ?? "";
    _phoneNumberController.text = customer.user?.phoneNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final customerInformationData = ref.watch(fetchCustomerInformation);
    ref.listen(customerAccountViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Berhasil",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Berhasil mengedit profil pelanggan!",
            onOkPress: () {
              ref.invalidate(fetchCustomerInformation);
              Routemaster.of(context).replace('/customer-account');
            });
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Terjadi kesalahan respons!",
            onOkPress: () {
              
            });
      } else if (state is AsyncError && state.error is RequestError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Error jaringan telah terjadi!",
            onOkPress: () {
              
            });
      } else if (state is AsyncError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: (state.error as ApiError).message,
            onOkPress: () {
              
            });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profil",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: customerInformationData.maybeWhen(
              data: (data) {
                return data.match(
                    (l) => Center(
                        child: Text(l.message,
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600))), (r) {
                  if (initializeFirst) {
                    initializeTextControllers(r);
                    initializeFirst = false;
                  }
                  return ref.watch(customerAccountViewModelProvider).when(
                      data: (data) {
                        return SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  const TopSectionAuth(
                                    isAvatarNeeded: false,
                                    name: 'Profil Pelanggan',
                                    description:
                                        "Konfigurasikan informasi profil pelanggan Anda",
                                  ),
                                  const SizedBox(height: 10),
                                  CustomerEditProfileImage(
                                    customer: r,
                                    pickTheImage: pickTheImage,
                                    imageFromfile: imageFromfile,
                                    selectedImage: selectedImage,
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                      hintText: "Masukkan nama Anda",
                                      controller: _nameController,
                                      labelText: "Nama",
                                      obscureText: false,
                                      validator: (value) {
                                        if (!(value!.isNotEmpty &&
                                            value.length > 6)) {
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
                                      if (!(value?.isValidPassword() ??
                                          false)) {
                                        return "Kata sandi harus mengandung minimal 8 karakter, termasuk setidaknya satu huruf besar dan kecil, dan satu angka";
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
                                            profilePhotoUrl:
                                                selectedImage?.path,
                                            password: _passwordController.text,
                                            phoneNumber:
                                                _phoneNumberController.text);

                                        ref
                                            .read(
                                                customerAccountViewModelProvider
                                                    .notifier)
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
                                      "Konfirmasi",
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
                      },
                      error: (error, stackTrace) =>
                          Center(child: Text(error.toString())),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()));
                });
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              orElse: () => const SizedBox.shrink())),
    );
  }
}
