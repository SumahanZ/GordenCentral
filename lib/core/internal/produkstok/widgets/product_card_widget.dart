import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_creation_selection_notifier.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class ProdukCard extends ConsumerWidget {
  final String titleName;
  final String buttonDescription;
  final String routeDestination;
  final String type;
  final List<String> selections;
  const ProdukCard({
    super.key,
    required this.selections,
    required this.titleName,
    required this.routeDestination,
    required this.buttonDescription,
    required this.type,
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
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(selections[i],
                                  style: appStyle(
                                      size: 16,
                                      color: mainBlack,
                                      fw: FontWeight.w600)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () => type == "size"
                                ? ref
                                    .read(
                                        productCreationSelectionNotifierProvider
                                            .notifier)
                                    .removeFromSizes(index: i)
                                : ref
                                    .read(
                                        productCreationSelectionNotifierProvider
                                            .notifier)
                                    .removeFromCategories(index: i),
                            child: const Icon(
                                Icons.remove_circle_outline_outlined))
                      ]),
                    ),
                  ]),
                ),
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
