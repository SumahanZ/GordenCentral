import 'dart:io';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_creation_selection_notifier.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class ProdukColorWidget extends ConsumerWidget {
  final String titleName;
  final String buttonDescription;
  final String routeDestination;
  final List<Map<String, String>> selections;

  const ProdukColorWidget({
    super.key,
    required this.titleName,
    required this.buttonDescription,
    required this.routeDestination,
    required this.selections,
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
                if (selections.isNotEmpty)
                  Text(
                    "Total: ${selections.length}",
                    style: appStyle(
                        size: 16, color: mainBlack, fw: FontWeight.w500),
                  ),
              ],
            ),
            children: [
              for (var i = 0; i < selections.length; i++) ...[
                const Divider(),
                ListTile(
                  onTap: () {
                  },
                  shape: const RoundedRectangleBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  title: Column(children: [
                    IntrinsicHeight(
                      child: Row(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: selections[i]["imagePath"]!.startsWith(
                                  "http://res.cloudinary.com/dkintlemd/image/upload/")
                              ? CachedNetworkImage(
                                  imageUrl: selections[i]["imagePath"] ?? "",
                                  width: 50,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
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
                              : Image.file(File((selections[i]["imagePath"]!)),
                                  fit: BoxFit.contain, width: 50),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(selections[i]["name"]!,
                                  style: appStyle(
                                      size: 18,
                                      color: mainBlack,
                                      fw: FontWeight.w600)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              ref
                                  .read(productCreationSelectionNotifierProvider
                                      .notifier)
                                  .removeFromColors(index: i);
                            },
                            child: const Icon(Icons.remove_circle_outline))
                      ]),
                    ),
                  ]),
                ),
                if (selections[i] != selections[selections.length - 1] &&
                    i < selections.length - 2)
                  const Divider()
              ],
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                child: Column(children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {
                      Routemaster.of(context).push(routeDestination);
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
