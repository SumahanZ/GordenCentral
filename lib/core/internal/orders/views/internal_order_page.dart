import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugas_akhir_project/core/customer/orders/providers/order_detail_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/orders/repositories/implementations/internal_order_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/orders/viewmodels/internal_order_viewmodel.dart';
import 'package:tugas_akhir_project/core/internal/settings/repositories/implementations/internal_settings_repository_impl.dart';
import 'package:tugas_akhir_project/models/order.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/either_extension.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalOrderPage extends ConsumerStatefulWidget {
  const InternalOrderPage({super.key});

  @override
  ConsumerState<InternalOrderPage> createState() => _InternalOrderPageState();
}

class _InternalOrderPageState extends ConsumerState<InternalOrderPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final internalInformation = ref.watch(fetchInternalInformation);

    ref.listen(internalOrderViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
          context: context,
          title: "Berhasil",
          info: DialogType.success,
          animType: AnimType.scale,
          desc: "Berhasil membatalkan permintaan pesanan!",
          onOkPress: () {
            ref.invalidate(fetchAllCustomerOrders);
          },
        );
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
          context: context,
          title: "Peringatan",
          info: DialogType.error,
          animType: AnimType.scale,
          desc: (state.error as RequestError).errorMessage,
          onOkPress: () {
            // Routemaster.of(context).pop();
          },
        );
      } else if (state is AsyncError && state.error is RequestError) {
        showPopupModal(
          context: context,
          title: "Peringatan",
          info: DialogType.error,
          animType: AnimType.scale,
          desc: (state.error as RequestError).errorMessage,
          onOkPress: () {
            // Routemaster.of(context).pop();
          },
        );
      } else if (state is AsyncError) {
        showPopupModal(
          context: context,
          title: "Peringatan",
          info: DialogType.error,
          animType: AnimType.scale,
          desc: (state.error as ApiError).message,
          onOkPress: () {
            // Routemaster.of(context).pop();
          },
        );
      }
    });

    return Scaffold(
        appBar: AppBar(
          bottom: internalInformation.asData?.value.unwrapRight()?.status !=
                  "joined"
              ? null
              : TabBar(
                  // dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  padding: const EdgeInsets.all(0),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.transparent,
                  controller: _tabController,
                  labelColor: Colors.purple,
                  labelStyle:
                      appStyle(size: 16, color: mainBlack, fw: FontWeight.bold),
                  unselectedLabelColor: Colors.black.withOpacity(0.2),
                  tabs: const [
                    Tab(text: "Diproses"),
                    Tab(text: "Dibatalkan"),
                    Tab(text: "Selesai")
                  ],
                ),
          title: Text(
            "Pesanan",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: internalInformation.when(
            data: (data) {
              return data.unwrapRight()?.status != "joined"
                  ? Center(
                      child: Text("Anda belum bergabung toko",
                          style: appStyle(
                              size: 16, color: mainBlack, fw: FontWeight.w600)))
                  : ref.watch(fetchAllCustomerOrders).maybeWhen(
                      data: (data) {
                        return data.match(
                            (l) => Center(
                                child: Text(l.message,
                                    style: appStyle(
                                        size: 16,
                                        color: mainBlack,
                                        fw: FontWeight.w600))), (r) {
                          return TabBarView(
                              controller: _tabController,
                              children: [
                                SafeArea(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Column(
                                        children: [
                                          _buildOrderGroup(
                                            ref: ref,
                                            status: "Processing",
                                            context: context,
                                            orders: r,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SafeArea(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Column(
                                        children: [
                                          _buildOrderGroup(
                                              ref: ref,
                                              context: context,
                                              orders: r,
                                              status: "Cancelled"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SafeArea(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Column(
                                        children: [
                                          _buildOrderGroup(
                                              ref: ref,
                                              context: context,
                                              orders: r,
                                              status: "Completed"),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ]);
                        });
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      orElse: () => const SizedBox.shrink());
            },
            error: ((error, stackTrace) => Center(
                child: Text(error.toString(),
                    style: appStyle(
                        size: 16, color: mainBlack, fw: FontWeight.w600)))),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}

Widget _buildOrderGroup({
  required BuildContext context,
  required List<Order> orders,
  required String status,
  required WidgetRef ref,
}) {
  final filteredOrdersComplete = orders.where((element) {
    return element.status?.name == "Completed";
  }).toList();

  filteredOrdersComplete.sort((a, b) {
    int aDate = a.createdAt?.microsecondsSinceEpoch ?? 0;
    return aDate.compareTo(aDate);
  });

  final filteredOrdersCancelled = orders.where((element) {
    return element.status?.name == "Cancelled";
  }).toList();

  filteredOrdersCancelled.sort((a, b) {
    int aDate = a.createdAt?.microsecondsSinceEpoch ?? 0;
    return aDate.compareTo(aDate);
  });

  final filteredOrdersProcessing = orders.where((element) {
    return element.status?.name != "Completed" &&
        element.status?.name != "Cancelled";
  }).toList();

  filteredOrdersProcessing.sort((a, b) {
    int aDate = a.createdAt?.microsecondsSinceEpoch ?? 0;
    return aDate.compareTo(aDate);
  });

  return (status == "Completed"
              ? filteredOrdersComplete
              : status == "Cancelled"
                  ? filteredOrdersCancelled
                  : filteredOrdersProcessing)
          .isEmpty
      ? Center(
          child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            Text("Tidak ada pesanan dengan status ${status.toLowerCase()}.",
                style:
                    appStyle(size: 16, color: mainBlack, fw: FontWeight.w600), textAlign: TextAlign.center,),
          ],
        ))
      : Column(
          children: (status == "Completed"
                  ? filteredOrdersComplete
                  : status == "Cancelled"
                      ? filteredOrdersCancelled
                      : filteredOrdersProcessing)
              .map(
                (order) => Column(
                  children: [
                    Card(
                      surfaceTintColor: Colors.white,
                      elevation: 5,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        style: ListTileStyle.list,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.r,
                                  child: Icon(
                                    (order.status?.name == "Completed")
                                        ? AntIcons.checkOutlined
                                        : (order.status?.name == "Cancelled")
                                            ? AntIcons.closeOutlined
                                            : AntIcons.loading3QuartersOutlined,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ID Pesanan: #${order.code}",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500)),
                                    Text("${order.createdAt?.formatDate()}",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500)),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.chevron_right_outlined)
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Text(
                                  "Harga (${order.orderItemList.map((e) => e.amount).reduce((value, element) => value! + element!)} items)",
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w600),
                                ),
                                const Spacer(),
                                Text(
                                  PriceFormatter.getFormattedValue(
                                      order.finalPriceTotal),
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w500),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Status",
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w600),
                                ),
                                const Spacer(),
                                Text(
                                  order.status?.name ?? "No status",
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
                                Text("Dipesan Oleh",
                                    style: appStyle(
                                        size: 14,
                                        color: mainBlack,
                                        fw: FontWeight.w600)),
                                const Spacer(),
                                // Text("${order.customer?.user?.name} #156789",
                                //     style: appStyle(
                                //         size: 14,
                                //         color: mainBlack,
                                //         fw: FontWeight.w500)),
                                Text("#${order.customer?.customerCode}",
                                    style: appStyle(
                                        size: 14,
                                        color: mainBlack,
                                        fw: FontWeight.w500)),
                              ],
                            ),
                            if (status == "Cancelled") ...[
                              Divider(color: Colors.black.withOpacity(0.5)),
                              Row(
                                children: [
                                  Text("Cancelled At",
                                      style: appStyle(
                                          size: 14,
                                          color: mainBlack,
                                          fw: FontWeight.w600)),
                                  const Spacer(),
                                  Text("${order.cancelledAt?.formatDate()}",
                                      style: appStyle(
                                          size: 14,
                                          color: mainBlack,
                                          fw: FontWeight.w500)),
                                ],
                              ),
                            ] else if (status == "Completed") ...[
                              Divider(color: Colors.black.withOpacity(0.5)),
                              Row(
                                children: [
                                  Text("Completed At",
                                      style: appStyle(
                                          size: 14,
                                          color: mainBlack,
                                          fw: FontWeight.w600)),
                                  const Spacer(),
                                  Text("${order.completedAt?.formatDate()}",
                                      style: appStyle(
                                          size: 14,
                                          color: mainBlack,
                                          fw: FontWeight.w500)),
                                ],
                              ),
                            ],
                            SizedBox(height: 15.h),
                            if (order.status?.name != "Cancelled" &&
                                order.status?.name != "Delivered" &&
                                order.status?.name != "Completed" &&
                                order.status?.name != "On Hold")
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    showPopupModal(
                                        context: context,
                                        title: "Warning",
                                        info: DialogType.warning,
                                        animType: AnimType.scale,
                                        desc:
                                            "Are you sure you want to cancel this order?",
                                        onOkPress: () {
                                          ref
                                              .read(
                                                  internalOrderViewModelProvider
                                                      .notifier)
                                              .cancelOrder(orderId: order.id)
                                              .then((value) => null);
                                        },
                                        onCancelPress: () {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(40),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style: appStyle(
                                        size: 14,
                                        color: Colors.white,
                                        fw: FontWeight.w500),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        onTap: () {
                          ref
                              .read(
                                  orderDetailSelectionNotifierProvider.notifier)
                              .selectOrder(order);
                          Routemaster.of(context)
                              .push("/internal-order/detail");
                        },
                      ),
                    ),
                    SizedBox(height: 15.h)
                  ],
                ),
              )
              .toList(),
        );
}
