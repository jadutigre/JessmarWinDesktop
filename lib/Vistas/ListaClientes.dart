

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jessmarwindesk/Domains/articulo.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/FormClientes.dart';
import 'package:jessmarwindesk/Vistas/PedidosManto.dart';

import 'MenuPrincipal.dart';

class ListaClientes extends StatefulWidget {
  ListaClientes({Key key}) : super(key: key);
  _ListaClientesState createState() => _ListaClientesState();
}



class _ListaClientesState extends State<ListaClientes> {



  Future<List<Cliente>> fclientes ;
  List<Cliente> clientes ;



  @override
  void initState() {
    super.initState();
    _getData();
  }



  void _getData()  {
      print("Estoy Pasando Servicio Async ...");
      JessmarService service = JessmarService();
      setState(() {
          fclientes = service.getListaClientes();
      });
  }



  @override
  Widget build(BuildContext context) {

    var futureBuilder = new FutureBuilder(
        future: fclientes,
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
                          hintText: "Lista de Clientes"
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
          title: new Text("Lista de Clientes"),
        ),


        floatingActionButton:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [



              FloatingActionButton(

                child: Icon(
                  Icons.home,
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, 'menuprincipal');
                },
                heroTag: null,
                tooltip: "Ir al Menu",
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
                  Cliente cliente = Cliente();
                  cliente.id=0;
                  cliente.pais_id=1;
                  cliente.estado_id=3;
                  cliente.usocfdi_id=22;

                  // Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => FormClientes(cliente: cliente)),
                  //         (Route<dynamic> route) => false);
                  Navigator.pushNamed(context, 'formclientes');


                },
                heroTag: null,
                tooltip: "Agregar Cliente",
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

    List<Cliente> values = snapshot.data;

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
          label: Text('RFC'),
        ),
        DataColumn(
          label: Text('Telefono'),
        ),
        DataColumn(
          label: Text('Email'),
        ),
//        DataColumn(
//          label: Text('Area Entrega'),
//        ),
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
              Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => FormClientes(cliente: itemRow)),
                      (Route<dynamic> route) => false);
            },
            ),
            DataCell(
              Text(itemRow.nombre.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(
              Text(itemRow.rfc.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(
              Text(itemRow.telefono.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(
              Text(itemRow.email.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
//            DataCell(
//              Text(itemRow.vendedornombre.toString()),
//              showEditIcon: false,
//              placeholder: false,
//              //onTap: actionButtonRaised,
//            ),
//            DataCell(
//              Text(itemRow.tipopedido_id.toString()),
//              showEditIcon: false,
//              placeholder: false,
//              //onTap: actionButtonRaised,
//            ),
//            DataCell(
//              Text(itemRow.tipopedidodescripcion.toString()),
//              showEditIcon: false,
//              placeholder: false,
//              //onTap: actionButtonRaised,
//            ),
//            DataCell(
//              Text(itemRow.areaentrega.toString()),
//              showEditIcon: false,
//              placeholder: false,
//              //onTap: actionButtonRaised,
//            ),
          ],
        ),
      )
          .toList(),
    );


  }




//  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
//
//    List<Pedido> values = snapshot.data;
//
//    return new ListView.builder(
//      itemCount: values.length,
//      itemBuilder: (BuildContext context, int index) {
//        return new Column(
//          children: <Widget>[
//
//            new ListTile(
//              title: new Text(
//                      values[index].id.toString()+" "+
//            //values[index].fechapedido+" "+
//            formatDate(DateTime.parse(values[index].fechapedido), [dd, '/', mm, '/', yyyy, ' ', hh, ':', nn, ':', ss, ' ', am])+" "+
//                          values[index].clientes_id.toString()+" "+
//                          values[index].vendedor_id.toString()+" "+
//                          values[index].usuario
//
//              ),
////              subtitle: new Text(
////                       "F.Llegada: "+
////                      " F.Salida: "+
////                      " Agencia: "+
////                      " Procedencia: "+
////                      " Paquete: "
////              ),
////              isThreeLine: true,
//              onTap: (){
//                //print("Valor "+values[index].nombre);
//                // String url = 'http://10.194.18.59:8081/GroupSunsetPMSProxyServices/pms/dameReservacion';
//                // Future<Huespedes>makeRequest()async {
//                //   Map datos = {"pnohotel":"9","idreserva":"87196"};
//                //   var response = await http.post(url,
//                //   headers: {"Content-type":"application/x-www-form-urlencoded"},
//                //   body: datos);
//                //   print(response.body);
//                //   if (response.statusCode == 200){
//                //   _huesped = Huespedes.fromJson(json.decode(response.body));
//                //   return (Huespedes.fromJson(json.decode(response.body)));
//                //   }
//                //   else {
//                //   throw Exception('Failed to load post');
//                //   }
//                // }
//                //Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(values[index])));
//                Navigator.push(context, new MaterialPageRoute(builder: (context) => PedidosManto( pedido: values[index])));
//              },
//            ),
//            new Divider(height: 2.0,),
//          ],
//        );
//      },
//    );
//  }


}