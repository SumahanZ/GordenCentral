import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_creation_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/models/produk_color.dart';
import 'package:tugas_akhir_project/models/produk_combination.dart';
import 'package:tugas_akhir_project/models/produk_size.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/either_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/list_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalProdukPage extends ConsumerStatefulWidget {
  const InternalProdukPage(this.produkId, {super.key});
  final int produkId;

  @override
  ConsumerState<InternalProdukPage> createState() => _InternalProdukPageState();
}

class _InternalProdukPageState extends ConsumerState<InternalProdukPage> {
  bool isInitializationFinished = false;
  int _current = 0;
  ProdukColor? selectedColor;
  ProdukSize? selectedSize;
  ProdukCombination? selectedVariant;
  final CarouselController _controller = CarouselController();

  void getSelectedVariant(Produk produk) {
    List<ProdukCombination> comparatorProdukCombination =
        produk.produkCombination;

    ProdukCombination foundVariant =
        comparatorProdukCombination.firstWhere((combination) {
      return combination.color?.name == selectedColor?.name &&
          combination.size?.name == selectedSize?.name;
    }, orElse: () => comparatorProdukCombination[0]);

    selectedVariant = foundVariant;
  }

  List<Map<String, String>> getCombinedImages(Produk? produk) {
    List<Map<String, String>> globalImages =
        (produk?.produkGlobalImages ?? []).map((e) {
      return {"imageUrl": e.globalImageUrl, "type": "global", "caption": ""};
    }).toList();

    List<Map<String, String>> colorImages =
        (produk?.produkColors ?? []).map((e) {
      return {
        "imageUrl": e.produkColorImageUrl,
        "type": "color",
        "caption": e.name
      };
    }).toList();

    List<Map<String, String>> combinedImagesList = [
      ...globalImages,
      ...colorImages
    ];

    combinedImagesList.sort((a, b) {
      if (a["type"] == "global" && b["type"] == "color") {
        return -1; // Put global images at the beginning of the list
      } else if (a["type"] == "color" && b["type"] == "global") {
        return 1; // Put color images at the end
      } else {
        return 0;
      }
    });

    return combinedImagesList;
  }

