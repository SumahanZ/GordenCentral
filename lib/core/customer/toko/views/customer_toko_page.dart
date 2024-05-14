import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/customer/toko/repositories/implementations/customer_toko_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/widgets/katalog_produk_row_widget.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/widgets/toko_beranda_list.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/widgets/toko_information_card_widget.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerTokoPage extends ConsumerWidget {
  CustomerTokoPage({super.key, required this.tokoId});
  final int tokoId;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokoInformation = ref.watch(fetchTokoAllInformationProvider(tokoId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Toko",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: tokoInformation.maybeWhen(data: (data) {
        return data.$1.match(
            (l) => Center(
                child: Text(l.message,
                    style: appStyle(
                        size: 16,
                        color: mainBlack,
                        fw: FontWeight.w600))), (tokoInfo) {
          return data.$2.match(
              (l) => Center(
                    child: Text(l.message,
                        style: appStyle(
                            size: 16, color: mainBlack, fw: FontWeight.w600)),
                  ), (katalogProdukList) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TokoInformationCard(tokoInfo),
                            Builder(builder: (context) {
                              if (tokoInfo!.berandaToko.isNotEmpty) {
                                return Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    ProfileTokoBerandaList(
                                      controller: _controller,
                                      berandaTokoList: tokoInfo.berandaToko,
                                    )
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: katalogProdukList.length,
                                itemBuilder: (context, index) {
                                  return KatalogProdukRow(
                                      katalogProduk: katalogProdukList[index],
                                      onTapNavigation: (int produkId) =>
                                          Routemaster.of(context).push(
                                              '/customer-browse-toko/toko/$tokoId/$produkId'));
                                })
                          ]),
                    )
                  ],
                ),
              ),
            );
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
