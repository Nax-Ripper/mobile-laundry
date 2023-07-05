import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/models/invoice_model.dart';
import 'package:mobile_laundry/models/orders_model.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class InvoiceController extends GetxController {
  InvoiceController({required this.order});
  Orders order;

  List<Invoice> invoice = [];
  double totalAmount = 0;
  AuthController auth = Get.find<AuthController>();

  DataTable buildDataTable =
      DataTable(columns: [DataColumn(label: Text('hi'))], rows: []);

  getInvoice(Orders order) {
    invoice.clear();
    for (var i = 0; i < order.products!.length; i++) {
      log("Name==>");
      log(order.products![i].name!);

      log(order.products![i].price!.toString());

      log('quantitiy');
      log(order.products![i].quantity!.toString());

      invoice.add(Invoice(
          name: order.products![i].name!,
          rate: order.products![i].price.toString(),
          quantity: order.products![i].quantity!,
          amount: calculateAmount(
              order.products![i].price!, order.products![i].quantity!)));
    }

    invoice.add(Invoice(
        name: 'Rider Fee',
        rate: order.riderFee.toString(),
        quantity: 1,
        amount: order.riderFee!.toDouble()));
    invoice.add(Invoice(
        name: 'Service Fee',
        rate: order.serviceFee.toString(),
        quantity: 1,
        amount: order.serviceFee!.toDouble()));

    log('Invoice == >${invoice.length.toString()}  ||  ${invoice.first.amount}');
    final columns = ['Item', 'Rate', 'Quantity', 'Amount'];
    buildDataTable =
        DataTable(columns: getColumn(columns), rows: getRows(invoice));
    totalAmount = order.totalFee!;
    update();
  }

  Future<void> accepted(id) async {
    try {
      var body = {"id": order.id, "accept": true};
      log('${body}');
      var res = await http
          .post(Uri.parse('$uri/api/accept'), body: jsonEncode(body), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
       log('${res.body}');
    } catch (e) {
      log(e.toString());
    }
  }

  double calculateAmount(double price, int quantity) {
    return price * quantity;
  }

  List<DataColumn> getColumn(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();

  List<DataRow> getRows(List<Invoice> invoices) {
    return invoices.map((Invoice invoice) {
      final cells = [
        invoice.name,
        invoice.rate,
        invoice.quantity,
        invoice.amount
      ];
      return DataRow(cells: getCells(cells));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) {
    return cells.map((data) => DataCell(Text('$data'))).toList();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getInvoice(order);
  }

  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Rate';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Item';
    headerRow.cells[2].value = 'Quantity';
    headerRow.cells[3].value = 'Total';
    // headerRow.cells[4].value = 'Total';
    for (var i = 0; i < invoice.length; i++) {
      _addProducts(invoice[i].rate, invoice[i].name, invoice[i].quantity,
          invoice[i].amount, grid);
    }
    // _addProducts('CA-1098', 'AWC Logo Cap', 8.99, 2, 17.98, grid);
    // _addProducts(
    //     'LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    // _addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
    // _addProducts(
    //     'LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    // _addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
    // _addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  void _addProducts(String rate, String productName, int quantity,
      double amount, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = 'RM $rate';
    row.cells[1].value = productName;
    row.cells[2].value = quantity.toString();
    row.cells[3].value = amount.toString();
    // row.cells[4].value = total.toString();
  }

  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));
    page.graphics.drawString(
        'RM ${order.totalFee}0', PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber = 'Invoice Id: ${order.intendId}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    String address =
        'Bill To: \r\n\r\n${auth.user.name}, \r\n\r\n${auth.user.phoneNumber}';
    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));
    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

  double _getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value =
          grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return total;
  }

  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
    //Draw grand total.
    page.graphics.drawString('Grand Total',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 10,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString('RM ${order.totalFee}0',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));
  }

  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));
    const String footerContent =
        'Laundryfy Service Management.\r\n\r\n85000,Segamat, Johor\r\n\r\nAny Questions? laundryfy@dobi-IOI.com';
    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }
}
