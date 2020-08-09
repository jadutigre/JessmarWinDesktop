

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/PedidosManto.dart';

class ListaPedidos  extends StatefulWidget {
  ListaPedidos({Key key}) : super(key: key);
  _ListaPedidosState createState() => _ListaPedidosState();
}



class _ListaPedidosState extends State<ListaPedidos> {



  Future<List<Pedido>> fpedidos ;
  List<Pedido> pedidos ;



  @override
  void initState() {
    super.initState();
    _getData();
  }



  void _getData()  {
      print("Estoy Pasando Servicio Async ...");
      JessmarService service = JessmarService();
      setState(() {
          fpedidos =  service.getListaPedidosFull();
      });
  }



  @override
  Widget build(BuildContext context) {

    var futureBuilder = new FutureBuilder(
        future: fpedidos,
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
                          hintText: "Lista de Pedidos"
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
                        child: createDataTable(context, snapshot)
                      //                      transform: Matrix4.rotationZ(0.1),
                    ),

                  ],
                );

        }
      }
    );



    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Lista de Pedidos"),
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () {

            // TODO add your logic here to add stuff
            Pedido pedido = new Pedido();
            pedido.id=0;
            pedido.fechapedido= DateTime.now().toString();
            pedido.clientes_id = 1;
            pedido.vendedor_id = 1;
            pedido.tipopedido_id = 1;
            pedido.pedidosdetalle = List<Pedido_detalle>();
            pedido.usuario = "";
            pedido.areaentrega="";
            Navigator.push(context, new MaterialPageRoute(builder: (context) => PedidosManto( pedido: pedido)));

          },
        ),
        body: new SingleChildScrollView(
          child: futureBuilder,
        )
    );





  }

  Widget createDataTable(BuildContext context, AsyncSnapshot snapshot) {

    List<Pedido> values = snapshot.data;

    return   DataTable(
      onSelectAll: (b) {},
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text('ID'),
        ),
        DataColumn(
          label: Text('Fecha'),
        ),
        DataColumn(
          label: Text('Nombre Cliente'),
        ),
        DataColumn(
          label: Text('Vendedor Nombre'),
        ),
        DataColumn(
          label: Text('Descripcion Pedido '),
        ),
        DataColumn(
          label: Text('Area Entrega'),
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
              Navigator.push(context, new MaterialPageRoute(builder: (context) => PedidosManto( pedido: itemRow)));
            },
            ),
            DataCell(
              Text(itemRow.fechapedido.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
//            DataCell(
//              Text(itemRow.clientes_id.toString()),
//              showEditIcon: false,
//              placeholder: false,
//              //onTap: actionButtonRaised,
//            ),
            DataCell(
              Text(itemRow.clientenombre.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
//            DataCell(
//              Text(itemRow.vendedor_id.toString()),
//              showEditIcon: false,
//              placeholder: false,
//              //onTap: actionButtonRaised,
//            ),
            DataCell(
              Text(itemRow.vendedornombre.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
//            DataCell(
//              Text(itemRow.tipopedido_id.toString()),
//              showEditIcon: false,
//              placeholder: false,
//              //onTap: actionButtonRaised,
//            ),
            DataCell(
              Text(itemRow.tipopedidodescripcion.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(
              Text(itemRow.areaentrega.toString()),
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