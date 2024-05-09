import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/customer/cart/widgets/customer_order_item.dart';
import 'package:tugas_akhir_project/core/customer/orders/providers/order_detail_selection_notifier.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalOrderDetailPage extends ConsumerWidget {
  const InternalOrderDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderDetail = ref.watch(orderDetailSelectionNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Pesanan",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                " Detail Pesanan",
                style:
                    appStyle(size: 16, color: mainBlack, fw: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Card(
                surfaceTintColor: Colors.white,
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Tanggal Pesanan",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            "${orderDetail?.createdAt?.formatDateDayOnly()}",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w500),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.5)),
                      Row(
                        children: [
                          Text(
                            "Waktu Pesanan",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            "${orderDetail?.createdAt?.timeOnly()}",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w500),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.5)),
                      Row(
                        children: [
                          Text(
                            "ID Pesanan",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            "#${orderDetail?.code}",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w500),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.5)),
                      Row(
                        children: [
                          Text(
                            "Dipesan Oleh",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            "#${orderDetail?.customer?.customerCode ?? ""}",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    " Riwayat Pesanan",
                    style: appStyle(
                        size: 16, color: mainBlack, fw: FontWeight.w600),
                  ),
                  const Spacer(),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 15, vertical: 10),
                  //     backgroundColor: Theme.of(context).colorScheme.primary,
                  //   ),
                  //   child: Text(
                  //     "Configure Order Status",
                  //     style: appStyle(
                  //         size: 12, color: Colors.white, fw: FontWeight.w500),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                surfaceTintColor: Colors.white,
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Status Pesanan",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            "${orderDetail?.status?.name}",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w500),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.5)),
                      Row(
                        children: [
                          Text(
                            orderDetail?.status?.name == "Cancelled"
                                ? "Cancelled At"
                                : orderDetail?.status?.name == "Completed"
                                    ? "Completed At"
                                    : "Updated At",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            "${(orderDetail?.status?.name == "Cancelled" ? orderDetail?.cancelledAt : orderDetail?.status?.name == "Completed" ? orderDetail?.completedAt : orderDetail?.updatedAt)?.formatDate()}",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w500),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.5)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deskripsi Pesanan",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            orderDetail?.note ?? "Tidak ada deskripsi.",
                            style: appStyle(
                                size: 12,
                                color: mainBlack,
                                fw: FontWeight.w500),
                          ),
                        ],
                      ),
                      if (orderDetail?.status?.name != "Cancelled" &&
                          orderDetail?.status?.name != "Completed") ...[
                        Divider(color: Colors.black.withOpacity(0.5)),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            Routemaster.of(context).push(
                                "/internal-order/detail/configure-order-log");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          child: Text(
                            "Konfigurasi Log Pesanan",
                            style: appStyle(
                                size: 14,
                                color: Colors.white,
                                fw: FontWeight.w500),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                " Informasi Pesanan",
                style:
                    appStyle(size: 16, color: mainBlack, fw: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Card(
                surfaceTintColor: Colors.white,
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpansionTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Item Pesanan (${orderDetail?.orderItemList.map((e) => e.amount).reduce((value, element) => value! + element!)} barang)",
                            style: appStyle(
                                size: 15,
                                color: mainBlack,
                                fw: FontWeight.w600),
                          ),
                          Text(
                            PriceFormatter.getFormattedValue(
                                orderDetail?.finalPriceTotal ?? 0),
                            style: appStyle(
                                size: 15,
                                color: mainBlack,
                                fw: FontWeight.w600),
                          ),
                        ],
                      ),
                      children: [
                        for (var i = 0;
                            i < (orderDetail?.orderItemList ?? []).length;
                            i++) ...[
                          const Divider(),
                          CustomerOrderItem(
                            orderItem: orderDetail?.orderItemList[i],
                          ),
                          const Divider(),
                        ],
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Alamat Pengiriman",
                                  style: appStyle(
                                      size: 15,
                                      color: mainBlack,
                                      fw: FontWeight.w600)),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${orderDetail?.customer?.address?.streetAddress}",
                                    style: appStyle(
                                        size: 14,
                                        color: mainBlack,
                                        fw: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Kota",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${orderDetail?.customer?.address?.city?.name.toTitleCase()}",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Provinsi",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${orderDetail?.customer?.address?.city?.province?.name.toTitleCase()}",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Negara",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${orderDetail?.customer?.address?.country?.toTitleCase()}",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Kode Pos",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${orderDetail?.customer?.address?.postalCode}",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Divider(color: Colors.black.withOpacity(0.5)),
                              Text("Ringkasan Pesanan",
                                  style: appStyle(
                                      size: 15,
                                      color: mainBlack,
                                      fw: FontWeight.w600)),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "Subtotal (2 items)",
                                    style: appStyle(
                                        size: 14,
                                        color: mainBlack,
                                        fw: FontWeight.w500),
                                  ),
                                  const Spacer(),
                                  Text(
                                    PriceFormatter.getFormattedValue(
                                        orderDetail?.originalPriceTotal ?? 0),
                                    style: appStyle(
                                        size: 14,
                                        color: mainBlack,
                                        fw: FontWeight.w500),
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 10),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "Delivery Cost",
                              //       style: appStyle(
                              //           size: 14,
                              //           color: mainBlack,
                              //           fw: FontWeight.w500),
                              //     ),
                              //     const Spacer(),
                              //     Text(
                              //       "Rp 15.000,00",
                              //       style: appStyle(
                              //           size: 14,
                              //           color: mainBlack,
                              //           fw: FontWeight.w500),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "Total Diskon",
                                    style: appStyle(
                                        size: 14,
                                        color: mainBlack,
                                        fw: FontWeight.w500),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "- ${PriceFormatter.getFormattedValue(orderDetail?.discountAmountTotal ?? 0)}",
                                    style: appStyle(
                                        size: 14,
                                        color: mainBlack,
                                        fw: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Divider(color: Colors.black.withOpacity(0.5)),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Grand Total",
                                    style: appStyle(
                                        size: 15,
                                        color: mainBlack,
                                        fw: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    PriceFormatter.getFormattedValue(
                                        orderDetail?.finalPriceTotal ?? 0),
                                    style: appStyle(
                                        size: 15,
                                        color: mainBlack,
                                        fw: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
