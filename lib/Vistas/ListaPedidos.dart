

import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/PedidosManto.dart';

class ListaPedidos  extends StatefulWidget {
  ListaPedidos({Key key}) : super(key: key);
  _ListaPedidosState createState() => _ListaPedidosState();
}



class _ListaPedidosState extends State<ListaPedidos> {



  List<Pedido> pedidos = List<Pedido>();



        Future<List<Pedido>> _getData() async {
            print("Servicio Async");
            JessmarService service = JessmarService();
            pedidos = await service.getListaPedidos();
            return pedidos;
        }



  @override
  Widget build(BuildContext context) {

    var futureBuilder = new FutureBuilder(
        future: _getData(),
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
                          hintText: "Hola Mundo"
//                          hintStyle: new TextStyle(color: Colors.grey[300]),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),



                    Container(
                        constraints: BoxConstraints.expand(
                          height:  600 ,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: createListView(context, snapshot)
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
          },
        ),
        body: new SingleChildScrollView(
          child: futureBuilder,
        )
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
                      values[index].fechapedido.toString()+" "+
                      " 0001"+
                      " Jaime Alejandro Delgado Uc"
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