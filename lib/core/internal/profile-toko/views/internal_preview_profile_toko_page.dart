import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/widgets/katalog_produk_row_widget.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/widgets/toko_beranda_list.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/widgets/toko_information_card_widget.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalPreviewProfileTokoPage extends ConsumerStatefulWidget {
  const InternalPreviewProfileTokoPage({super.key});

  @override
  ConsumerState<InternalPreviewProfileTokoPage> createState() =>
      _InternalPreviewProfileTokoPageState();
}

class _InternalPreviewProfileTokoPageState
    extends ConsumerState<InternalPreviewProfileTokoPage> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    //watch here

    final previewProfileTokoInformation =
        ref.watch(fetchProfileInformationProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Preview Profile Toko",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: previewProfileTokoInformation.maybeWhen(data: (data) {
        return data.$1.match(
            (l) => Center(
                child: Text(l.message,
                    style: appStyle(
                        size: 16,
                        color: mainBlack,
                        fw: FontWeight.w600))), (berandaTokoList) {
          return data.$2.match(
              (l) => Center(
                  child: Text(l.message,  
                      style: appStyle(
                          size: 16,
                          color: mainBlack,
                          fw: FontWeight.w600))), (tokoInfo) {
            return data.$3.match(
                (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600)),
                    ), (katalogProdukList) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TokoInformationCard(tokoInfo),
                          Builder(builder: (context) {
                            if (berandaTokoList.isNotEmpty) {
                              return Column(
                                children: [
                                  const SizedBox(height: 20),
                                  ProfileTokoBerandaList(
                                    controller: _controller,
                                    berandaTokoList: berandaTokoList,
                                  )
                                ],
                              );
                            } else {
                              return SizedBox(
                                height: 200,
                                child: Center(
                                  child: Text(
                                    "Beranda Toko belum diatur",
                                    style: appStyle(
                                        size: 18,
                                        color: mainBlack,
                                        fw: FontWeight.w600),
                                  ),
                                ),
                              );
                            }
                          }),
                          Builder(builder: (context) {
                            if (katalogProdukList.isNotEmpty) {
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: katalogProdukList.length,
                                  itemBuilder: (context, index) {
                                    return KatalogProdukRow(
                                      katalogProduk: katalogProdukList[index],
                                      onTapNavigation: (int produkId) {
                                        Routemaster.of(context).push(
                                            '/internal-account/profile-toko/preview-profile-toko/$produkId');
                                      },
                                    );
                                  });
                            } else {
                              return SizedBox(
                                height: 400,
                                child: Center(
                                  child: Text(
                                    "Katalog Produk belum diatur",
                                    style: appStyle(
                                        size: 18,
                                        color: mainBlack,
                                        fw: FontWeight.w600),
                                  ),
                                ),
                              );
                            }
                          })
                        ]),
                  ),
                ),
              );
            });
          });
        });
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }, orElse: () {
        return const SizedBox.shrink();
      }),
    );
  }
}
