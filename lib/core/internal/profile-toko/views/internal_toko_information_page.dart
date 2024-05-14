import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/customer/cart/repositories/sources/whatsapp_communicator_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/viewmodels/toko_information_viewmodel.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/widgets/toko_configure_information_widget.dart';
import 'package:tugas_akhir_project/core/internal/settings/repositories/implementations/internal_settings_repository_impl.dart';
import 'package:tugas_akhir_project/models/address.dart';
import 'package:tugas_akhir_project/models/city.dart';
import 'package:tugas_akhir_project/models/province.dart';
import 'package:tugas_akhir_project/models/toko.dart';
import 'package:tugas_akhir_project/models/toko_information_request.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/extensions/either_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_widget.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/form_textarea_widget.dart';

class InternalTokoInformationPage extends ConsumerStatefulWidget {
  const InternalTokoInformationPage({super.key});

  @override
  ConsumerState<InternalTokoInformationPage> createState() =>
      _InternalTokoInformationPageState();
}

class _InternalTokoInformationPageState
    extends ConsumerState<InternalTokoInformationPage> {
  File? selectedImage;
  void pickTheImage() async {
    final image = await pickImage();
    setState(() {
      selectedImage = image;
    });
  }

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
  bool initializeFirstAddress = true;
  bool initializeFirstToko = true;
  bool validWhatsAppNumber = false;

  void initializeFields(Address address, List<Province> provinceList) {
    _streetController.text = address.streetAddress;
    _countryController.text = address.country ?? "";
    _postalCodeController.text = address.postalCode ?? "";
    selectedProvince = address.city?.province ?? provinceList[0];
  }

  void initializeFieldsToko(Toko? toko) {
    _tokoNameController.text = toko?.name ?? "";
    _tokoPhoneNumberController.text = toko?.phoneNumber ?? "";
    _tokoBioController.text = toko?.bio ?? "";
    _tokoWhatsAppController.text = toko?.whatsAppURL ?? "";
    _tokoInviteCodeController.text = toko?.inviteCode ?? "";
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
    ref.listen(tokoInformationViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Berhasil",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Berhasil mengonfigurasi informasi toko!",
            onOkPress: () {
              ref.invalidate(fetchInternalInformation);
              Routemaster.of(context).replace('/internal-account');
            });
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Terjadi kesalahan respons!",
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
          "Informasi Toko",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ref.watch(fetchTokoInformationProvider).maybeWhen(data: (data) {
          return data.match((l) {
            return ref.watch(tokoInformationViewModelProvider).when(
                data: (data) {
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: [
                          const TopSectionAuth(
                            isAvatarNeeded: false,
                            name: 'Informasi Toko',
                            description: "Konfigurasikan informasi toko Anda",
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
                          CustomTextField(
                              hintText: "Masukkan nomor WhatsApp toko",
                              controller: _tokoWhatsAppController,
                              labelText: "WhatsApp Toko",
                              obscureText: false,
                              validator: (value) {
                                if (!(value!.isValidPhoneNumber())) {
                                  return "Format nomor telepon toko tidak valid. Harap masukkan nomor telepon yang valid.";
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
                          // CustomTextField(
                          //     hintText: "Enter toko WhatsApp url",
                          //     controller: _tokoWhatsAppController,
                          //     labelText: "Toko WhatsApp",
                          //     obscureText: false,
                          //     validator: (value) {
                          //       if (!(value!.isNotEmpty && value.length > 6)) {
                          //         return "Invalid WhatsApp url. Please enter a valid url.";
                          //       } else {
                          //         return null;
                          //       }
                          //     }),
                          // const SizedBox(
                          //   height: 10,
                          // ),
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

                          const SizedBox(
                            height: 10,
                          ),
                          ref.watch(fetchProvinceslistFromProfileToko).when(
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
                                                (element) =>
                                                    element.name == value,
                                                orElse: () => r[0]);
                                            selectedCity = null;
                                          });
                                        },
                                      ),
                                      if (selectedProvince != null)
                                        ref
                                            .watch(
                                                fetchCitieslistFromProfileToko(
                                                    selectedProvince!.id))
                                            .when(
                                                data: (data) {
                                                  return data.match(
                                                      (l) => Text(l.toString()),
                                                      (r) {
                                                    return Column(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            const SizedBox(
                                                                height: 5),
                                                            CustomTextField(
                                                              labelText:
                                                                  "Negara",
                                                              hintText:
                                                                  "Masukkan Negara",
                                                              controller:
                                                                  _countryController,
                                                              obscureText:
                                                                  false,
                                                              readOnly: true,
                                                            ),
                                                            CustomDropdown(
                                                              values: r
                                                                  .map((e) =>
                                                                      e.name)
                                                                  .toList(),
                                                              labelText: "Kota",
                                                              hintText:
                                                                  "Masukkan Kota",
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                        ?.isEmpty ??
                                                                    false) {
                                                                  return "Anda harus memilih sebuah kota.";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  selectedCity = r.firstWhere(
                                                                      (element) =>
                                                                          element
                                                                              .name ==
                                                                          value,
                                                                      orElse: () =>
                                                                          r[0]);
                                                                });
                                                              },
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            if (selectedCity !=
                                                                null)
                                                              Column(
                                                                children: [
                                                                  CustomTextField(
                                                                    hintText:
                                                                        "Masukkan alamat jalan",
                                                                    controller:
                                                                        _streetController,
                                                                    labelText:
                                                                        "Alamat Jalan",
                                                                    obscureText:
                                                                        false,
                                                                    validator:
                                                                        (value) {
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
                                                                      height:
                                                                          5),
                                                                  CustomTextField(
                                                                    hintText:
                                                                        "Masukkan kode pos",
                                                                    controller:
                                                                        _postalCodeController,
                                                                    labelText:
                                                                        "Kode Pos",
                                                                    obscureText:
                                                                        false,
                                                                    validator:
                                                                        (value) {
                                                                      if (!(value!
                                                                          .isNotEmpty)) {
                                                                        return "Harap masukkan kode pos yang valid.";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      checkValidityNumber(_tokoWhatsAppController.text.replaceAll(
                                                                              "+",
                                                                              ""))
                                                                          .then(
                                                                              (value) {
                                                                        setState(
                                                                            () {
                                                                          validWhatsAppNumber =
                                                                              value;
                                                                        });
                                                                      });

                                                                      if (_formKey
                                                                              .currentState!
                                                                              .validate() &&
                                                                          selectedProvince !=
                                                                              null &&
                                                                          selectedCity !=
                                                                              null) {
                                                                        final tokoInformationRequest =
                                                                            TokoInformationRequest(
                                                                          bio: _tokoBioController
                                                                              .text,
                                                                          phoneNumber:
                                                                              _tokoPhoneNumberController.text,
                                                                          whatsAppURL:
                                                                              _tokoWhatsAppController.text,
                                                                          profilePhotoURL:
                                                                              selectedImage?.path,
                                                                          name:
                                                                              _tokoNameController.text,
                                                                          inviteCode:
                                                                              _tokoInviteCodeController.text,
                                                                          streetAddress:
                                                                              _streetController.text,
                                                                          cityId:
                                                                              selectedCity!.id,
                                                                          country:
                                                                              _countryController.text,
                                                                          postalCode:
                                                                              _postalCodeController.text,
                                                                        );

                                                                        ref
                                                                            .read(tokoInformationViewModelProvider.notifier)
                                                                            .createTokoInformation(request: tokoInformationRequest)
                                                                            .then((value) {
                                                                          ref.invalidate(
                                                                              fetchInternalInformation);
                                                                          Routemaster.of(context)
                                                                              .replace('/internal-account');
                                                                        });
                                                                      }
                                                                    },
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              15,
                                                                          vertical:
                                                                              20),
                                                                      minimumSize:
                                                                          const Size
                                                                              .fromHeight(
                                                                              50),
                                                                      backgroundColor: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary,
                                                                    ),
                                                                    child: Text(
                                                                      "Konfirmasi",
                                                                      style: appStyle(
                                                                          size:
                                                                              16,
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
                                                error: (error, stackTrace) =>
                                                    Center(
                                                        child: Text(
                                                            error.toString())),
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
                          const SizedBox(
                            height: 10,
                          )
                        ]),
                      ),
                    ),
                  );
                },
                error: ((error, stackTrace) =>
                    Center(child: Text(error.toString()))),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ));
          }, (r) {
            if (initializeFirstToko) {
              initializeFieldsToko(r);
              initializeFirstToko = false;
            }

            return ref.watch(tokoInformationViewModelProvider).when(
                data: (data) {
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: [
                          const TopSectionAuth(
                            isAvatarNeeded: false,
                            name: 'Informasi Toko',
                            description: "Konfigurasikan informasi toko Anda",
                          ),
                          const SizedBox(height: 20),
                          TokoConfigureImage(
                            toko: r,
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
                            },
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hintText: "Masukkan nomor WhatsApp toko",
                            controller: _tokoWhatsAppController,
                            labelText: "WhatsApp Toko",
                            obscureText: false,
                            validator: (value) {
                              if (!(value!.isValidPhoneNumber())) {
                                return "Format nomor telepon toko tidak valid. Harap masukkan nomor telepon yang valid.";
                              } else {
                                return null;
                              }
                            },
                          ),
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
                            },
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          //logic for whatsapp later
                          // CustomTextField(
                          //     hintText: "Enter toko WhatsApp url",
                          //     controller: _tokoWhatsAppController,
                          //     labelText: "Toko WhatsApp",
                          //     obscureText: false,
                          //     validator: (value) {
                          //       if (!(value!.isNotEmpty && value.length > 6)) {
                          //         return "Invalid WhatsApp url. Please enter a valid url.";
                          //       } else {
                          //         return null;
                          //       }
                          //     }),
                          // const SizedBox(
                          //   height: 10,
                          // ),
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
                            },
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          ref.watch(fetchProvinceslistFromProfileToko).when(
                              data: (data) {
                                return data.match(
                                    (l) => Center(
                                        child: Text(l.message,
                                            style: appStyle(
                                                size: 16,
                                                color: mainBlack,
                                                fw: FontWeight.w600))),
                                    (provinceList) {
                                  if (initializeFirstAddress) {
                                    initializeFields(r!.address!, provinceList);
                                  }
                                  return Column(
                                    children: [
                                      CustomDropdown(
                                        preValue: selectedProvince?.name,
                                        values: provinceList
                                            .map((e) => e.name)
                                            .toList(),
                                        labelText: "Provinsi",
                                        hintText: "Masukkan Provinsi",
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return "Anda harus memilih provinsi.";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            selectedProvince =
                                                provinceList.firstWhere(
                                                    (element) =>
                                                        element.name == value,
                                                    orElse: () =>
                                                        provinceList[0]);
                                            selectedCity = null;
                                            initializeFirstAddress = false;
                                          });
                                        },
                                      ),
                                      if (selectedProvince != null)
                                        ref
                                            .watch(
                                                fetchCitieslistFromProfileToko(
                                                    selectedProvince!.id))
                                            .when(
                                                data: (data) {
                                                  return data.match(
                                                      (l) => Text(l.toString()),
                                                      (city) {
                                                    if (initializeFirstAddress) {
                                                      selectedCity =
                                                          r!.address!.city ??
                                                              city[0];
                                                    }
                                                    return Column(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            const SizedBox(
                                                                height: 5),
                                                            CustomTextField(
                                                              labelText:
                                                                  "Negara",
                                                              hintText:
                                                                  "Masukkan Negara",
                                                              controller:
                                                                  _countryController,
                                                              obscureText:
                                                                  false,
                                                              readOnly: true,
                                                            ),
                                                            CustomDropdown(
                                                              preValue:
                                                                  selectedCity
                                                                      ?.name,
                                                              values: city
                                                                  .map((e) =>
                                                                      e.name)
                                                                  .toList(),
                                                              labelText: "Kota",
                                                              hintText:
                                                                  "Masukkan Kota",
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                        ?.isEmpty ??
                                                                    false) {
                                                                  return "Anda harus memilih kota.";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  selectedCity = city.firstWhere(
                                                                      (element) =>
                                                                          element
                                                                              .name ==
                                                                          value,
                                                                      orElse: () =>
                                                                          city[
                                                                              0]);
                                                                  initializeFirstAddress =
                                                                      false;
                                                                });
                                                              },
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            if (selectedCity !=
                                                                null)
                                                              Column(
                                                                children: [
                                                                  CustomTextField(
                                                                    hintText:
                                                                        "Masukkan alamat jalan",
                                                                    controller:
                                                                        _streetController,
                                                                    labelText:
                                                                        "Alamat Jalan",
                                                                    obscureText:
                                                                        false,
                                                                    validator:
                                                                        (value) {
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
                                                                      height:
                                                                          5),
                                                                  CustomTextField(
                                                                    hintText:
                                                                        "Masukkan kode pos",
                                                                    controller:
                                                                        _postalCodeController,
                                                                    labelText:
                                                                        "Kode Pos",
                                                                    obscureText:
                                                                        false,
                                                                    validator:
                                                                        (value) {
                                                                      if (!(value!
                                                                          .isNotEmpty)) {
                                                                        return "Harap masukkan kode pos yang valid.";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                ],
                                                              ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  });
                                                },
                                                error: (error, stackTrace) =>
                                                    Center(
                                                        child: Text(
                                                            error.toString())),
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

                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              checkValidityNumber(_tokoWhatsAppController.text
                                      .replaceAll("+", ""))
                                  .then((value) {
                                setState(() {
                                  validWhatsAppNumber = value;
                                });
                              });
                              if (_formKey.currentState!.validate() &&
                                  selectedCity != null &&
                                  selectedProvince != null) {
                                final tokoInformationRequest =
                                    TokoInformationRequest(
                                        id: r?.id,
                                        streetAddress: _streetController.text,
                                        bio: _tokoBioController.text,
                                        phoneNumber:
                                            _tokoPhoneNumberController.text,
                                        whatsAppURL:
                                            _tokoWhatsAppController.text,
                                        profilePhotoURL: selectedImage?.path,
                                        name: _tokoNameController.text,
                                        inviteCode:
                                            _tokoInviteCodeController.text,
                                        cityId: selectedCity!.id,
                                        country: _countryController.text,
                                        postalCode: _postalCodeController.text);

                                ref
                                    .read(tokoInformationViewModelProvider
                                        .notifier)
                                    .createTokoInformation(
                                        request: tokoInformationRequest)
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
                        ]),
                      ),
                    ),
                  );
                },
                error: ((error, stackTrace) =>
                    Center(child: Text(error.toString()))),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ));
          });
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }, error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        }, orElse: () {
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