  @override
  Widget build(BuildContext context) {
    final produkDetail =
        ref.watch(fetchProdukDetailInternalProvider(widget.produkId));
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Produk Detail",
              style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
            ),
            centerTitle: true,
            actions: [
              if (produkDetail.asData?.value.unwrapRight()?.promo != null &&
                  (produkDetail.asData?.value.unwrapRight()?.promo?.expiredAt ??
                          DateTime.now())
                      .isAfter(DateTime.now()))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                          "${produkDetail.asData?.value.unwrapRight()?.promo?.discountPercent}% OFF",
                          style: appStyle(
                              size: 16,
                              color: Colors.purple,
                              fw: FontWeight.w600)),
                    ],
                  ),
                )
            ]),
        body: produkDetail.maybeWhen(
          data: (data) {
            return data.match(
                (l) => Center(
                    child: Text(l.message,
                        style: appStyle(
                            size: 16,
                            color: mainBlack,
                            fw: FontWeight.w600))), (r) {
              final combinedImages = getCombinedImages(r);

              return SlidingUpPanel(
                panelBuilder: () => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10.0),
                  child: selectedVariant == null
                      ? Column(
                          children: [
                            const SizedBox(height: 50),
                            Center(
                              child: Text(
                                "Varian belum dipilih!",
                                style: appStyle(
                                    size: 18,
                                    color: mainBlack,
                                    fw: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Stok: ${selectedVariant != null ? selectedVariant?.variantAmount : 0}",
                                      style: appStyle(
                                        size: 18,
                                        color:
                                            selectedVariant?.variantAmount == 0
                                                ? Colors.red
                                                : mainBlack,
                                        fw: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      PriceFormatter.getFormattedValue(
                                          r?.price ?? 0),
                                      style: appStyle(
                                        size: 22,
                                        color: mainBlack,
                                        fw: FontWeight.w600,
                                      ).copyWith(
                                          decoration: r?.promo != null &&
                                                  (r?.promo?.expiredAt ??
                                                          DateTime.now())
                                                      .isAfter(DateTime.now())
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          decorationThickness: 2),
                                    ),
                                    if (r?.promo != null &&
                                        (r?.promo?.expiredAt ?? DateTime.now())
                                            .isAfter(DateTime.now()))
                                      Text(
                                        PriceFormatter.getFormattedValue((r
                                                    ?.price ??
                                                0) -
                                            (r?.price ?? 0) *
                                                ((r?.promo?.discountPercent ??
                                                            0)
                                                        .toInt() /
                                                    100)),
                                        style: appStyle(
                                          size: 22,
                                          color: mainBlack,
                                          fw: FontWeight.w600,
                                        ),
                                      ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                                productCreationSelectionNotifierProvider
                                                    .notifier)
                                            .initializeSelections(
                                                sizes: r!.produkSizes
                                                    .map((e) => e.name)
                                                    .toList(),
                                                colors: r.produkColors.map((e) {
                                                  return {
                                                    "name": e.name,
                                                    "imagePath":
                                                        e.produkColorImageUrl,
                                                  };
                                                }).toList(),
                                                categories: r.produkCategories
                                                    .map((e) => e.name)
                                                    .toList());
                                        Routemaster.of(context).push(
                                            '/internal-account/profile-toko/preview-profile-toko/${widget.produkId}/edit');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        backgroundColor: Colors.greenAccent,
                                      ),
                                      child: Text(
                                        "Edit Produk",
                                        style: appStyle(
                                            size: 16,
                                            color: Colors.white,
                                            fw: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                ),
                backdropEnabled: false,
                borderRadius: BorderRadius.circular(10),
                minHeight: 170,
                isDraggable: false,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              CarouselSlider(
                                items: combinedImages.map((item) {
                                  return Container(
                                    margin: const EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0)),
                                        child: Stack(
                                          children: <Widget>[
                                            CachedNetworkImage(
                                              imageUrl: item["imageUrl"] ?? "",
                                              width: 1000,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: imageProvider,
                                                  ),
                                                ),
                                              ),
                                              // placeholder: (context, url) =>
                                              //     const Center(
                                              //         child:
                                              //             CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                            Positioned(
                                              bottom: 0.0,
                                              left: 0.0,
                                              right: 0.0,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          300, 0, 0, 0),
                                                      Color.fromARGB(0, 0, 0, 0)
                                                    ],
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 20.0),
                                                child: Text(
                                                  item["caption"] ??
                                                      "No Caption",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                                }).toList(),
                                carouselController: _controller,
                                options: CarouselOptions(
                                    viewportFraction: 1,
                                    aspectRatio: 1.5,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    combinedImages.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black)
                                            .withOpacity(_current == entry.key
                                                ? 0.9
                                                : 0.4),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          if (r?.averageRating != 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(AntIcons.starFilled,
                                    color: Colors.yellow),
                                const SizedBox(width: 5),
                                Text(
                                  "${r?.averageRating?.toStringAsPrecision(2) ?? ""} (${r?.totalRating ?? 0} Pembeli)",
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w600),
                                ),
                              ],
                            ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  r?.name ?? "No name",
                                  style: appStyle(
                                      size: 20,
                                      color: mainBlack,
                                      fw: FontWeight.w600),
                                ),
                              ),
                              if ((DateTime.now()).isBefore(
                                  (r?.createdAt ?? DateTime.now())
                                      .add(const Duration(days: 7))))
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("BARU",
                                              style: appStyle(
                                                  size: 13,
                                                  color: Colors.white,
                                                  fw: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (r?.promo != null &&
                              (r?.promo?.expiredAt ?? DateTime.now())
                                  .isAfter(DateTime.now()))
                            Text(
                              "Expires in: ${DateTimeHourMin.durationBetween(DateTime.now(), r?.promo?.expiredAt ?? DateTime.now())}",
                              style: appStyle(
                                size: 14,
                                color: Colors.purple,
                                fw: FontWeight.w500,
                              ),
                            ),
                          const SizedBox(height: 10),
                          Text(r?.description ?? "No description",
                              style: appStyle(
                                  size: 16,
                                  color: mainBlack,
                                  fw: FontWeight.w400)),
                          const SizedBox(height: 15),
                          Text("Ukuran:",
                              style: appStyle(
                                  size: 16,
                                  color: mainBlack,
                                  fw: FontWeight.w600)),
                          Row(children: [
                            Expanded(
                              child: Wrap(spacing: 5.0, children: [
                                if (r != null)
                                  for (var i = 0;
                                      i < r.produkSizes.length;
                                      i++) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: ChoiceChip(
                                        labelStyle: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                        label: Text(r.produkSizes[i].name),
                                        selected: selectedSize?.id ==
                                            r.produkSizes[i].id,
                                        onSelected: (_) {
                                          if (selectedSize?.name !=
                                              r.produkSizes[i].name) {
                                            setState(() {
                                              isInitializationFinished = true;
                                              selectedSize = r.produkSizes[i];
                                              selectedColor ??=
                                                  r.produkColors[0];
                                              getSelectedVariant(r);
                                              _controller.animateToPage(
                                                combinedImages.indexWhere(
                                                    (element) =>
                                                        selectedColor?.name ==
                                                        element["caption"]),
                                              );
                                            });
                                          }
                                        },
                                      ),
                                    )
                                  ]
                              ]),
                            ),
                          ]),
                          const SizedBox(height: 15),
                          Text("Warna:",
                              style: appStyle(
                                  size: 16,
                                  color: mainBlack,
                                  fw: FontWeight.w600)),
                          Row(children: [
                            Expanded(
                              child: Wrap(spacing: 5.0, children: [
                                if (r != null)
                                  for (var i = 0;
                                      i < r.produkColors.length;
                                      i++) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: ChoiceChip(
                                        labelStyle: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                        labelPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15),
                                        label: Text(r.produkColors[i].name),
                                        selected: selectedColor?.name ==
                                            r.produkColors[i].name,
                                        onSelected: (bool selected) {
                                          if (selectedColor?.name !=
                                              r.produkColors[i].name) {
                                            setState(() {
                                              isInitializationFinished = true;
                                              selectedColor = r.produkColors[i];
                                              selectedSize ??= r.produkSizes[0];
                                              getSelectedVariant(r);
                                              _controller.animateToPage(
                                                combinedImages.indexWhere(
                                                    (element) =>
                                                        selectedColor?.name ==
                                                        element["caption"]),
                                              );
                                            });
                                          }
                                        },
                                      ),
                                    )
                                  ]
                              ]),
                            ),
                          ]),
                          const SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text("Kategori: ",
                                  style: appStyle(
                                      size: 16,
                                      color: mainBlack,
                                      fw: FontWeight.w600)),
                              const SizedBox(width: 5),
                              Text(
                                  r?.produkCategories
                                          .map((e) => e.name)
                                          .toList()
                                          .getConcatenatedList() ??
                                      "None",
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w500))
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text("Dijual Oleh: ",
                                  style: appStyle(
                                      size: 16,
                                      color: mainBlack,
                                      fw: FontWeight.w600)),
                              const SizedBox(width: 5),
                              Text(r?.toko?.name ?? "No name",
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w500))
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text("Created At: ",
                                  style: appStyle(
                                      size: 16,
                                      color: mainBlack,
                                      fw: FontWeight.w600)),
                              const SizedBox(width: 5),
                              Text(
                                  (r?.createdAt ?? DateTime.now()).formatDate(),
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w500))
                            ],
                          ),
                          const SizedBox(height: 400),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          orElse: () => null,
        ));
  }
}
