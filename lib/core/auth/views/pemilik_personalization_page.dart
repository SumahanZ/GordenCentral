import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/token_push_notification_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/cart/repositories/sources/whatsapp_communicator_repository.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/providers/auth_personalization_provider.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/auth_repository_impl.dart';
import 'package:tugas_akhir_project/core/auth/viewmodels/auth_viewmodel.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/widgets/toko_configure_information_widget.dart';
import 'package:tugas_akhir_project/models/city.dart';
import 'package:tugas_akhir_project/models/province.dart';
import 'package:tugas_akhir_project/models/toko_information_request.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/extensions/either_extension.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_widget.dart';
import 'package:tugas_akhir_project/widgets/form_textarea_widget.dart';
import 'package:tugas_akhir_project/widgets/global_providers/user_state.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class PemilikPersonalizationPage extends ConsumerStatefulWidget {
  const PemilikPersonalizationPage({super.key});

  @override
  ConsumerState<PemilikPersonalizationPage> createState() =>
      _PemilikPersonalizationPageState();
}

class _PemilikPersonalizationPageState
    extends ConsumerState<PemilikPersonalizationPage> {
  bool validWhatsAppNumber = false;
  final _formKey = GlobalKey<FormState>();
  final _tokoNameController = TextEditingController();
  final _tokoPhoneNumberController = TextEditingController();
  final _tokoBioController = TextEditingController();
  final _tokoWhatsAppController = TextEditingController();
  final _tokoInviteCodeController = TextEditingController();
  final _countryController = TextEditingController(text: "Indonesia");
  final _streetController = TextEditingController();
  final _postalCodeController = TextEditingController();
  Province? selectedProvince;
  City? selectedCity;
  File? selectedImage;

  void pickTheImage() async {
    final image = await pickImage();
    setState(() {
      selectedImage = image;
    });
  }

  Future<bool> checkValidityNumber(String? text) async {
    final numberValid = await ref
        .read(whatsAppCommunicatorRepositoryProvider)
        .phoneNumberWhatsappValid(phoneNumber: text ?? "")
        .run();
    final numberIsValid = numberValid.unwrapRight() ?? false;

    return numberIsValid;
  }

  @override
  void dispose() {
    _tokoNameController.dispose();
    _tokoPhoneNumberController.dispose();
    _tokoBioController.dispose();
    _tokoWhatsAppController.dispose();
    _tokoInviteCodeController.dispose();
    _countryController.dispose();
    _streetController.dispose();
    _postalCodeController.dispose();
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
            desc: "Telah terjadi kesalahan respons!",
            onOkPress: () {});
      } else if (state is AsyncError && state.error is RequestError) {
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
            desc: (state.error as ApiError).message,
            onOkPress: () {});
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personalisasi Internal Pemilik",
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
                    name: 'Buat Toko',
                    description:
                        "Buat toko dengan konfigurasi yang kamu miliki",
                  ),
                  const SizedBox(height: 20),
                  TokoConfigureImage(
                    pickTheImage: pickTheImage,
                    selectedImage: selectedImage,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                      hintText: "Masukkan nama toko",
                      controller: _tokoNameController,
                      labelText: "Nama Toko",
                      obscureText: false,
                      validator: (value) {
                        if (!(value!.isNotEmpty && value.length > 6)) {
                          return "Format nama toko tidak valid. Harap masukkan nama yang valid.";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextArea(
                      hintText: "Masukkan bio toko",
                      controller: _tokoBioController,
                      labelText: "Bio Toko",
                      obscureText: false,
                      validator: (value) {
                        if (!(value!.isNotEmpty && value.length > 6)) {
                          return "Format bio toko tidak valid. Harap masukkan bio yang valid.";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  //logic for whatsapp later
                  CustomTextField(
                      hintText: "Masukkan nomor WhatsApp toko",
                      controller: _tokoWhatsAppController,
                      labelText: "Nomor WhatsApp Toko",
                      obscureText: false,
                      validator: (value) {
                        if (!(value!.isValidPhoneNumber())) {
                          return "Nomor WhatsApp tidak valid. Harap masukkan nomor yang valid.";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      hintText: "Masukkan kode undangan toko",
                      controller: _tokoInviteCodeController,
                      labelText: "Kode Undangan Toko",
                      obscureText: false,
                      validator: (value) {
                        if (!(value!.isNotEmpty && value.length > 6)) {
                          return "Kode undangan tidak valid. Harap masukkan kode undangan yang valid.";
                        } else {
                          return null;
                        }
                      }),

                  ref.watch(fetchProvinceslist).when(
                      data: (data) {
                        return data.match(
                            (l) => Center(
                                child: Text(l.message,
                                    style: appStyle(
                                        size: 16,
                                        color: mainBlack,
                                        fw: FontWeight.w600))), (r) {
                          return Column(
                            children: [
                              CustomDropdown(
                                values: r.map((e) => e.name).toList(),
                                labelText: "Provinsi",
                                hintText: "Masukkan Provinsi",
                                validator: (value) {
                                  if (value?.isEmpty ?? false) {
                                    return "Anda harus memilih sebuah provinsi.";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    selectedProvince = r.firstWhere(
                                        (element) => element.name == value,
                                        orElse: () => r[0]);
                                    selectedCity = null;
                                  });
                                },
                              ),
                              if (selectedProvince != null)
                                ref
                                    .watch(
                                        fetchCitieslist(selectedProvince!.id))
                                    .when(
                                        data: (data) {
                                          return data.match(
                                              (l) => Text(l.toString()), (r) {
                                            return Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    const SizedBox(height: 5),
                                                    CustomTextField(
                                                      labelText: "Negara",
                                                      hintText:
                                                          "Masukkan Negara",
                                                      controller:
                                                          _countryController,
                                                      obscureText: false,
                                                      readOnly: true,
                                                    ),
                                                    CustomDropdown(
                                                      values: r
                                                          .map((e) => e.name)
                                                          .toList(),
                                                      labelText: "Kota",
                                                      hintText: "Masukkan Kota",
                                                      validator: (value) {
                                                        if (value?.isEmpty ??
                                                            false) {
                                                          return "Anda harus memilih sebuah kota.";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedCity =
                                                              r.firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .name ==
                                                                      value,
                                                                  orElse: () =>
                                                                      r[0]);
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(height: 5),
                                                    if (selectedCity != null)
                                                      Column(
                                                        children: [
                                                          CustomTextField(
                                                            hintText:
                                                                "Masukkan alamat jalan",
                                                            controller:
                                                                _streetController,
                                                            labelText:
                                                                "Alamat Jalan",
                                                            obscureText: false,
                                                            validator: (value) {
                                                              if (!(value!
                                                                      .isNotEmpty &&
                                                                  value.length >
                                                                      6)) {
                                                                return "Format alamat tidak valid. Harap masukkan alamat yang valid.";
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          CustomTextField(
                                                            hintText:
                                                                "Masukkan kode pos",
                                                            controller:
                                                                _postalCodeController,
                                                            labelText:
                                                                "Kode Pos",
                                                            obscureText: false,
                                                            validator: (value) {
                                                              if (!(value!
                                                                  .isNotEmpty)) {
                                                                return "Harap masukkan kode pos yang valid.";
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              checkValidityNumber(
                                                                      _tokoWhatsAppController
                                                                          .text
                                                                          .replaceAll(
                                                                              "+",
                                                                              ""))
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  validWhatsAppNumber =
                                                                      value;
                                                                });
                                                              });

                                                              print("test");

                                                              if (_formKey
                                                                      .currentState!
                                                                      .validate() &&
                                                                  selectedProvince !=
                                                                      null &&
                                                                  selectedCity !=
                                                                      null &&
                                                                  authCustomer
                                                                          .role !=
                                                                      null) {
                                                                ref
                                                                    .read(
                                                                        pushNotificationRepositoryProvider)
                                                                    .getTokenDatabase(
                                                                        ref)
                                                                    .then(
                                                                        (value) {
                                                                  final tokoInformationRequest = TokoInformationRequest(
                                                                      bio: _tokoBioController
                                                                          .text,
                                                                      phoneNumber:
                                                                          _tokoPhoneNumberController
                                                                              .text,
                                                                      whatsAppURL:
                                                                          _tokoWhatsAppController
                                                                              .text,
                                                                      profilePhotoURL:
                                                                          selectedImage
                                                                              ?.path,
                                                                      name: _tokoNameController
                                                                          .text,
                                                                      inviteCode:
                                                                          _tokoInviteCodeController
                                                                              .text,
                                                                      streetAddress:
                                                                          _streetController
                                                                              .text,
                                                                      cityId:
                                                                          selectedCity!
                                                                              .id,
                                                                      country:
                                                                          _countryController
                                                                              .text,
                                                                      postalCode:
                                                                          _postalCodeController
                                                                              .text);

                                                                  ref
                                                                      .read(authViewModelProvider
                                                                          .notifier)
                                                                      .signUpPemilikPersonalization(
                                                                          authPersonalization:
                                                                              authCustomer,
                                                                          toko:
                                                                              tokoInformationRequest,
                                                                          role: authCustomer
                                                                              .role!,
                                                                          deviceToken: value ??
                                                                              "")
                                                                      .then(
                                                                          (value) {});
                                                                });
                                                              }
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          20),
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(
                                                                      50),
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary,
                                                            ),
                                                            child: Text(
                                                              "Confirm",
                                                              style: appStyle(
                                                                  size: 16,
                                                                  color: Colors
                                                                      .white,
                                                                  fw: FontWeight
                                                                      .w500),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          });
                                        },
                                        error: (error, stackTrace) => Center(
                                            child: Text(error.toString())),
                                        loading: () => const Center(
                                            child:
                                                CircularProgressIndicator())),
                            ],
                          );
                        });
                      },
                      error: ((error, stackTrace) =>
                          Center(child: Text(error.toString()))),
                      loading: () => const Center(
                            child: CircularProgressIndicator(),
                          )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
