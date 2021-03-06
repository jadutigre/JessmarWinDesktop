
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Domains/articulo.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/hielera.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Domains/vendedor.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/FormClientes.dart';
import 'package:jessmarwindesk/Vistas/FormVendedores.dart';
import 'package:jessmarwindesk/Vistas/PedidosManto.dart';
import 'dart:io' show Platform;

import 'FormHieleras.dart';
import 'MenuPrincipal.dart';

class ListaHieleras extends StatefulWidget {
  ListaHieleras({Key key}) : super(key: key);
  _ListaHielerasState createState() => _ListaHielerasState();
}



class _ListaHielerasState extends State<ListaHieleras> {



  Future<List<Hielera>> fhieleras ;
  List<Hielera> lhieleras ;



  @override
  void initState() {
    super.initState();
    _getData();
  }



  void _getData()  {
      print("Estoy Pasando Servicio Async ...");
      JessmarService service = JessmarService();
      setState(() {
          fhieleras = service.getListaHieleras();
      });
  }



  @override
  Widget build(BuildContext context) {

    var futureBuilder = new FutureBuilder(
        future: fhieleras,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Text('loading...');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return
                  Column(
                  children: <Widget>[

                    Container(
                      padding: const EdgeInsets.all(16.0),
                      //decoration: BoxDecoration(border: Border.all(width: 0.0)),
                      child: new TextField(
                        //        controller: _searchview,
                        decoration: InputDecoration(
                          hintText: "Lista de Hieleras"
//                          hintStyle: new TextStyle(color: Colors.grey[300]),
                        ),
                        textAlign: TextAlign.center,
                        enabled: false,
                      ),
                    ),



                    Container(
                        constraints: BoxConstraints.expand(
                          height:  500 ,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.white,
                        alignment: Alignment.topCenter,
                        child: ListView(
                            children: <Widget>[
                              SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: createDataTable(context, snapshot)
                              )
                            ]
                        ),
                      //                      transform: Matrix4.rotationZ(0.1),
                    ),

                  ],
                );

        }
      }
    );



    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Lista de Hieleras"),
        ),


        floatingActionButton:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [



              FloatingActionButton(
                child: Icon(
                    Icons.home
                ),
                onPressed:() {

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) =>  MenuPrincipal()),
                          (Route<dynamic> route) => false
                  );

                },
                heroTag: null,
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                child: Icon(
                    Icons.add
                ),
                onPressed: () {

                  // TODO add your logic here to add stuff
                  Hielera hielera = Hielera();
                  hielera.id=0;
                  final f = new DateFormat('yyyy-MM-dd hh:mm');
                  hielera.fecha_adquisicion= f.format(DateTime.now());
                  hielera.fecha_baja= f.format(DateTime.now());
                  Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => FormHieleras(hielera: hielera)),
                          (Route<dynamic> route) => false);


                },
                heroTag: null,
              )




            ]
        ),





//        floatingActionButton: new FloatingActionButton(
//          child: new Icon(Icons.add),
//          onPressed: () {
//
//            // TODO add your logic here to add stuff
//            Pedido pedido = new Pedido();
//            pedido.id=0;
//            pedido.fechapedido= DateTime.now().toString();
//            pedido.clientes_id = 1;
//            pedido.vendedor_id = 1;
//            pedido.tipopedido_id = 1;
//            pedido.pedidosdetalle = List<Pedido_detalle>();
//            pedido.usuario = "";
//            pedido.areaentrega="";
//            Navigator.push(context, new MaterialPageRoute(builder: (context) => PedidosManto( pedido: pedido)));
//
//          },
//        ),


        body: new SingleChildScrollView(
          child: futureBuilder,
        )
    );





  }

  Widget createDataTable(BuildContext context, AsyncSnapshot snapshot) {

    List<Hielera> values = snapshot.data;

    return   DataTable(
      onSelectAll: (b) {},
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text('ID'),
        ),
        DataColumn(
          label: Text('Nombre'),
        ),
        DataColumn(
          label: Text('Clave'),
        )
      ],
      rows: values
          .map(
            (itemRow) => DataRow(
          cells: [
            DataCell(
              Text(itemRow.id.toString()),
              showEditIcon: true,
              placeholder: false,
              onTap:() {
              Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => FormHieleras(hielera: itemRow)),
                      (Route<dynamic> route) => false);
            },
            ),
            DataCell(
              Text(itemRow.descripcion.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(
              Text(itemRow.clave),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            )
          ],
        ),
      )
          .toList(),
    );


  }


}