import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tugas_akhir_project/core/internal/notifications/repositories/implementations/internal_notification_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/settings/repositories/implementations/internal_settings_repository_impl.dart';
import 'package:tugas_akhir_project/models/toko_notification.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/either_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalNotificationPage extends ConsumerStatefulWidget {
  const InternalNotificationPage({super.key});

  @override
  ConsumerState<InternalNotificationPage> createState() =>
      _InternalNotificationPageState();
}

class _InternalNotificationPageState
    extends ConsumerState<InternalNotificationPage>
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
    final tokoNotifications = ref.watch(fetchAllTokoNotifications);
    final internalInformation = ref.watch(fetchInternalInformation);

    return Scaffold(
        appBar: AppBar(
          bottom: internalInformation.asData?.value.unwrapRight()?.status !=
                  "joined"
              ? null
              : TabBar(
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
                    Tab(text: "Stok"),
                    Tab(text: "Pesanan"),
                    Tab(text: "Internal")
                  ],
                ),
          title: Text(
            "Notifikasi",
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
                  : tokoNotifications.maybeWhen(
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
                                InternalNotificationSectionStok(
                                  stokNotifications: r.isNotEmpty
                                      ? r
                                          .filter((t) =>
                                              t.tokonotificationtype?.name ==
                                              "Stock")
                                          .toList()
                                      : [],
                                ),
                                InternalNotificationSectionOrder(
                                  orderNotifications: r.isNotEmpty
                                      ? r
                                          .filter((t) =>
                                              t.tokonotificationtype?.name ==
                                              "Order")
                                          .toList()
                                      : [],
                                ),
                                InternalNotificationSectionInternalToko(
                                  internalTokoNotifications: r.isNotEmpty
                                      ? r
                                          .filter((t) =>
                                              t.tokonotificationtype?.name ==
                                              "Internal Toko")
                                          .toList()
                                      : [],
                                )
                              ]);
                        });
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      orElse: () => const SizedBox.shrink());
            },
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}

