import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:tugas_akhir_project/core/customer/browse-toko/repositories/implementations/browse_toko_repository_impl.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerBrowseTokoPage extends ConsumerWidget {
  const CustomerBrowseTokoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokos = ref.watch(fetchTokos);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Browse Toko",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: tokos.when(
        data: (data) {
          return data.match(
            (l) => Center(
                child: Text(l.message,
                    style: appStyle(
                        size: 16, color: mainBlack, fw: FontWeight.w600))),
            (r) {
              final mappedTokoListNames = r.map((e) => e.name).toList();

              return r.isEmpty
                  ? Center(
                      child: Text("Tidak ada toko ditemukan",
                          style: appStyle(
                              size: 16, color: mainBlack, fw: FontWeight.w600)))
                  : SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: SearchableList(
                                style: appStyle(
                                    size: 16,
                                    color: mainBlack,
                                    fw: FontWeight.w500),
                                initialList: mappedTokoListNames,
                                filter: (searchQuery) => mappedTokoListNames
                                    .where((tokoName) => RegExp(searchQuery,
                                            caseSensitive: false)
                                        .hasMatch(tokoName!))
                                    .toList(),
                                emptyWidget: const SizedBox.shrink(),
                                builder: (list, index, item) {
                                  return GestureDetector(
                                    onTap: () => Routemaster.of(context).push(
                                        '/customer-browse-toko/toko/${r[index].id}'),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Card(
                                        surfaceTintColor: Colors.white,
                                        elevation: 5,
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 15),
                                          title: Column(children: [
                                            IntrinsicHeight(
                                              child: Row(children: [
                                                r[index].profilePhotoURL == null
                                                    ? const CircleAvatar(
                                                        radius: 32,
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: r[index]
                                                                  .profilePhotoURL ??
                                                              "",
                                                          width: 64,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        )),
                                                const SizedBox(width: 15),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          r[index].name ??
                                                              "No name",
                                                          style: appStyle(
                                                              size: 16,
                                                              color: mainBlack,
                                                              fw: FontWeight
                                                                  .w600)),
                                                      Text(
                                                        "No HP: ${r[index].phoneNumber}",
                                                        style: appStyle(
                                                            size: 13,
                                                            color: mainBlack,
                                                            fw: FontWeight
                                                                .w500),
                                                      ),
                                                      Text(
                                                        "Lokasi: ${r[index].address?.streetAddress}",
                                                        style: appStyle(
                                                          size: 12,
                                                          color: mainBlack,
                                                          fw: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                inputDecoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  hintStyle: appStyle(
                                      size: 16,
                                      color: mainBlack,
                                      fw: FontWeight.w500),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  hintText: "Search Toko...",
                                  fillColor: Colors.white,
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 2),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
