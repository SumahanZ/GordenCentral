import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/analisiskeuangan/repositories/implementations/internal_analisiskeuangan_repository_impl.dart';
import 'package:tugas_akhir_project/models/order.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/integer_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_chart_widget.dart';

class InternalAnalisaKeuanganPage extends ConsumerStatefulWidget {
  const InternalAnalisaKeuanganPage({super.key});

  @override
  ConsumerState<InternalAnalisaKeuanganPage> createState() =>
      _InternalAnalisaKeuanganPageState();
}

class _InternalAnalisaKeuanganPageState
    extends ConsumerState<InternalAnalisaKeuanganPage> {
  late TooltipBehavior _tooltipBehavior;
  String salesReportModeSelection = "Minggu Ini";

  List<SalesData> getSalesData(
      {String? selectedDropdownMode,
      required List<Order> completedTransactions}) {
    List<SalesData> finalList = [];

    if (completedTransactions.isEmpty) {
      return finalList;
    }

    switch (selectedDropdownMode) {
      case "Minggu Ini":
        final daysOfCurrentWeek = getDaysOfCurrentWeek();
        for (var day in daysOfCurrentWeek) {
          final filteredTransactions = completedTransactions.where((element) {
            return isInDay(element.completedAt ?? DateTime.now(), day);
          }).toList();
          final salesData = SalesData(
              timeFrame: day.getDayOfWeek().substring(0, 3),
              salesAmount: filteredTransactions.isNotEmpty
                  ? filteredTransactions
                      .map(
                        (e) => e.finalPriceTotal,
                      )
                      .reduce((value, element) => value + element)
                  : 0);
          finalList.add(salesData);
        }
        break;
      case "Bulan Ini":
        final weeks = getWeeksInMonth();

        for (var week in weeks) {
          final filteredTransactions = completedTransactions.where((element) {
            return isDateTimeInWeek(
                element.completedAt ?? DateTime.now(), week);
          });
          final salesData = SalesData(
              timeFrame: "Minggu ${weeks.indexOf(week) + 1}",
              salesAmount: filteredTransactions.isNotEmpty
                  ? filteredTransactions
                      .map(
                        (e) => e.finalPriceTotal,
                      )
                      .reduce((value, element) => value + element)
                  : 0);
          finalList.add(salesData);
        }
        break;
      case "Tahun Ini":
        final monthsOfCurrentYear = getAllMonthsOfCurrentYear();
        for (var month in monthsOfCurrentYear) {
          final filteredTransactions = completedTransactions.where((element) {
            return isInMonth(element.completedAt ?? DateTime.now(), month);
          });
          final salesData = SalesData(
              timeFrame: month.getMonth().substring(0, 3),
              salesAmount: filteredTransactions.isNotEmpty
                  ? filteredTransactions
                      .map(
                        (e) => e.finalPriceTotal,
                      )
                      .reduce((value, element) => value + element)
                  : 0);
          finalList.add(salesData);
        }
        break;

      default:
        return [];
    }
    return finalList;
  }

  bool isDateTimeInWeek(DateTime dateTime, List<DateTime> week) {
    DateTime startOfWeek = week.first;
    DateTime endOfWeek = week.last;
    return dateTime.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        dateTime.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  bool isInMonth(DateTime inputtedDateTime, DateTime checkerDateTime) {
    return inputtedDateTime.year == checkerDateTime.year &&
        inputtedDateTime.month == checkerDateTime.month;
  }

  bool isInDay(DateTime inputtedDateTime, DateTime checkerDateTime) {
    return inputtedDateTime.year == checkerDateTime.year &&
        inputtedDateTime.month == checkerDateTime.month &&
        inputtedDateTime.day == checkerDateTime.day;
  }

  List<DateTime> getDaysOfCurrentWeek() {
    DateTime now = DateTime.now();

    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    List<DateTime> daysOfWeek = [];

    for (DateTime day = startOfWeek;
        day.isBefore(endOfWeek) || day == endOfWeek;
        day = day.add(const Duration(days: 1))) {
      daysOfWeek.add(day);
    }

    return daysOfWeek;
  }

  List<DateTime> getAllMonthsOfCurrentYear() {
    DateTime now = DateTime.now();
    int currentYear = now.year;

    List<DateTime> months = [];

    for (int month = 1; month <= 12; month++) {
      months.add(DateTime(currentYear, month));
    }

    return months;
  }

  List<List<DateTime>> getWeeksInMonth() {
    final now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);

    DateTime lastDayOfMonth =
        DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));

    List<List<DateTime>> weeks = [];

    DateTime currentDay = firstDayOfMonth;
    while (
        currentDay.isBefore(lastDayOfMonth) || currentDay == lastDayOfMonth) {
      DateTime startOfWeek =
          currentDay.subtract(Duration(days: currentDay.weekday % 7));

      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

      List<DateTime> weekDays = [];
      for (DateTime day = startOfWeek;
          day.isBefore(endOfWeek) || day == endOfWeek;
          day = day.add(const Duration(days: 1))) {
        weekDays.add(day);
      }

      weeks.add(weekDays);

      currentDay = endOfWeek.add(const Duration(days: 1));

      if (weeks.length >= 4) {
        break;
      }
    }

    // Add remaining days of the month to the last week
    DateTime lastDayOfLastWeek = weeks.last.last;

    while (lastDayOfLastWeek.isBefore(lastDayOfMonth)) {
      lastDayOfLastWeek = lastDayOfLastWeek.add(const Duration(days: 1));
      weeks.last.add(lastDayOfLastWeek);

      // Update the last day of the last week
      lastDayOfLastWeek = weeks.last.last;
    }

    for (var week in weeks) {
      week.removeWhere((day) => day.month != now.month);
    }

    return weeks;
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final analisisKeuanganInformation =
        ref.watch(fetchAnalisisKeuanganInformationProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Analisa Keuangan",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: analisisKeuanganInformation.maybeWhen(
            data: (data) {
              return data.generalInformation.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (generalInformation) {
                return data.recentTransactions.match(
                    (l) => Center(
                        child: Text(l.message,
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600))), (recentTransactions) {
                  return data.salesReport.match(
                      (l) => Center(
                          child: Text(l.message,
                              style: appStyle(
                                  size: 16,
                                  color: mainBlack,
                                  fw: FontWeight.w600))), (salesReport) {
                    final salesData = getSalesData(
                        selectedDropdownMode: salesReportModeSelection,
                        completedTransactions: salesReport);
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(children: [
                            const TopSectionAuth(
                                name: "Analisis Keuangan",
                                description:
                                    "Analisis penjualan dan pendapatan Anda",
                                isAvatarNeeded: false),
                            const SizedBox(height: 20),
                            Card(
                              surfaceTintColor: Colors.white,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20),
                                child: Column(children: [
                                  IntrinsicHeight(
                                    child: Row(children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Informasi Pesanan:",
                                                style: appStyle(
                                                    size: 20,
                                                    color: mainBlack,
                                                    fw: FontWeight.w600)),
                                            const SizedBox(height: 20),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(children: [
                                                    Text(
                                                        ((generalInformation[
                                                                    "productSold"] ??
                                                                0) as int)
                                                            .formatOrderCount(),
                                                        style: appStyle(
                                                            size: 20,
                                                            color: mainBlack,
                                                            fw: FontWeight
                                                                .bold)),
                                                    ConstrainedBox(
                                                      constraints:
                                                          const BoxConstraints(
                                                        minWidth: 100,
                                                        maxWidth: 120,
                                                      ),
                                                      child: Text(
                                                          "Jumlah \n Terjual",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: appStyle(
                                                              size: 16,
                                                              color: mainBlack,
                                                              fw: FontWeight
                                                                  .w500)),
                                                    )
                                                  ]),
                                                  Column(children: [
                                                    Text(
                                                        ((generalInformation[
                                                                    "transactionsCompleted"] ??
                                                                0) as int)
                                                            .formatOrderCount(),
                                                        style: appStyle(
                                                            size: 20,
                                                            color: mainBlack,
                                                            fw: FontWeight
                                                                .bold)),
                                                    ConstrainedBox(
                                                      constraints:
                                                          const BoxConstraints(
                                                        minWidth: 100,
                                                        maxWidth: 120,
                                                      ),
                                                      child: Text(
                                                          "Transaksi Selesai",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: appStyle(
                                                              size: 16,
                                                              color: mainBlack,
                                                              fw: FontWeight
                                                                  .w500)),
                                                    )
                                                  ])
                                                ]),
                                            const SizedBox(height: 15),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ]),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Card(
                              surfaceTintColor: Colors.white,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total Penjualan:",
                                          style: appStyle(
                                              size: 16,
                                              color: mainBlack,
                                              fw: FontWeight.w600)),
                                      Text(
                                          PriceFormatter.getFormattedValue(
                                              generalInformation[
                                                      "totalSalesPrice"]
                                                  .toDouble()),
                                          style: appStyle(
                                              size: 18,
                                              color: mainBlack,
                                              fw: FontWeight.bold))
                                    ]),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              children: [
                                Text(
                                  "Laporan Penjualan (Rp)",
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w500),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: CustomDropdownChart(
                                      values: const [
                                        "Minggu Ini",
                                        "Bulan Ini",
                                        "Tahun Ini"
                                      ],
                                      onChanged: (value) {
                                        if (salesReportModeSelection != value) {
                                          setState(() {
                                            salesReportModeSelection =
                                                value ?? "";
                                          });
                                        }
                                      }),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              height: 400,
                              child: salesData.isEmpty
                                  ? Center(
                                      child: Text("Data kosong",
                                          style: appStyle(
                                              size: 18,
                                              color: mainBlack,
                                              fw: FontWeight.bold)))
                                  : SfCartesianChart(
                                      margin: const EdgeInsets.all(5),
                                      enableAxisAnimation: false,
                                      primaryXAxis: CategoryAxis(
                                        labelAlignment: LabelAlignment.center,
                                        maximumLabels: 4,
                                        initialZoomFactor: 1,
                                        rangePadding: ChartRangePadding.round,
                                        labelPlacement: LabelPlacement.onTicks,
                                        labelStyle: appStyle(
                                            size: 10,
                                            color: mainBlack,
                                            fw: FontWeight.w600),
                                      ),
                                      primaryYAxis: NumericAxis(
                                          maximumLabels: 2,
                                          initialZoomFactor: 1,
                                          rangePadding:
                                              ChartRangePadding.normal,
                                          labelPosition:
                                              ChartDataLabelPosition.outside,
                                          labelStyle: appStyle(
                                              size: 10,
                                              color: mainBlack,
                                              fw: FontWeight.w600)),
                                      tooltipBehavior: _tooltipBehavior,
                                      series: <LineSeries<SalesData, String>>[
                                          LineSeries(
                                              dataSource: salesData,
                                              width: 3,
                                              xValueMapper: (sales, _) =>
                                                  sales.timeFrame,
                                              yValueMapper: (sales, _) =>
                                                  sales.salesAmount,
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                builder: (data, point, series,
                                                    pointIndex, seriesIndex) {
                                                  if ((data as SalesData)
                                                          .salesAmount ==
                                                      0) {
                                                    return Text("",
                                                        style: appStyle(
                                                            size: 10,
                                                            color: mainBlack,
                                                            fw: FontWeight
                                                                .w600));
                                                  } else {
                                                    return Text(
                                                        PriceFormatter
                                                            .getFormattedValue2(
                                                                (data)
                                                                    .salesAmount),
                                                        style: appStyle(
                                                            size: 10,
                                                            color: mainBlack,
                                                            fw: FontWeight
                                                                .w600));
                                                  }
                                                },
                                                labelAlignment:
                                                    ChartDataLabelAlignment
                                                        .bottom,
                                                alignment:
                                                    ChartAlignment.center,
                                                isVisible: true,
                                              ))
                                        ]),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              children: [
                                Text(
                                  "Transaksi Terbaru",
                                  style: appStyle(
                                      size: 18,
                                      color: mainBlack,
                                      fw: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: recentTransactions.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  surfaceTintColor: Colors.white,
                                  elevation: 5,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
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
                                                  "ID Pesanan: #${recentTransactions[index].code}",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.bold)),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${recentTransactions[index].customer?.user?.name} #123234",
                                                    style: appStyle(
                                                      size: 12,
                                                      color: mainBlack,
                                                      fw: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    recentTransactions[index]
                                                            .completedAt
                                                            ?.formatDate() ??
                                                        "",
                                                    style: appStyle(
                                                      size: 12,
                                                      color: mainBlack,
                                                      fw: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "+${PriceFormatter.getFormattedValue(recentTransactions[index].finalPriceTotal)}",
                                                  style: appStyle(
                                                    size: 16,
                                                    color: mainBlack,
                                                    fw: FontWeight.bold,
                                                  ))
                                            ],
                                          ),
                                        ]),
                                      ),
                                    ]),
                                  ),
                                );
                              },
                            )
                            //list of transactions (5 only)
                          ]),
                        ),
                      ),
                    );
                  });
                });
              });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const SizedBox.shrink()));
  }
}

class SalesData {
  SalesData({required this.timeFrame, required this.salesAmount});
  final String timeFrame;
  final double salesAmount;
}
