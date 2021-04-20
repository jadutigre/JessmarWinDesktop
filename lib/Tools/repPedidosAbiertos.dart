import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Domains/pedidos_detalles.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/ListaPedidos.dart';
import 'package:intl/intl.dart';
import 'package:jessmarwindesk/Vistas/formInformes.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';

class RepPedidosAbiertos extends StatefulWidget  {
  RepPedidosAbiertos({Key key}) : super(key: key);
  _RepPedidosAbiertosState createState() => _RepPedidosAbiertosState();
}

class _RepPedidosAbiertosState extends State<RepPedidosAbiertos> {

  JessmarService service = JessmarService();
  Future<Map<String,dynamic>> datos;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String menuhorizontalselectoption;
  String finicial;
  String ffinal;

  Future<List<Pedido>> fpedidos ;
  List<Pedido> pedidos ;

  double totalpedidos;

  @override
  void initState() {
    super.initState();
    datos = _getData();
  }



  Future<Map<String,dynamic>> _getData() async {

    JessmarService service = JessmarService();
    Map<String,dynamic> datos = new Map();

    final SharedPreferences prefs = await _prefs;
    menuhorizontalselectoption = prefs.getString('filtros');
    finicial = prefs.getString("finicial");
    ffinal = prefs.getString("ffinal");

    // Pedido pedido = new Pedido();
    // Pedido onepedido = new Pedido();
    // print("Servicio  _getData");

    // pedidos  = json.decode(prefs.getString('pedidos'));
    //
    // datos["listapedido"]= pedidos;

    return datos;

  }


  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    List<Pedido> pedidos;

    if (arguments != null){
       pedidos =   arguments['pedidos'];
    }

    //pedidos = widget.pedidos;
    totalpedidos =  _sumalistatotal(pedidos);
    print(totalpedidos);

    const tableHeaders = [
      'ID#',
      'Descripción',
      'Precio',
      'Cantidad',
      'Total'
    ];

    //pw.PageTheme _buildTheme(PdfPageFormat pageFormat, pw.Font base,  pw.Font bold, pw.Font italic)
    pw.PageTheme _buildTheme(PdfPageFormat pageFormat) {
      return pw.PageTheme(
        pageFormat: pageFormat,
        // theme: pw.ThemeData.withFont(
        //   base: base,
        //   bold: bold,
        //   italic: italic,
        // ),
        // buildBackground: (context) => pw.FullPage(
        //   ignoreMargins: true,
        //   child: pw.SvgImage(svg: _bgShape!),
        // ),
      );
    }

