import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/customer/search/providers/customer_search_filters_provider.dart';
import 'package:tugas_akhir_project/core/customer/search/repositories/implementations/customer_search_repository_impl.dart';
import 'package:tugas_akhir_project/models/city.dart';
import 'package:tugas_akhir_project/models/toko.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/label_none_custom_dropdown_button_widget.dart';
import 'package:tugas_akhir_project/widgets/label_none_form_field_widget.dart';

class ModalSearchFilter extends ConsumerStatefulWidget {
  const ModalSearchFilter({super.key});

  @override
  ConsumerState<ModalSearchFilter> createState() => _ModalSearchFilterState();
}

class _ModalSearchFilterState extends ConsumerState<ModalSearchFilter> {
  final _nameController = TextEditingController();
  bool initializeFirst = true;
  SfRangeValues rangeValuesPrices = const SfRangeValues(1.0, 100.0);
  SfRangeValues rangeValuesRating = const SfRangeValues(0.0, 5.0);
  Set<String> selectedCategories = {};
  City? selectedLocation;
  Toko? selectedToko;
  double stepSize = 10.0;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  double determineStepSize(double maxPrice) {
    if (maxPrice < 1000) {
      return 100;
    } else if (maxPrice < 10000) {
      return 500;
    } else if (maxPrice < 100000) {
      return 1000;
    } else if (maxPrice < 1000000) {
      return 5000;
    } else if (maxPrice < 10000000) {
      return 10000;
    } else if (maxPrice < 100000000) {
      return 50000;
    } else {
      return 100000;
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchOption = ref.watch(fetchSearchOption);
    return searchOption.maybeWhen(
        data: (data) {
          return data.match(
              (l) => Center(
                  child: Text(l.message,
                      style: appStyle(
                          size: 16,
                          color: mainBlack,
                          fw: FontWeight.w600))), (r) {
            if (initializeFirst) {
              rangeValuesPrices = SfRangeValues(0.0, r.maxProdukPriceAmount);
              stepSize = determineStepSize(r.maxProdukPriceAmount ?? 0);
              initializeFirst = false;
            }

            return Dialog.fullscreen(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: Column(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TopSectionAuth(
                              name: "Filter Pencarian",
                              description:
                                  "Konfigurasikan filter pencarian",
                              isAvatarNeeded: false),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5),
                              child: GestureDetector(
                                  onTap: () {
                                    Routemaster.of(context).pop();
                                  },
                                  child: const Icon(AntIcons.closeOutlined)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ExpansionTile(
                        title: Text(
                          "Nama",
                          style: appStyle(
                              size: 18, color: mainBlack, fw: FontWeight.w500),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: NoLabelCustomTextField(
                              hintText: "Cari nama produk",
                              controller: _nameController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ExpansionTile(
                        title: Text(
                          "Lokasi",
                          style: appStyle(
                              size: 18, color: mainBlack, fw: FontWeight.w500),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: NoLabelCustomDropdown(
                              preValue: selectedLocation?.name.toTitleCase(),
                              values: r.availableLocations
                                  .map((e) => e.name.toTitleCase()).toSet()
                                  .toList(),
                              hintText: "Pilih lokasi",
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return "Anda harus memilih lokasi.";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                final potentialNewLocation =
                                    r.availableLocations.firstWhere(
                                        (element) =>
                                            element.name.toUpperCase() ==
                                            value?.toUpperCase(),
                                        orElse: () => r.availableLocations[0]);

                                if (selectedLocation?.id !=
                                    potentialNewLocation.id) {
                                  selectedLocation = potentialNewLocation;
                                  selectedToko = null;
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ExpansionTile(
                        title: Text(
                          "Kategori",
                          style: appStyle(
                              size: 18, color: mainBlack, fw: FontWeight.w500),
                        ),
                        children: [
                          Row(children: [
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Wrap(
                                children: [
                                  for (var i = 0;
                                      i < r.categories.length;
                                      i++) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: ChoiceChip(
                                        labelStyle: appStyle(
                                            size: 12,
                                            color: mainBlack,
                                            fw: FontWeight.w600),
                                        label: Text(r.categories[i].name),
                                        selected: selectedCategories
                                            .contains(r.categories[i].name),
                                        onSelected: (bool selected) {
                                          setState(() {
                                            final foundCategory = r.categories
                                                .firstWhere((element) {
                                              return element.name ==
                                                  r.categories[i].name;
                                            });

                                            if (selectedCategories
                                                .contains(foundCategory.name)) {
                                              selectedCategories.removeWhere(
                                                  (element) =>
                                                      element ==
                                                      foundCategory.name);
                                            } else {
                                              selectedCategories
                                                  .add(foundCategory.name);
                                            }
                                          });
                                        },
                                      ),
                                    )
                                  ]
                                ],
                              ),
                            ),
                            SizedBox(width: 10.w),
                          ]),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ExpansionTile(
                        title: Text(
                          "Harga",
                          style: appStyle(
                              size: 18, color: mainBlack, fw: FontWeight.w500),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 40.0),
                            child: SfRangeSlider(
                              labelFormatterCallback:
                                  (dynamic actualValue, String formattedText) {
                                return PriceFormatter.getFormattedValue2(
                                    actualValue as double);
                              },
                              min: 0.0,
                              max: r.maxProdukPriceAmount?.toDouble(),
                              values: rangeValuesPrices,
                              stepSize: stepSize,
                              showTicks: false,
                              showLabels: true,
                              enableTooltip: true,
                              onChanged: (dynamic newValues) {
                                setState(() {
                                  rangeValuesPrices = newValues;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ExpansionTile(
                        title: Text(
                          "Rating",
                          style: appStyle(
                              size: 18, color: mainBlack, fw: FontWeight.w500),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 40.0),
                            child: SfRangeSlider(
                              values: rangeValuesRating,
                              // labelFormatterCallback: (dynamic actualValue,
                              //     String formattedText) {
                              //   return actualValue == 10000
                              //       ? '\$ $formattedText +'
                              //       : '\$ $formattedText';
                              // },
                              stepSize: 0.5,
                              min: 0.0,
                              interval: 1,
                              max: 5.0,
                              showTicks: false,
                              showLabels: true,
                              enableTooltip: true,
                              onChanged: (value) {
                                setState(() {
                                  rangeValuesRating = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ExpansionTile(
                        title: Text(
                          "Toko",
                          style: appStyle(
                              size: 18, color: mainBlack, fw: FontWeight.w500),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: NoLabelCustomDropdown(
                              preValue: selectedToko?.name,
                              values: selectedLocation != null
                                  ? r.tokoList
                                      .filter((t) {
                                        return t.address?.city?.id ==
                                            selectedLocation?.id;
                                      })
                                      .toList()
                                      .map((e) => e.name ?? "")
                                      .toList()
                                  : r.tokoList
                                      .map((e) => e.name ?? "")
                                      .toSet()
                                      .toList(),
                              hintText: "Pilih toko",
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return "Anda harus memilih toko.";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                final potentialNewToko = (r.tokoList.firstWhere(
                                    (element) => element.name == value,
                                    orElse: () => r.tokoList[0]));
                                if ((potentialNewToko.id != selectedToko?.id)) {
                                  selectedToko = potentialNewToko;
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      ElevatedButton(
                        onPressed: () {
                          if ((selectedLocation != null &&
                                  selectedToko != null) ||
                              (selectedLocation == null &&
                                  selectedToko == null) ||
                              selectedLocation == null &&
                                  selectedToko != null) {
                            print("entered here");
                            SearchFilter searchFilter = SearchFilter(
                                priceRange: {
                                  "min": (rangeValuesPrices.start as double)
                                      .toStringAsFixed(1),
                                  "max": (rangeValuesPrices.end as double)
                                      .toStringAsFixed(1)
                                },
                                ratingRange: {
                                  "min": (rangeValuesRating.start as double)
                                      .toStringAsFixed(1),
                                  "max": (rangeValuesRating.end as double)
                                      .toStringAsFixed(1),
                                },
                                categoriesList: selectedCategories.toList(),
                                selectedLocationId: selectedLocation?.id,
                                selectedTokoId: selectedToko?.id,
                                name: _nameController.text);
                            ref
                                .read(customerSearchFiltersNotifierProvider
                                    .notifier)
                                .setSearchFilters(searchFilter);

                            Navigator.of(context).pop();
                            Routemaster.of(context)
                                .push('/customer-search/search-results');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          "Search",
                          style: appStyle(
                              size: 16,
                              color: Colors.white,
                              fw: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _nameController.text = "";
                            selectedCategories = {};
                            selectedLocation = null;
                            selectedToko = null;
                            rangeValuesRating = const SfRangeValues(0.0, 5.0);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          "Clear Selection",
                          style: appStyle(
                              size: 16,
                              color: Colors.black,
                              fw: FontWeight.w500),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            );
          });
        },
        orElse: () => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
