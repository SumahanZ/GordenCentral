import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalKatalogProdukPage extends ConsumerWidget {
  const InternalKatalogProdukPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final katalogProdukToko = ref.watch(fetchKatalogProdukToko);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Katalog Produk",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Icon(Icons.add_outlined, size: 30),
                GestureDetector(
                  onTap: () => Routemaster.of(context).push(
                      "/internal-account/profile-toko/katalog-produk/add"),
                  child: Text(
                    "Tambah",
                    style: appStyle(
                        size: 14, color: mainBlack, fw: FontWeight.w600),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: katalogProdukToko.maybeWhen(data: (data) {
          return data.match(
              (l) => Center(
                  child: Text(l.message,
                      style: appStyle(
                          size: 16,
                          color: mainBlack,
                          fw: FontWeight.w600))), (r) {
            if (r.isEmpty) {
              return Center(
                  child: Text(
                "Toko tidak memiliki katalog produk",
                style:
                    appStyle(size: 16, color: mainBlack, fw: FontWeight.w600),
              ));
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: r.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Card(
                              surfaceTintColor: Colors.white,
                              elevation: 5,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                title: Column(children: [
                                  IntrinsicHeight(
                                    child: Row(children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            r[index].name ?? "No name",
                                            style: appStyle(
                                                size: 18,
                                                color: mainBlack,
                                                fw: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                "${r[index].produkList.length} ${r[index].produkList.length > 1 ? "items" : "item"} in this katalog",
                                                style: appStyle(
                                                  size: 16,
                                                  color: mainBlack,
                                                  fw: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () => Routemaster.of(context).push(
                                            "/internal-account/profile-toko/katalog-produk/edit/${r[index].id}"),
                                        child: Material(
                                            surfaceTintColor: Colors.purple,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            elevation: 5,
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(AntIcons.editOutlined,
                                                  size: 30),
                                            )),
                                      )
                                    ]),
                                  ),
                                ]),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ]);
                        })
                  ]),
                ),
              );
            }
          });
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }, orElse: () {
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
