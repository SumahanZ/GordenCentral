import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/invoice.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';

final pdfGeneratorRepositoryProvider =
    Provider((ref) => PDFGeneratorRepository(client: ref.watch(httpClient)));

class PDFGeneratorRepository {
  PDFGeneratorRepository({required http.Client client});
  Future<File> generatePDF(List<Invoice> invoice) async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        build: (context) => [
              buildTitle(invoice),
              buildInvoice(invoice),
              pw.Divider(),
              pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
              buildTotal(invoice)
            ],
        footer: (context) => buildFooter(invoice)));

    return saveDocument(name: "my_invoice.pdf", pdf: pdf);
  }

  pw.Widget buildTitle(List<Invoice> invoice) {
    return pw
        .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Row(
          children: [
            pw.RichText(
              text: pw.TextSpan(
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                text: "GORDEN",
                children: [
                  pw.TextSpan(
                    text: "CENTRAL",
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.normal),
                  ),
                ],
              ),
            )
          ],
        ),
        pw.Text("INVOICE",
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold))
      ]),
      pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
      // pw.Text("My description..."),
      buildBillFromSection(null, invoice),
      pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
      pw.Divider(),
      pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Expanded(child: buildBillToSection(null, invoice), flex: 5),
        pw.Spacer(flex: 1),
        pw.Expanded(
            child: buildInvoiceDetailSection(
              null,
              invoice,
            ),
            flex: 4)
      ]),
      pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
    ]);
  }

  pw.Widget buildBillFromSection(
      pw.TextStyle? titleStyle, List<Invoice> invoice) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);
    return pw.Container(
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
          pw.Text(
            "BILL FROM:",
            style: style,
          ),
          pw.SizedBox(height: 5),
          pw.Text(invoice.first.toko?.name ?? "No name"),
          pw.Text(invoice.first.toko?.address?.streetAddress ?? "No Address"),
          pw.Text(
              "${invoice.first.toko?.address?.city?.province?.name.toTitleCase() ?? "No Province"}, ${invoice.first.customer?.address?.city?.name.toTitleCase()}"),
          pw.Text("${invoice.first.toko?.address?.country}"),
          pw.Text("${invoice.first.toko?.address?.postalCode}"),
        ]));
  }

  pw.Widget buildBillToSection(
      pw.TextStyle? titleStyle, List<Invoice> invoice) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);
    return pw.Container(
        child: pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      pw.Text(
        "BILL TO:",
        style: style,
      ),
      pw.SizedBox(height: 5),
      pw.Text(invoice.first.customer?.user?.name ?? "No name"),
      pw.Text(invoice.first.customer?.address?.streetAddress ?? "No Address"),
      pw.Text(
          "${invoice.first.customer?.address?.city?.province?.name.toTitleCase()}, ${invoice.first.customer?.address?.city?.name.toTitleCase()}"),
      pw.Text(invoice.first.customer?.address?.country ?? "No Country"),
      pw.Text(invoice.first.customer?.address?.postalCode ?? "No Postalcode"),
    ]));
  }

  pw.Widget buildInvoiceDetailSection(
      pw.TextStyle? titleStyle, List<Invoice> invoice) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);
    return pw.Container(
        child:
            pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
      pw.Text(
        "INVOICE DATE:",
        style: style,
      ),
      pw.SizedBox(height: 5),
      pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [pw.Text(DateTime.now().formatDatePDF())]),
    ]));
  }

  pw.Widget buildText(
      {required String title,
      required String value,
      double width = double.infinity,
      pw.TextStyle? titleStyle,
      bool unite = true}) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);
    return pw.Container(
        child: pw.Row(children: [
      pw.Expanded(child: pw.Text(title, style: style)),
      pw.Text(value, style: unite ? style : null)
    ]));
  }

  pw.Widget buildSimpleText({required String title, required String value}) {
    final style = pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Text(title, style: style),
          pw.SizedBox(width: 2 * PdfPageFormat.mm),
          pw.Text(value)
        ]);
  }

  pw.Widget buildFooter(List<Invoice> invoice) =>
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
        pw.Divider(),
        pw.SizedBox(height: 2 * PdfPageFormat.mm),
        buildSimpleText(
            title: "",
            value: "Please read the contents of the invoice thoroughly"),
        pw.SizedBox(height: 2 * PdfPageFormat.mm),
        buildSimpleText(title: "Invoice powered by", value: "GordenCentral"),
      ]);

  pw.Widget buildTotal(List<Invoice> invoice) {
    return pw.Container(
        alignment: pw.Alignment.centerRight,
        child:
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Expanded(
            flex: 6,
            child: pw.SizedBox(
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                  pw.Text("Terms & Conditions",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 5),
                  pw.Text("Delivery pricing may vary with location")
                ])),
          ),
          pw.Expanded(
              flex: 4,
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildText(
                        title: "Net total",
                        value: PriceFormatter.getFormattedValue(invoice
                            .map((e) =>
                                (e.cartItem?.amount ?? 0) *
                                (e.cartItem?.produkCombination?.product
                                        ?.price ??
                                    0.toDouble()))
                            .toList()
                            .reduce((value, element) => value + element))),
                    pw.SizedBox(height: 5),
                    buildText(
                        title: "Discount total",
                        value: "- ${PriceFormatter.getFormattedValue(invoice.map((e) {
                              double discount = 0;

                              if (e.cartItem?.produkCombination?.product
                                          ?.promo !=
                                      null &&
                                  (e.cartItem?.produkCombination?.product?.promo
                                              ?.expiredAt ??
                                          DateTime.now())
                                      .isAfter(DateTime.now())) {
                                double discountPercent = e
                                        .cartItem
                                        ?.produkCombination
                                        ?.product
                                        ?.promo
                                        ?.discountPercent
                                        ?.toDouble() ??
                                    0;
                                double itemPrice = e.cartItem?.produkCombination
                                        ?.product?.price
                                        ?.toDouble() ??
                                    0;
                                double discountedPrice =
                                    itemPrice * (discountPercent / 100);
                                discount =
                                    discountedPrice * (e.cartItem?.amount ?? 0);
                              }

                              return discount;
                            }).toList().reduce((value, element) => value + element))}"),
                    pw.Divider(),
                    buildText(
                        title: "Total amount",
                        titleStyle: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold),
                        value: PriceFormatter.getFormattedValue(invoice
                            .map((e) =>
                                (e.cartItem?.amount ?? 0) *
                                ((e.cartItem?.produkCombination?.product?.promo == null ||
                                            (e.cartItem?.produkCombination?.product?.promo?.expiredAt ?? DateTime.now())
                                                .isBefore(DateTime.now())
                                        ? e.cartItem?.produkCombination?.product?.price ??
                                            0
                                        : (e.cartItem?.produkCombination?.product?.price ?? 0) -
                                            (e.cartItem?.produkCombination?.product?.price ?? 0) *
                                                ((e
                                                            .cartItem
                                                            ?.produkCombination
                                                            ?.product
                                                            ?.promo
                                                            ?.discountPercent
                                                            ?.toInt() ??
                                                        0) /
                                                    100))
                                    .toDouble()))
                            .toList()
                            .reduce((value, element) => value + element))),
                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    pw.Container(height: 1, color: PdfColors.grey400),
                    pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                    pw.Container(height: 1, color: PdfColors.grey400),
                  ]))
        ]));
  }

  pw.Widget buildInvoice(List<Invoice> invoice) {
    final headers = ["Name", "Quantity", "Price", "Discount", "Total Price"];

    final data = invoice.map((e) {
      return [
        e.cartItem?.produkCombination?.product?.name,
        e.cartItem?.amount,
        PriceFormatter.getFormattedValue(invoice
            .map(
              (e) {
                return (e.cartItem?.produkCombination?.product?.price ?? 0) *
                    (e.cartItem?.amount ?? 1);
              },
            )
            .toList()
            .reduce((value, element) => value + element)),
        (e.cartItem?.produkCombination?.product?.promo == null ||
                (e.cartItem?.produkCombination?.product?.promo?.expiredAt ??
                        DateTime.now())
                    .isBefore(DateTime.now()))
            ? "None"
            : "${e.cartItem?.produkCombination?.product?.promo?.discountPercent}%",
        PriceFormatter.getFormattedValue(invoice
            .map((e) => e.cartItem)
            .toList()
            .map((e) =>
                (e?.amount ?? 0) *
                ((e?.produkCombination?.product?.promo == null ||
                            (e?.produkCombination?.product?.promo?.expiredAt ??
                                    DateTime.now())
                                .isBefore(DateTime.now())
                        ? e?.produkCombination?.product?.price ?? 0
                        : (e?.produkCombination?.product?.price ?? 0) -
                            (e?.produkCombination?.product?.price ?? 0) *
                                ((e?.produkCombination?.product?.promo
                                            ?.discountPercent
                                            ?.toInt() ??
                                        0) /
                                    100))
                    .toDouble()))
            .toList()
            .reduce((value, element) => value + element))
      ];
    }).toList();

    return pw.TableHelper.fromTextArray(
        headers: headers,
        data: data,
        border: null,
        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
        cellHeight: 30,
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.centerRight,
          2: pw.Alignment.centerRight,
          3: pw.Alignment.centerRight,
          4: pw.Alignment.centerRight,
        });
  }

  Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    Directory? directory;
    final bytes = await pdf.save();

    if (Platform.isAndroid) {
          directory = await getExternalStorageDirectory();
        } else {
          directory = await getApplicationDocumentsDirectory();
        }

    final file = File('${directory?.path}/$name');

    await file.writeAsBytes(bytes);
    return file;
  }

  Future openFile(File file) async {
    final url = file.path;
    try {
      await OpenFile.open(url);
    } catch (e) {
      print(e.toString());
    }
  }
}