class InternalNotificationSectionOrder extends StatelessWidget {
  final List<TokoNotification> orderNotifications;
  const InternalNotificationSectionOrder({
    super.key,
    required this.orderNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: orderNotifications.isEmpty
              ? Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    Center(
                        child: Text("Tidak ada notifikasi pesanan",
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600))),
                  ],
                )
              : Builder(builder: (context) {
                  List<TokoNotification> todayNotification = [];
                  List<TokoNotification> yesterdayNotification = [];
                  List<TokoNotification> thisWeekNotification = [];
                  List<TokoNotification> thisMonthNotification = [];
                  List<TokoNotification> earlierNotifications = [];
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final yesterday = today.subtract(const Duration(days: 1));
                  final firstDayOfWeek =
                      today.subtract(Duration(days: today.weekday - 1));
                  final firstDayOfMonth = DateTime(now.year, now.month, 1);

                  for (var notification in orderNotifications) {
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
                        _buildNotificationGroup(context, 'Hari Ini',
                            todayNotification, NotificationTimestamp.today),
                        const SizedBox(height: 20),
                      ],
                      if (yesterdayNotification.isNotEmpty) ...[
                        _buildNotificationGroup(
                            context,
                            'Kemarin',
                            yesterdayNotification,
                            NotificationTimestamp.yesterday),
                        const SizedBox(height: 20),
                      ],
                      if (thisWeekNotification.isNotEmpty) ...[
                        _buildNotificationGroup(context, 'Minggu Ini',
                            thisWeekNotification, NotificationTimestamp.other),
                        const SizedBox(height: 20),
                      ],
                      if (thisMonthNotification.isNotEmpty) ...[
                        _buildNotificationGroup(context, 'Bulan Ini',
                            thisMonthNotification, NotificationTimestamp.other),
                      ],
                      if (earlierNotifications.isNotEmpty) ...[
                        _buildNotificationGroup(context, 'Lebih Awal',
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

class InternalNotificationSectionStok extends StatelessWidget {
  final List<TokoNotification> stokNotifications;
  const InternalNotificationSectionStok({
    super.key,
    required this.stokNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: stokNotifications.isEmpty
              ? Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    Center(
                        child: Text("Tidak ada notifikasi stok",
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600))),
                  ],
                )
              : Builder(builder: (context) {
                  List<TokoNotification> todayNotification = [];
                  List<TokoNotification> yesterdayNotification = [];
                  List<TokoNotification> thisWeekNotification = [];
                  List<TokoNotification> thisMonthNotification = [];
                  List<TokoNotification> earlierNotifications = [];
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final yesterday = today.subtract(const Duration(days: 1));
                  final firstDayOfWeek =
                      today.subtract(Duration(days: today.weekday - 1));
                  final firstDayOfMonth = DateTime(now.year, now.month, 1);

                  for (var notification in stokNotifications) {
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
                        _buildNotificationGroup(context, 'Hari Ini',
                            todayNotification, NotificationTimestamp.today),
                        const SizedBox(height: 20),
                      ],
                      if (yesterdayNotification.isNotEmpty) ...[
                        _buildNotificationGroup(
                            context,
                            'Kemarin',
                            yesterdayNotification,
                            NotificationTimestamp.yesterday),
                        const SizedBox(height: 20),
                      ],
                      if (thisWeekNotification.isNotEmpty) ...[
                        _buildNotificationGroup(context, 'Minggu Ini',
                            thisWeekNotification, NotificationTimestamp.other),
                        const SizedBox(height: 20),
                      ],
                      if (thisMonthNotification.isNotEmpty) ...[
                        _buildNotificationGroup(context, 'Bulan Ini',
                            thisMonthNotification, NotificationTimestamp.other),
                      ],
                      if (earlierNotifications.isNotEmpty) ...[
                        _buildNotificationGroup(context, 'Lebih Awal',
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

class InternalNotificationSectionInternalToko extends StatelessWidget {
  final List<TokoNotification> internalTokoNotifications;
  const InternalNotificationSectionInternalToko({
    super.key,
    required this.internalTokoNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: internalTokoNotifications.isEmpty
              ? Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    Center(
                        child: Text("Tidak ada notifikasi internal",
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600))),
                  ],
                )
              : Builder(builder: (context) {
                  List<TokoNotification> todayNotification = [];
                  List<TokoNotification> yesterdayNotification = [];
                  List<TokoNotification> thisWeekNotification = [];
                  List<TokoNotification> thisMonthNotification = [];
                  List<TokoNotification> earlierNotifications = [];
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final yesterday = today.subtract(const Duration(days: 1));
                  final firstDayOfWeek =
                      today.subtract(Duration(days: today.weekday - 1));
                  final firstDayOfMonth = DateTime(now.year, now.month, 1);

                  for (var notification in internalTokoNotifications) {
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
                        _buildNotificationGroup(context, 'Hari Ini',
                            todayNotification, NotificationTimestamp.today),
                        const SizedBox(height: 20),
                      ],
                      if (yesterdayNotification.isNotEmpty) ...[
                        _buildNotificationGroup(
                            context,
                            'Kemarin',
                            yesterdayNotification,
                            NotificationTimestamp.yesterday),
                        const SizedBox(height: 20),
                      ],
                      if (thisWeekNotification.isNotEmpty) ...[
                        _buildNotificationGroup(context, 'Minggu Ini',
                            thisWeekNotification, NotificationTimestamp.other),
                        const SizedBox(height: 20),
                      ],
                      if (thisMonthNotification.isNotEmpty) ...[
                        _buildNotificationGroup(context, 'Bulan Ini',
                            thisMonthNotification, NotificationTimestamp.other),
                      ],
                      if (earlierNotifications.isNotEmpty) ...[
                        _buildNotificationGroup(context, 'Lebih Awal',
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

Widget _buildNotificationGroup(BuildContext context, String date,
    List<TokoNotification> notifications, NotificationTimestamp timeStamp) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          date,
          style: appStyle(size: 16, color: mainBlack, fw: FontWeight.w600),
        ),
      ),
      const SizedBox(height: 10),
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
                            const SizedBox(height: 5),
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
                const SizedBox(height: 10)
              ],
            );
          }),
    ],
  );
}

enum NotificationTimestamp { today, yesterday, other }
