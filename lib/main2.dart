// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import "package:pdf/pdf.dart";
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'Service/jessmarService.dart';

void main2() => runApp(const MyApp('Printing Demo'));

class MyApp extends StatelessWidget {
  const MyApp(this.title);
  final String title;


  @override
  Widget build(BuildContext context) {




    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: PdfPreview(
          build: (format) => _generatePdf(format, title),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {

     final pdf = pw.Document();
     // JessmarService service = JessmarService();
     //
     // Pedido onepedido   = await service.getOnePedido("10");

     pdf.addPage(pw.Page(
        //pageFormat: PdfPageFormat.a4,
        pageFormat: PdfPageFormat(8 * PdfPageFormat.cm, 10 * PdfPageFormat.cm, marginAll: 0.5 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Hello World"),
               // _contentTable(context,onepedido)
              ]
          ); // Center
        }));

    return pdf.save();
  }


  pw.Widget _contentTable(pw.Context context,Pedido elpedido) {
    const tableHeaders = [
      'SKU#',
      'Item Description',
      'Price',
      'Quantity',
      'Total'
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        // color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
            (col) => tableHeaders[col],
      )
      ,
      // data: List<List<String>>.generate(
      //   elpedido.pedidosdetalle.,
      //       (row) => List<String>.generate(
      //     tableHeaders.length,
      //         (col) => elpedido[row].getIndex(col),
      //   ),
      // ),
    );
  }






}

