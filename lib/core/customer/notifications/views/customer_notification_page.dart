import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tugas_akhir_project/core/customer/notifications/repositories/implementations/customer_notification_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/notifications/views/internal_notification_page.dart';
import 'package:tugas_akhir_project/models/customer_notification.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerNotificationPage extends ConsumerStatefulWidget {
  const CustomerNotificationPage({super.key});

  @override
  ConsumerState<CustomerNotificationPage> createState() => _CustomerNotificationPageState();
}

class _CustomerNotificationPageState extends ConsumerState<CustomerNotificationPage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customerNotifications = ref.watch(fetchAllCustomerNotifications);
    return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    // Use the default focused overlay color
                    return states.contains(MaterialState.focused)
                        ? null
                        : Colors.transparent;
                  }),
                  // dividerColor: Colors.transparent,
                  padding: const EdgeInsets.all(0),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.transparent,
                  controller: _tabController,
                  labelColor: Colors.purple,
                  labelStyle:
                      appStyle(size: 16, color: mainBlack, fw: FontWeight.bold),
                  unselectedLabelColor: Colors.black.withOpacity(0.2),
                  tabs: const [
                    Tab(text: "Promo"),
                    Tab(text: "Pesanan"),
                  ],
                ),
          title: Text(
            "Notifikasi",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: customerNotifications.when(
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
                  CustomerNotificationSectionPromo(
                    promoNotifications: r.isNotEmpty
                        ? r
                            .filter((t) =>
                                t.customernotificationtype?.name == "Promo")
                            .toList()
                        : [],
                  ),
                  CustomerNotificationSectionPesanan(
                    pesananNotifications: r.isNotEmpty
                        ? r
                            .filter((t) =>
                                t.customernotificationtype?.name == "Order")
                            .toList()
                        : [],
                  ),
                ]);
              });
            },
            error: ((error, stackTrace) =>
                Center(child: Text(error.toString()))),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}

class CustomerNotificationSectionPromo extends StatelessWidget {
  final List<CustomerNotification> promoNotifications;
  const CustomerNotificationSectionPromo({
    super.key,
    required this.promoNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: promoNotifications.isEmpty
              ? Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    Center(
                        child: Text("Tidak ada notifikasi pesanan",
                            textAlign: TextAlign.center,
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600))),
                  ],
                )
              : Builder(builder: (context) {
                  List<CustomerNotification> todayNotification = [];
                  List<CustomerNotification> yesterdayNotification = [];
                  List<CustomerNotification> thisWeekNotification = [];
                  List<CustomerNotification> thisMonthNotification = [];
                  List<CustomerNotification> earlierNotifications = [];
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final yesterday = today.subtract(const Duration(days: 1));
                  final firstDayOfWeek =
                      today.subtract(Duration(days: today.weekday - 1));
                  final firstDayOfMonth = DateTime(now.year, now.month, 1);

                  for (var notification in promoNotifications) {
                    if (notification.createdAt?.year == now.year &&
                        notification.createdAt?.month == now.month &&
                        notification.createdAt?.day == now.day) {
                      todayNotification.add(notification);
                    } else if (notification.createdAt?.year == yesterday.year &&
                        notification.createdAt?.month == yesterday.month &&
                        notification.createdAt?.day == yesterday.day) {
                      yesterdayNotification.add(notification);
                    } else if (notification.createdAt!.isAfter(
                            firstDayOfWeek.subtract(const Duration(days: 1))) &&
                        notification.createdAt!.isBefore(today)) {
                      thisWeekNotification.add(notification);
                    } else if (notification.createdAt!.isAfter(firstDayOfMonth
                            .subtract(const Duration(days: 1))) &&
                        notification.createdAt!.isBefore(today)) {
                      thisMonthNotification.add(notification);
                    } else {
                      earlierNotifications.add(notification);
                    }
                  }

                  return Column(
                    children: [
                      if (todayNotification.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(context, 'Hari Ini',
                            todayNotification, NotificationTimestamp.today),
                        SizedBox(height: 20.h),
                      ],
                      if (yesterdayNotification.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(
                            context,
                            'Kemarin',
                            yesterdayNotification,
                            NotificationTimestamp.yesterday),
                        SizedBox(height: 20.h),
                      ],
                      if (thisWeekNotification.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(context, 'Minggu Ini',
                            thisWeekNotification, NotificationTimestamp.other),
                        SizedBox(height: 20.h),
                      ],
                      if (thisMonthNotification.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(context, 'Bulan Ini',
                            thisMonthNotification, NotificationTimestamp.other),
                      ],
                      if (earlierNotifications.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(context, 'Lebih Awal',
                            earlierNotifications, NotificationTimestamp.other),
                      ],
                    ],
                  );
                }),
        ),
      ),
    );
  }
}

