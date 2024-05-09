import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tugas_akhir_project/core/customer/notifications/repositories/implementations/customer_notification_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/notifications/views/internal_notification_page.dart';
import 'package:tugas_akhir_project/models/customer_notification.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerNotificationPage extends ConsumerWidget {
  const CustomerNotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notifikasi",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: ref.watch(fetchAllCustomerNotifications).when(
            data: (data) {
              return data.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (r) {
                return CustomerNotificationSectionPromo(
                  promoNotifications: r.isNotEmpty
                      ? r
                          .filter((t) =>
                              t.customernotificationtype?.name == "Promo")
                          .toList()
                      : [],
                );
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
                        const SizedBox(height: 20),
                      ],
                      if (yesterdayNotification.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(
                            context,
                            'Kemarin',
                            yesterdayNotification,
                            NotificationTimestamp.yesterday),
                        const SizedBox(height: 20),
                      ],
                      if (thisWeekNotification.isNotEmpty) ...[
                        _buildNotificationGroupCustomer(context, 'Minggu Ini',
                            thisWeekNotification, NotificationTimestamp.other),
                        const SizedBox(height: 20),
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