    pw.Widget _buildHeader(pw.Context context) {
      return pw.Column(
        children: [

          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [


              pw.Expanded(
                  flex: 1,
                  child: pw.Column(
                    children: [
                    ],
                  ),
              ),


              pw.Expanded(
                flex: 2,
                child: pw.Column(
                  children: [


                    pw.Container(
                      height: 20,
                      padding: const pw.EdgeInsets.only(left: 8),
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'REPORTE DE PEDIDOS '+menuhorizontalselectoption.toUpperCase(),
                        style: pw.TextStyle(
                          //color:  PdfColors.cyan900,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 8,
                        ),
                      ),
                    ),



                    pw.Container(
                      decoration: pw.BoxDecoration(
                        borderRadius:
                        const pw.BorderRadius.all(pw.Radius.circular(2)),
                         //color: PdfColors.teal,
                      ),
                      padding: const pw.EdgeInsets.only(left: 8, top: 10, bottom: 10, right: 10),
                      alignment: pw.Alignment.centerLeft,
                      height: 30,
                      child: pw.DefaultTextStyle(
                        style: pw.TextStyle(
                          //color: _accentTextColor,
                          fontSize: 7,
                        ),
                        child: pw.GridView(
                          crossAxisCount: 5,
                          children: [
                            pw.Text('Fecha Inicial : '),
                            pw.Text( finicial),
                            pw.Text(' '),
                            pw.Text('Fecha Final : '),
                            pw.Text( ffinal),
                          ],
                        ),
                      ),
                    ),

                    pw.SizedBox(height: 20),
                    // pw.Container(
                    //   decoration: pw.BoxDecoration(
                    //     borderRadius:
                    //     const pw.BorderRadius.all(pw.Radius.circular(2)),
                    //     //color: PdfColors.blueGrey900,
                    //   ),
                    //   padding: const pw.EdgeInsets.only(left: 8, top: 10, bottom: 10, right: 20),
                    //   alignment: pw.Alignment.centerLeft,
                    //   height: 30,
                    //   child: pw.DefaultTextStyle(
                    //     style: pw.TextStyle(
                    //       //color: _accentTextColor,
                    //       fontSize: 7,
                    //     ),
                    //     child: pw.GridView(
                    //       crossAxisCount: 2,
                    //       children: [
                    //         pw.Text('Invoice #'),
                    //         pw.Text( 'Invoice'),
                    //
                    //       ],
                    //     ),
                    //   ),
                    // ),



                    // pw.Container(
                    //   decoration: pw.BoxDecoration(
                    //     borderRadius:
                    //     const pw.BorderRadius.all(pw.Radius.circular(2)),
                    //      //color: PdfColors.blueGrey900,
                    //   ),
                    //   padding: const pw.EdgeInsets.only(left: 8, top: 10, bottom: 10, right: 20),
                    //   alignment: pw.Alignment.centerLeft,
                    //   height: 30,
                    //   child: pw.DefaultTextStyle(
                    //     style: pw.TextStyle(
                    //       //color: _accentTextColor,
                    //       fontSize: 7,
                    //     ),
                    //     child: pw.GridView(
                    //
                    //       crossAxisCount: 4,
                    //       children: [
                    //         pw.Text('Date:'),
                    //         //pw.Text(elpedido.fechapedido),
                    //         // pw.Text('Invoice #'),
                    //         // pw.Text(elpedido.id.toString()),
                    //         // pw.Text('Date:'),
                    //         // pw.Text(elpedido.fechapedido),
                    //
                    //       ],
                    //     ),
                    //   ),
                    // ),


                  ],
                ),
              ),



              pw.Expanded(
                flex: 1,
                child: pw.Column(
                  children: [
                  ],
                ),
              ),


              // pw.Expanded(
              //   child: pw.Column(
              //     mainAxisSize: pw.MainAxisSize.min,
              //     children: [
              //
              //
              //       pw.Container(
              //         decoration: pw.BoxDecoration(
              //           borderRadius:
              //           const pw.BorderRadius.all(pw.Radius.circular(2)),
              //           //color: PdfColors.blueGrey900,
              //         ),
              //         padding: const pw.EdgeInsets.only(left: 8, top: 10, bottom: 10, right: 20),
              //         alignment: pw.Alignment.centerLeft,
              //         height: 30,
              //         child: pw.DefaultTextStyle(
              //           style: pw.TextStyle(
              //             //color: _accentTextColor,
              //             fontSize: 7,
              //           ),
              //           child: pw.GridView(
              //
              //             crossAxisCount: 2,
              //             children: [
              //               pw.Text('')
              //             ],
              //           ),
              //         ),
              //       ),
              //
              //
              //       pw.Container(
              //         decoration: pw.BoxDecoration(
              //           borderRadius:
              //           const pw.BorderRadius.all(pw.Radius.circular(2)),
              //           //color: PdfColors.blueGrey900,
              //         ),
              //         padding: const pw.EdgeInsets.only(left: 8, top: 10, bottom: 10, right: 20),
              //         alignment: pw.Alignment.centerLeft,
              //         height: 30,
              //         child: pw.DefaultTextStyle(
              //           style: pw.TextStyle(
              //             //color: _accentTextColor,
              //             fontSize: 7,
              //           ),
              //           child: pw.GridView(
              //
              //             crossAxisCount: 2,
              //             children: [
              //               pw.Text('Vendedor'),
              //               //pw.Text(pedidos[i].clientenombre),
              //             ],
              //           ),
              //         ),
              //       ),


                    // pw.Container(
                    //   decoration: pw.BoxDecoration(
                    //     borderRadius:
                    //     const pw.BorderRadius.all(pw.Radius.circular(2)),
                    //     //color: PdfColors.blueGrey900,
                    //   ),
                    //   padding: const pw.EdgeInsets.only(left: 8, top: 10, bottom: 10, right: 20),
                    //   alignment: pw.Alignment.centerLeft,
                    //   height: 30,
                    //   child: pw.DefaultTextStyle(
                    //     style: pw.TextStyle(
                    //       //color: _accentTextColor,
                    //       fontSize: 7,
                    //     ),
                    //     child: pw.GridView(
                    //       crossAxisCount: 2,
                    //       children: [
                    //         pw.Text('Hielera'),
                    //        // pw.Text(elpedido.hieleranombre),
                    //       ],
                    //     ),
                    //   ),
                    // ),


                    // pw.Container(
                    //           decoration: pw.BoxDecoration(
                    //             borderRadius:
                    //             const pw.BorderRadius.all(pw.Radius.circular(2)),
                    //             //color: PdfColors.blueGrey900,
                    //           ),
                    //           padding: const pw.EdgeInsets.only(left: 8, top: 10, bottom: 10, right: 20),
                    //           alignment: pw.Alignment.centerLeft,
                    //           height: 30,
                    //           child: pw.DefaultTextStyle(
                    //             style: pw.TextStyle(
                    //               //color: _accentTextColor,
                    //               fontSize: 7,
                    //             ),
                    //             child: pw.GridView(
                    //
                    //               crossAxisCount: 2,
                    //               children: [
                    //                 pw.Text('Entregar:'),
                    //                 //pw.Text(pedidos[row].clientenombre),
                    //               ],
                    //             ),
                    //           ),
                    //         ),




                    // pw.Container(
                    //   alignment: pw.Alignment.topRight,
                    //   padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    //   height: 72,
                    //   child:
                    //   _logo != null ? pw.SvgImage(svg: _logo!) : pw.PdfLogo(),
                    // ),
                    // pw.Container(
                    //   color: baseColor,
                    //   padding: pw.EdgeInsets.only(top: 3),
                    // ),
              //     ],
              //   ),
              // ),



            ],
          ),
          if (context.pageNumber > 1) pw.SizedBox(height: 20)

        ],

      );
    }

    pw.Widget _buildFooter(pw.Context context) {
      return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Container(
            height: 20,
            width: 100,
            child: pw.BarcodeWidget(
              barcode: pw.Barcode.pdf417(),
              data: 'Invoice# ', //$invoiceNumber',
            ),
          ),
          pw.Text(
            'Page ${context.pageNumber}/${context.pagesCount}',
            style: const pw.TextStyle(
              fontSize: 12,
              color: PdfColors.white,
            ),
          ),
        ],
      );
    }



    pw.Widget _contentHeader(pw.Context context) {
      return pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [


          // pw.Expanded(
          //   child:
            // pw.Container(
            //   margin: const pw.EdgeInsets.symmetric(horizontal: 20),
            //   height: 70,
            //   child:
            //   //pw.FittedBox(
            //   //  child:
            //     pw.Text(
            //       'Total: ',
            //       style: pw.TextStyle(
            //         //color: baseColor,
            //         fontStyle: pw.FontStyle.italic,
            //         fontSize: 12,
            //       ),
            //     ),
            //   //),
            // ),
          // ),


          pw.Expanded(
            child: pw.Row(
              children: [

                // pw.Container(
                //   margin: const pw.EdgeInsets.only(left: 10, right: 10),
                //   height: 70,
                //   child: pw.Text(
                //     'Invoice to:',
                //     style: pw.TextStyle(
                //       //color: _darkColor,
                //       fontWeight: pw.FontWeight.bold,
                //       fontSize: 12,
                //     ),
                //   ),
                // ),

                // pw.Expanded(
                //   child: pw.Container(
                //     height: 70,
                //     child: pw.RichText(
                //         text: pw.TextSpan(
                //             //text: '$customerName\n',
                //             style: pw.TextStyle(
                //               //color: _darkColor,
                //               fontWeight: pw.FontWeight.bold,
                //               fontSize: 12,
                //             ),
                //             children: [
                //               const pw.TextSpan(
                //                 text: '\n',
                //                 style: pw.TextStyle(
                //                   fontSize: 5,
                //                 ),
                //               ),
                //               pw.TextSpan(
                //                 //text: customerAddress,
                //                 style: pw.TextStyle(
                //                   fontWeight: pw.FontWeight.normal,
                //                   fontSize: 10,
                //                 ),
                //               ),
                //             ])),
                //   ),
                // ),


              ],
            ),
          ),
        ],
      );
    }




    pw.Widget _contentFooter(pw.Context context) {
      return pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 2,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [


                // pw.Text(
                //   'Thank you for your business',
                //   style: pw.TextStyle(
                //     //color: _darkColor,
                //     fontWeight: pw.FontWeight.bold,
                //   ),
                // ),
                //
                // pw.Container(
                //   margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                //   child: pw.Text(
                //     'Payment Info:',
                //     style: pw.TextStyle(
                //       //color: baseColor,
                //       fontWeight: pw.FontWeight.bold,
                //     ),
                //   ),
                // ),

                // pw.Text(
                //   paymentInfo,
                //   style: const pw.TextStyle(
                //     fontSize: 8,
                //     lineSpacing: 5,
                //     color: _darkColor,
                //   ),
                // ),

              ],
            ),
          ),


          pw.Expanded(
            flex: 1,
            child: pw.DefaultTextStyle(
              style: const pw.TextStyle(
                fontSize: 7,
                //color: _darkColor,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [

                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Sub Total:'),
                      pw.Text(_formatCurrency(totalpedidos.toDouble())),
                    ],
                  ),

                  // pw.SizedBox(height: 5),

                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Tax:'),
                      pw.Text('${(0).toStringAsFixed(1)}%'),
                    ],
                  ),
                  //pw.Divider(color: accentColor),


                  pw.DefaultTextStyle(
                    style: pw.TextStyle(
                      //color: baseColor,
                      fontSize: 7,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Total:'),
                        pw.Text(_formatCurrency(totalpedidos.toDouble())),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ],
      );
    }




    pw.Widget _contentTable(pw.Context context) {
      const tableHeaders = [
        '#Pedido',
        'Fecha',
        'Estatus',
        'Cliente',
        'Vendedor',
        'Tipo Pedido',
        'Area Entrega',
        'Total'
      ];

      return pw.Table.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        headerDecoration: pw.BoxDecoration(
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
          //color: baseColor,
        ),
        headerHeight: 25,
        cellHeight: 20,
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.centerLeft,
          2: pw.Alignment.centerLeft,
          3: pw.Alignment.centerLeft,
          4: pw.Alignment.centerLeft,
          5: pw.Alignment.centerLeft,
          6: pw.Alignment.centerLeft,
          7: pw.Alignment.centerRight,
        },
        headerStyle: pw.TextStyle(
          //color: _baseTextColor,
          fontSize: 7,
          fontWeight: pw.FontWeight.bold,
        ),
        cellStyle: const pw.TextStyle(
          //color: _darkColor,
          fontSize: 7,
        ),
        rowDecoration: pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(
              //color: accentColor,
              width: .5,
            ),
          ),
        ),
        headers: List<String>.generate(
          tableHeaders.length,
              (col) => tableHeaders[col],
        ),
        data: List<List<String>>.generate(
          pedidos.length,
              (row) => List<String>.generate(
                 tableHeaders.length,
                (col) => pedidos[row].getIndex(col),
          ),
        ),
      );
    }



    Future<Uint8List> _generatePdf(PdfPageFormat format) async {

      final pdf = pw.Document();

      // final font1 = await rootBundle.load('assets/fonts/Roboto-Medium.ttf');
      // final font2 = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
      // final font3 = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');

      pdf.addPage(

          pw.MultiPage(
             pageTheme: _buildTheme(
               format,
            //   // pw.Font.ttf(font1),
            //   // pw.Font.ttf(font2),
            //   // pw.Font.ttf(font3),
             ),
            header: _buildHeader,
            footer: _buildFooter,
            build: (context) => [
              _contentHeader(context),
              _contentTable(context),
              pw.SizedBox(height: 20),
              _contentFooter(context),
              pw.SizedBox(height: 20),
              //_termsAndConditions(context),
            ],
          )
      //   pw.Page(
      //     //pageFormat: format,
      //     pageFormat: PdfPageFormat(8 * PdfPageFormat.cm, 10 * PdfPageFormat.cm, marginAll: 0.5 * PdfPageFormat.cm),
      //     build: (context) {
      //
      //       return pw.Table.fromTextArray(
      //       border: null,
      //       cellAlignment: pw.Alignment.centerLeft,
      //       headerDecoration: pw.BoxDecoration(
      //       borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
      //       //color: baseColor,
      //       ),
      //       headerHeight: 25,
      //       cellHeight: 40,
      //       cellAlignments: {
      //       0: pw.Alignment.centerLeft,
      //       1: pw.Alignment.centerLeft,
      //       2: pw.Alignment.centerRight,
      //       3: pw.Alignment.center,
      //       4: pw.Alignment.centerRight,
      //       },
      //       headerStyle: pw.TextStyle(
      //       //color: _baseTextColor,
      //       fontSize: 10,
      //       fontWeight: pw.FontWeight.bold,
      // ),
      // cellStyle: const pw.TextStyle(
      // //color: _darkColor,
      // fontSize: 10,
      // ),
      // rowDecoration: pw.BoxDecoration(
      // border: pw.Border(
      // bottom: pw.BorderSide(
      // //color: accentColor,
      // width: .5,
      // ),
      // ),
      // ),
      // headers: List<String>.generate(
      // tableHeaders.length,
      // (col) => tableHeaders[col],
      // ),
      // data: List<List<String>>.generate(
      //         elpedido.pedidosdetalle.length,
      //         (row) => List<String>.generate(
      //         tableHeaders.length,
      //         (col) => elpedido.pedidosdetalle[row].getIndex(col),
      //         ),
      //         ),
      // );




                //   pw.Row(
                //     crossAxisAlignment: pw.CrossAxisAlignment.start,
                //     children: [
                //
                //           pw.Text("Hello World"),
                //
                //               for(var item in elpedido.pedidosdetalle )
                //                 pw.Text(item.id.toString()+" "+item.articulodescripcion+" "+item.cantidad.toString()+" "+item.precio.toString())
                //
                //
                //       // _contentTable(context,onepedido)
                //     ]
                // );

            
          // },
        //),
      );

      return pdf.save();
    }


    return new Scaffold(
      // home:
      //   Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(title: Text("Impresion de Ticket")),




        // return new Scaffold(
        //
        // appBar: new AppBar(
        // title: new Text("Impresion de Ticket"),
        // ),

        body:
        Column(
          children: <Widget>[


                // Expanded(
                // flex: 1, // 60%
                // child:
                //     Container(
                //       color: Colors.blue,
                //       child: Row(
                //
                //       children: [
                //               RaisedButton(
                //                 onPressed: actionButtonRaised,
                //                 child:Row(
                //                   children: <Widget>[
                //                     Text('Lista Pedidos'),
                //                     Icon(Icons.arrow_forward_ios),
                //                   ],
                //                 ),
                //               ),
                //         ]
                //        ),
                //     )
                // ),

                Expanded(
                    flex: 6, // 60%
                    child: Container(
                              child: PdfPreview(
                                maxPageWidth: 450,
                                useActions: true,
                                build: (format) => _generatePdf(format),
                              ),
                            ),
                         )
        ]
       ),
      // )
    );
    //);


  }

  Future<void> actionButtonRaised() {

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => FormInformes(),
    //   ),
    // );

    Navigator.pushNamed(context, 'forminformes');

  }

  String _formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  String _formatDate(DateTime date) {
    final format = DateFormat.yMMMd('en_US');
    return format.format(date);
  }

  double _sumalistatotal(List<Pedido> _pedido){
       totalpedidos=0.0;
       for(var i = 0; i< _pedido.length; i++) {
              totalpedidos = totalpedidos + _pedido[i].totalpedido;
       }
       return totalpedidos;
  }


}