class CustomerNotificationSectionPesanan extends StatelessWidget {
  final List<CustomerNotification> pesananNotifications;
  const CustomerNotificationSectionPesanan({
    super.key,
    required this.pesananNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: pesananNotifications.isEmpty
              ? Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    Center(
                        child: Text("Tidak ada notifikasi pesanan",
                            textAlign: TextAlign.center,
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600))),
                  ],
                )
              : Builder(builder: (context) {
                  List<CustomerNotification> todayNotification = [];
                  List<CustomerNotification> yesterdayNotification = [];
                  List<CustomerNotification> thisWeekNotification = [];
                  List<CustomerNotification> thisMonthNotification = [];
                  List<CustomerNotification> earlierNotifications = [];
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final yesterday = today.subtract(const Duration(days: 1));
                  final firstDayOfWeek =
                      today.subtract(Duration(days: today.weekday - 1));
                  final firstDayOfMonth = DateTime(now.year, now.month, 1);

                  for (var notification in pesananNotifications) {
                    if (notification.createdAt?.year == now.year &&
                        notification.createdAt?.month == now.month &&
                        notification.createdAt?.day == now.day) {
                      todayNotification.add(notification);
                    } else if (notification.createdAt?.year == yesterday.year &&
                        notification.createdAt?.month == yesterday.month &&
                        notification.createdAt?.day == yesterday.day) {
                      yesterdayNotification.add(notification);
                    } else if (notification.createdAt!.isAfter(
                            firstDayOfWeek.subtract(const Duration(days: 1))) &&
                        notification.createdAt!.isBefore(today)) {
                      thisWeekNotification.add(notification);
                    } else if (notification.createdAt!.isAfter(firstDayOfMonth
                            .subtract(const Duration(days: 1))) &&
                        notification.createdAt!.isBefore(today)) {
                      thisMonthNotification.add(notification);
                    } else {
                      earlierNotifications.add(notification);
                    }
                  }

                  return Column(
                    children: [
                      if (todayNotification.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(context, 'Hari Ini',
                            todayNotification, NotificationTimestamp.today),
                        SizedBox(height: 20.h),
                      ],
                      if (yesterdayNotification.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(
                            context,
                            'Kemarin',
                            yesterdayNotification,
                            NotificationTimestamp.yesterday),
                        SizedBox(height: 20.h),
                      ],
                      if (thisWeekNotification.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(context, 'Minggu Ini',
                            thisWeekNotification, NotificationTimestamp.other),
                        SizedBox(height: 20.h),
                      ],
                      if (thisMonthNotification.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(context, 'Bulan Ini',
                            thisMonthNotification, NotificationTimestamp.other),
                      ],
                      if (earlierNotifications.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(context, 'Lebih Awal',
                            earlierNotifications, NotificationTimestamp.other),
                      ],
                    ],
                  );
                }),
        ),
      ),
    );
  }
}

Widget _buildNotificationGroupCustomer(BuildContext context, String date,
    List<CustomerNotification> notifications, NotificationTimestamp timeStamp) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10.h),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          date,
          style: appStyle(size: 16, color: mainBlack, fw: FontWeight.w600),
        ),
      ),
      SizedBox(height: 10.h),
      ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (builder, index) {
            return Column(
              children: [
                Card(
                  surfaceTintColor: Colors.white,
                  elevation: 5,
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        style: ListTileStyle.list,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                notifications[index].description ??
                                    "No description",
                                style: appStyle(
                                    size: 13,
                                    color: mainBlack,
                                    fw: FontWeight.w500)),
                            SizedBox(height: 5.h),
                            Text(
                              timeStamp == NotificationTimestamp.other
                                  ? (notifications[index].createdAt ??
                                          DateTime.now())
                                      .formatDate()
                                  : timeStamp == NotificationTimestamp.yesterday
                                      ? (notifications[index].createdAt ??
                                              DateTime.now())
                                          .timeOnly()
                                      : DateTimeHourMin.formatTimeDifference(
                                          notifications[index].createdAt ??
                                              DateTime.now(),
                                          DateTime.now()),
                              style: appStyle(
                                  size: 14,
                                  color: Colors.black.withOpacity(0.5),
                                  fw: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h)
              ],
            );
          }),
    ],
  );
}
