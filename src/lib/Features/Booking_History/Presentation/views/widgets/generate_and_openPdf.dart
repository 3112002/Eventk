import 'dart:io';
import 'dart:typed_data';
import 'package:eventk/Core/utils/assests.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart' as open_file;

Future<void> generateAndOpenPdf({
  required String ticketTypeName,
  required String ticketTypeDetails,
  required int quantity,
  required double unitPrice,
  required List<Map<String, dynamic>> tickets,
  required int index,
}) async {
  final pdf = pw.Document();

  final Uint8List logoBytes = await rootBundle
      .load(AssestsImages.eventkLogo)
      .then((data) => data.buffer.asUint8List());

  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Center(
          child: pw.Image(
            pw.MemoryImage(logoBytes),
            width: 120.w,
            height: 120.h,
          ),
        ),
        pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: PdfColors.blue100,
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Text(
            'Order Details ',
            style: pw.TextStyle(
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue900,
            ),
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text('Ticket Type:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Expanded(flex: 5, child: pw.Text(ticketTypeName)),
                ],
              ),
              if (ticketTypeDetails.isNotEmpty) ...[
                pw.SizedBox(height: 6),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text('Details:',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Expanded(flex: 5, child: pw.Text(ticketTypeDetails)),
                  ],
                ),
              ],
              pw.SizedBox(height: 6),
              pw.SizedBox(height: 6),
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text('Unit Price:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Expanded(
                      flex: 5,
                      child: pw.Text('${unitPrice.toStringAsFixed(2)} EGP')),
                ],
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Text('Ticket QR Code:',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 12),
        ...tickets.asMap().entries.map((entry) {
          final ticket = entry.value;
          final code = ticket['code'] ?? '';
          final status = ticket['status'] ?? '';

          return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 15),
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey200,
              borderRadius: pw.BorderRadius.circular(10),
              boxShadow: [
                pw.BoxShadow(
                  color: PdfColors.grey500,
                  blurRadius: 3,
                ),
              ],
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 10),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Container(
                      width: 100,
                      height: 100,
                      decoration: pw.BoxDecoration(
                        color: PdfColors.white,
                        borderRadius: pw.BorderRadius.circular(8),
                        border: pw.Border.all(color: PdfColors.grey600),
                      ),
                      child: pw.BarcodeWidget(
                        barcode: pw.Barcode.qrCode(),
                        data: code,
                        drawText: false,
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Status:',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text(status),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        })
      ],
    ),
  );

  final bytes = await pdf.save();
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/tickets.pdf');
  await file.writeAsBytes(bytes);
  await open_file.OpenFile.open(file.path);
}
