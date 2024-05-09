import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/customer/orders/repositories/implementations/customer_order_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/orders/viewmodels/customer_complete_order_viewmodel.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerCompleteOrderRatingPage extends ConsumerStatefulWidget {
  final int orderId;
  const CustomerCompleteOrderRatingPage(this.orderId, {super.key});

  @override
  ConsumerState<CustomerCompleteOrderRatingPage> createState() =>
      _CustomerCompleteOrderRatingPageState();
}

class _CustomerCompleteOrderRatingPageState
    extends ConsumerState<CustomerCompleteOrderRatingPage> {
  List<Map<String, dynamic>> listSelectedRatings = [];
  bool initializeFirst = true;

  @override
  Widget build(BuildContext context) {
    final listOfOrderProducts = ref.watch(fetchOrdersProduks(widget.orderId));
    ref.listen(customerCompleteOrderViewModelProvider, (previous, state) {
      if (previous != state) {
        if (state is AsyncData<void>) {
          showPopupModal(
              context: context,
              title: "Berhasil",
              info: DialogType.success,
              animType: AnimType.scale,
              desc: "Pesanan berhasil diselesaikan",
              onOkPress: () {
                ref.invalidate(fetchOrders);
                Routemaster.of(context).replace('/customer-account/orders');
              });
        } else if (state is AsyncError && state.error is ResponseAPIError) {
          showPopupModal(
              context: context,
              title: "Peringatan",
              info: DialogType.error,
              animType: AnimType.scale,
              desc: (state.error as RequestError).errorMessage,
              onOkPress: () {});
        } else if (state is AsyncError && state.error is RequestError) {
          showPopupModal(
              context: context,
              title: "Peringatan",
              info: DialogType.error,
              animType: AnimType.scale,
              desc: (state.error as RequestError).errorMessage,
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
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Ulasan Pesanan",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: listOfOrderProducts.maybeWhen(
            data: (data) {
              return data.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (r) {
                if (initializeFirst) {
                  for (final produk in r) {
                    listSelectedRatings.add({
                      "produkId": produk.id,
                      "rating": 1,
                    });
                  }

                  initializeFirst = false;
                }
                return ref
                    .watch(customerCompleteOrderViewModelProvider)
                    .maybeWhen(
                        data: (data) {
                          return SafeArea(
                              child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Column(children: [
                                const TopSectionAuth(
                                    name: "Ulasan Pesanan",
                                    description:
                                        "Beri peringkat pada produk yang Anda pesan untuk menyelesaikan pesanan.",
                                    isAvatarNeeded: false),
                                const SizedBox(height: 20),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: r.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        surfaceTintColor: Colors.white,
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  child: Text(
                                                      " Produk Gorden A",
                                                      style: appStyle(
                                                          size: 18,
                                                          color: mainBlack,
                                                          fw: FontWeight.w500)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                CachedNetworkImage(
                                                  imageUrl: r[index]
                                                      .produkGlobalImages
                                                      .first
                                                      .globalImageUrl,
                                                  height: 200,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fitWidth),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                                const SizedBox(height: 15),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    RatingBar.builder(
                                                      glow: true,
                                                      itemSize: 30,
                                                      initialRating: 3,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 5.0),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        setState(() {
                                                          listSelectedRatings[
                                                                      index]
                                                                  ["rating"] =
                                                              rating;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      );
                                    }),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    if (listSelectedRatings.isNotEmpty) {
                                      showPopupModal(
                                          context: context,
                                          title: "Peringatan",
                                          info: DialogType.warning,
                                          animType: AnimType.scale,
                                          desc:
                                              "Apakah Anda yakin ingin menyelesaikan pesanan ini?",
                                          onOkPress: () {
                                            ref
                                                .read(
                                                    customerCompleteOrderViewModelProvider
                                                        .notifier)
                                                .completeOrderCustomer(
                                                    orderId: widget.orderId,
                                                    produkIdRatingList:
                                                        listSelectedRatings);
                                          },
                                          onCancelPress: () {});
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    minimumSize: const Size.fromHeight(50),
                                    backgroundColor: Colors.purple,
                                  ),
                                  child: Text(
                                    "Selesaikan Pesanan",
                                    style: appStyle(
                                        size: 16,
                                        color: Colors.white,
                                        fw: FontWeight.w500),
                                  ),
                                ),
                              ]),
                            ),
                          ));
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        orElse: () => const SizedBox.shrink());
              });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const SizedBox.shrink()));
  }
}
