import 'dart:io';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_stok_notifier.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class ProdukStokCombinationCard extends ConsumerWidget {
  final String titleName;
  final String buttonDescription;
  final List<ProdukStok> produkStok;
  final String routeDestination;
  final String buttonDestination;

  const ProdukStokCombinationCard({
    super.key,
    required this.titleName,
    required this.routeDestination,
    required this.buttonDestination,
    required this.buttonDescription,
    required this.produkStok,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionTile(
            initiallyExpanded: true,
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleName,
                  style:
                      appStyle(size: 18, color: mainBlack, fw: FontWeight.w600),
                ),
              ],
            ),
            children: [
              for (var i = 0; i < produkStok.length; i++) ...[
                const Divider(),
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  title: Column(children: [
                    Row(
                      children: [
                        Text(
                          "Stok: ${produkStok[i].stokAmount}",
                          style: appStyle(
                            size: 16,
                            color: mainBlack,
                            fw: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    IntrinsicHeight(
                      child: Row(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: produkStok[i]
                                    .produkColor["imagePath"]
                                    .startsWith(
                                        "http://res.cloudinary.com/dkintlemd/image/upload/")
                                ? CachedNetworkImage(
                                    imageUrl: produkStok[i]
                                            .produkColor["imagePath"] ??
                                        "",
                                    width: 60,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: imageProvider,
                                        ),
                                      ),
                                    ),
                                    // placeholder: (context, url) => const Center(
                                    //     child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : Image.file(
                                    File((produkStok[i]
                                        .produkColor["imagePath"]!)),
                                    fit: BoxFit.contain,
                                    width: 60)),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Ukuran: ${produkStok[i].produkSize}",
                                  style: appStyle(
                                    size: 14,
                                    color: mainBlack,
                                    fw: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Warna: ${produkStok[i].produkColor["name"]}",
                                  style: appStyle(
                                    size: 14,
                                    color: mainBlack,
                                    fw: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              child: GestureDetector(
                                onTap: () {
                                  ref
                                      .read(
                                          productStokNotifierProvider.notifier)
                                      .remove(i);
                                },
                                child: const Icon(AntIcons.deleteFilled),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CircleAvatar(
                              child: GestureDetector(
                                onTap: () => Routemaster.of(context)
                                    .push("$routeDestination/$i"),
                                child: const Icon(AntIcons.editFilled),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    const SizedBox(height: 10),
                  ]),
                ),
                if (produkStok[i] != produkStok[produkStok.length - 1] &&
                    i < produkStok.length - 2)
                  const Divider()
              ],
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                child: Column(children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {
                      Routemaster.of(context).push(buttonDestination);
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(40),
                      elevation: 2,
                      surfaceTintColor: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(AntIcons.plusCircleFilled, size: 25),
                              const SizedBox(width: 5),
                              Text(
                                buttonDescription,
                                style: appStyle(
                                    size: 16,
                                    color: mainBlack,
                                    fw: FontWeight.w500),
                              ),
                            ]),
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
