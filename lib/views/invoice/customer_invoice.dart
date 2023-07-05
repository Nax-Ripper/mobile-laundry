import 'dart:developer';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/controllers/invoice_controller.dart';
import 'package:mobile_laundry/models/orders_model.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as widgets;
import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:path_provider/path_provider.dart';

class CustomerInvoice extends StatelessWidget {
  Orders order;
  CustomerInvoice({
    Key? key,
    required this.order,
  }) : super(key: key);

  AuthController auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // Calculate the total amount

    return GetBuilder<InvoiceController>(
      init: InvoiceController(order: order),
      builder: (ctrl) {
        return Scaffold(
          appBar: NormalAppBar(
              title: "${auth.user.name}'s Invoice", isCenter: false),
          body: Column(
            children: [
              Image.asset(
                'lib/assets/invoice_2.png',
                height: 200,
                filterQuality: FilterQuality.high,

              ),
              SingleChildScrollView(child: ctrl.buildDataTable),
            ],
          ),
          floatingActionButton: SpeedDial(
            activeBackgroundColor: Colors.transparent,
            activeForegroundColor: Colors.transparent,
            activeChild: const Icon(Icons.close),
            children: [
              SpeedDialChild(
                visible: ctrl.order.accepted==false,
                label: 'Accept Order',
                child: const Icon(Icons.check),
                onTap: () {
                  log('hi');
                  ctrl.accepted(order.id);
                },
              ),
              SpeedDialChild(
                  onTap: () async {
                    //    final fileName= '${auth.user.name}-invoice.pdf';
                    // final pdf = widgets.Document();

                    // final bytes = await pdf.save();
                    // final dir = await getApplicationDocumentsDirectory();
                    // final file = File('${dir.path}/$fileName');
                    // await file.writeAsBytes(bytes,flush: true);
                    // OpenFile.open('$file');

                    final fileName = '${auth.user.name}-invoice.pdf';
                    PdfDocument document = PdfDocument();
                    final page = document.pages.add();
                    final Size pageSize = page.getClientSize();
                    page.graphics.drawRectangle(
                        bounds: Rect.fromLTWH(
                            0, 0, pageSize.width, pageSize.height),
                        pen: PdfPen(PdfColor(142, 170, 219)));

                    final PdfGrid grid = ctrl.getGrid();

                    final PdfLayoutResult result =
                        ctrl.drawHeader(page, pageSize, grid);

                    ctrl.drawGrid(page, grid, result);
                    //Add invoice footer
                    ctrl.drawFooter(page, pageSize);
                    // page.graphics.drawString('Laundryfy Service',
                    //     PdfStandardFont(PdfFontFamily.helvetica, 30));
                    //  page.graphics.drawString('', PdfStandardFont(PdfFontFamily.helvetica, 30));

                    //  page.graphics.drawString('Invoice Number : ${order.intendId}', PdfStandardFont(PdfFontFamily.helvetica, 20));

                    List<int> bytes = await document.save();
                    document.dispose();
                    final path = (await getExternalStorageDirectory())?.path;
                    final file = File('$path/$fileName');
                    await file.writeAsBytes(bytes, flush: true);
                    OpenFile.open('$path/$fileName');
                  },
                  label: 'Download Invoice',
                  child: const Icon(Icons.download))
            ],
            child: const Icon(Icons.menu),
          ),
          bottomNavigationBar: BottomAppBar(
            // height: 60,
            child: ListTile(
              title: const Text('Total Amount'),
              trailing: Text('RM ${ctrl.totalAmount.toStringAsFixed(2)}'),
            ),
          ),
        );
      },
    );
  }
}
