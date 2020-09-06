

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Domains/articulo.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/MenuPrincipal.dart';
import 'package:jessmarwindesk/Vistas/PedidosManto.dart';

import 'FormArticulos.dart';

class ListaArticulos  extends StatefulWidget {
  ListaArticulos({Key key}) : super(key: key);
  _ListaArticulosState createState() => _ListaArticulosState();
}



class _ListaArticulosState extends State<ListaArticulos> {



  Future<List<Articulo>> farticulos ;
  List<Articulo> articulos ;



  @override
  void initState() {
    super.initState();
    _getData();
  }



  void _getData()  {
      print("Estoy Pasando Servicio Async ...");
      JessmarService service = JessmarService();
      setState(() {
          farticulos = service.getListaArticulos();
      });
  }



  @override
  Widget build(BuildContext context) {

    var futureBuilder = new FutureBuilder(
        future: farticulos,
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
                            hintText: "Lista de Articulos"
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
          title: new Text("Lista de Articulos"),
        ),
        floatingActionButton:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [



              FloatingActionButton(
                child: Icon(
                    Icons.arrow_back
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
                  Articulo articulo = Articulo();
                  articulo.id=0;
                  Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => FormArticulos(articu: articulo)),
                          (Route<dynamic> route) => false);


                    },
                heroTag: null,
              )




            ]
        ),



//        new FloatingActionButton(
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

    List<Articulo> values = snapshot.data;

    return   DataTable(
      onSelectAll: (b) {},
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text('ID'),
        ),
        DataColumn(
          label: Text('Codigo'),
        ),
        DataColumn(
          label: Text('Descripciòn'),
        ),
        DataColumn(
          label: Text('Pasillo'),
        ),
        DataColumn(
          label: Text('Anaquel'),
        ),
        DataColumn(
          label: Text('Clave Sat'),
        ),
        DataColumn(
          label: Text('Unidad Sat'),
        ),
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
              Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => FormArticulos( articu: itemRow)),
                      (Route<dynamic> route) => false);
            },
            ),
            DataCell(
              Text(   itemRow.codigo.toString()  ),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,push
            ),
            DataCell(
              Text(itemRow.descripcion.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(
              Text(itemRow.lugar.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(
              Text(itemRow.parte.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(
              Text(itemRow.cvesat.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(
              Text(itemRow.unidadsat.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
          ],
        ),
      )
          .toList(),
    );


  }




  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {

    List<Pedido> values = snapshot.data;

    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[

            new ListTile(
              title: new Text(
                      values[index].id.toString()+" "+
            //values[index].fechapedido+" "+
            formatDate(DateTime.parse(values[index].fechapedido), [dd, '/', mm, '/', yyyy, ' ', hh, ':', nn, ':', ss, ' ', am])+" "+
                          values[index].clientes_id.toString()+" "+
                          values[index].vendedor_id.toString()+" "+
                          values[index].usuario

              ),
//              subtitle: new Text(
//                       "F.Llegada: "+
//                      " F.Salida: "+
//                      " Agencia: "+
//                      " Procedencia: "+
//                      " Paquete: "
//              ),
//              isThreeLine: true,
              onTap: (){
                //print("Valor "+values[index].nombre);
                // String url = 'http://10.194.18.59:8081/GroupSunsetPMSProxyServices/pms/dameReservacion';
                // Future<Huespedes>makeRequest()async {
                //   Map datos = {"pnohotel":"9","idreserva":"87196"};
                //   var response = await http.post(url,
                //   headers: {"Content-type":"application/x-www-form-urlencoded"},
                //   body: datos);
                //   print(response.body);
                //   if (response.statusCode == 200){
                //   _huesped = Huespedes.fromJson(json.decode(response.body));
                //   return (Huespedes.fromJson(json.decode(response.body)));
                //   }
                //   else {
                //   throw Exception('Failed to load post');
                //   }
                // }
                //Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(values[index])));
                Navigator.push(context, new MaterialPageRoute(builder: (context) => PedidosManto( pedido: values[index])));
              },
            ),
            new Divider(height: 2.0,),
          ],
        );
      },
    );
  }


}