import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TicketPdfViewer extends StatelessWidget {
  final List<Map<String, dynamic>> ticketsData;

  const TicketPdfViewer({super.key, required this.ticketsData});

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(level: 0, child: pw.Text('Your Tickets')),
          ...ticketsData.map((ticket) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Ticket Code: ${ticket['code']}'),
                pw.Text('Status: ${ticket['status']}'),
                pw.SizedBox(height: 10),
                pw.Divider(),
              ],
            );
          }).toList(),
        ],
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tickets PDF')),
      body: FutureBuilder<Uint8List>(
        future: _generatePdf(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return PdfPreview(
                build: (format) => snapshot.data!,
                allowPrinting: true,
                allowSharing: true,
              );
            } else {
              return Center(child: Text('Failed to generate PDF'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
