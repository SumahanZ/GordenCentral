import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/customer/account/repositories/implementations/customer_account_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/account/viewmodels/customer_account_viewmodel.dart';
import 'package:tugas_akhir_project/models/address.dart';
import 'package:tugas_akhir_project/models/city.dart';
import 'package:tugas_akhir_project/models/province.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_widget.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

import '../../../auth/widgets/top_section_auth_widget.dart';

class CustomerChangeDeliveryInformationPage extends ConsumerStatefulWidget {
  const CustomerChangeDeliveryInformationPage({super.key});

  @override
  ConsumerState<CustomerChangeDeliveryInformationPage> createState() =>
      _CustomerChangeDeliveryInformationPageState();
}

class _CustomerChangeDeliveryInformationPageState
    extends ConsumerState<CustomerChangeDeliveryInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _countryController = TextEditingController();
  bool initializeFirst = true;
  final _postalCodeController = TextEditingController();
  Province? selectedProvince;
  City? selectedCity;

  @override
  void dispose() {
    _streetController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  void initializeFields(Address address, List<Province> provinceList) {
    _streetController.text = address.streetAddress;
    _countryController.text = address.country ?? "";
    _postalCodeController.text = address.postalCode ?? "";
    selectedProvince = address.city?.province ?? provinceList[0];
    selectedCity = address.city?.province != null ? address.city : null;
  }

  @override
  Widget build(BuildContext context) {
    final deliveryInfo = ref.watch(fetchDeliveryInformation);

    ref.listen(customerAccountViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Berhasil",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Berhasil mengkonfigurasi informasi pengiriman!",
            onOkPress: () {
              Routemaster.of(context).pop();
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
          "Informasi Pengiriman",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: deliveryInfo.maybeWhen(
            data: (data) {
              return data.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (address) {
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
                                  name: 'Informasi Pengiriman',
                                  description:
                                      "Konfigurasikan informasi pengiriman pelanggan",
                                ),
                                const SizedBox(height: 20),
                                ref.watch(fetchProvinceslistFromAccount).when(
                                    data: (data) {
                                      return data.match(
                                          (l) => Center(
                                              child: Text(l.message,
                                                  style: appStyle(
                                                      size: 16,
                                                      color: mainBlack,
                                                      fw: FontWeight.w600))),
                                          (provinceList) {
                                        if (initializeFirst) {
                                          initializeFields(
                                              address, provinceList);
                                          initializeFirst = false;
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
                                                              element.name ==
                                                              value,
                                                          orElse: () =>
                                                              provinceList[0]);
                                                  selectedCity = null;
                                                  initializeFirst = false;
                                                });
                                              },
                                            ),
                                            if (selectedProvince != null)
                                              ref
                                                  .watch(
                                                      fetchCitieslistFromAccount(
                                                          selectedProvince!.id))
                                                  .when(
                                                      data: (data) {
                                                        return data.match(
                                                            (l) => Text(
                                                                l.toString()),
                                                            (city) {
                                                          if (initializeFirst) {
                                                            selectedCity =
                                                                address.city ??
                                                                    city[0];
                                                          }
                                                          return Column(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  const SizedBox(
                                                                      height:
                                                                          5),
                                                                  CustomTextField(
                                                                    labelText:
                                                                        "Negara",
                                                                    hintText:
                                                                        "Masukkan Negara",
                                                                    controller:
                                                                        _countryController,
                                                                    obscureText:
                                                                        false,
                                                                    readOnly:
                                                                        true,
                                                                  ),
                                                                  CustomDropdown(
                                                                    preValue:
                                                                        selectedCity
                                                                            ?.name,
                                                                    values: city
                                                                        .map((e) =>
                                                                            e.name)
                                                                        .toList(),
                                                                    labelText:
                                                                        "Kota",
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
                                                                      setState(
                                                                          () {
                                                                        selectedCity = city.firstWhere(
                                                                            (element) =>
                                                                                element.name ==
                                                                                value,
                                                                            orElse: () =>
                                                                                city[0]);
                                                                        initializeFirst =
                                                                            false;
                                                                      });
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          5),
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
                                                                            if (!(value!.isNotEmpty &&
                                                                                value.length > 6)) {
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
                                                                            if (!(value!.isNotEmpty)) {
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
                                                                              () {
                                                                            if (_formKey.currentState!.validate() &&
                                                                                selectedCity != null &&
                                                                                selectedProvince != null) {
                                                                              ref.read(customerAccountViewModelProvider.notifier).configureDeliveryInformationCustomer(streetAddress: _streetController.text, cityId: selectedCity!.id, country: _countryController.text, postalCode: _postalCodeController.text).then((value) {});
                                                                            }
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                                                            minimumSize:
                                                                                const Size.fromHeight(50),
                                                                            backgroundColor:
                                                                                Theme.of(context).colorScheme.primary,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "Selesaikan Personalisasi",
                                                                            style: appStyle(
                                                                                size: 18,
                                                                                color: Colors.white,
                                                                                fw: FontWeight.w500),
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
                                                      error: (error,
                                                              stackTrace) =>
                                                          Center(
                                                              child: Text(error
                                                                  .toString())),
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
                      );
                    },
                    error: ((error, stackTrace) =>
                        Center(child: Text(error.toString()))),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ));
              });
            },
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            orElse: () => const SizedBox.shrink()),
      ),
    );
  }
}
