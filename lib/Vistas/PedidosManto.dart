import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedidos.dart';
import 'package:jessmarwindesk/Domains/vendedor.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/PedidosIntro.dart';
import 'package:color_panel/color_panel.dart';
import 'dart:io' show Platform;

class PedidosManto extends StatefulWidget {
  Pedido pedido;
  PedidosManto({Key key, @required this.pedido}) : super(key: key);

  _PedidosMantoState createState() => _PedidosMantoState();
}


class _PedidosMantoState extends State<PedidosManto> {

  Future<Pedido> fpedido;
  Future<List<Pedido>> fpedidos;
  Future<List<Cliente>> fclientes;
  Future<List<Vendedor>> fvendedores;

//  List<Pedido> pedidos = List<Pedido>();
  String valor = "";
  Item selectedUser;

  List<Item> users = <Item>[
    const Item('Android',Icon(Icons.android,color:  const Color(0xFF167F67),)),
    const Item('Flutter',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
    const Item('ReactNative',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
    const Item('iOS',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
  ];

  Pedido _currentpedido;
  Cliente _currentcliente;
  Vendedor _currentvendedor;

  String _selectedDate = 'Tap to select date';



  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat.yMMMMd("en_US").format(d);
      });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }



  void _getData()  {
    Pedido pedido = widget.pedido;
    print("Servicio  _getData");
    JessmarService service = JessmarService();
    fpedido = service.getOnePedido(pedido.id);
    fpedidos    = service.getListaPedidos();
    fclientes   = service.getListaClientes();
    fvendedores = service.getListaVendedores();
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
                        child:


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[


                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: new FutureBuilder(
                                    future: fclientes,
                                    builder: (BuildContext context,AsyncSnapshot<List<Cliente>> snapshot) {
                                      if (!snapshot.hasData) return CircularProgressIndicator();
                                      return DropdownButton<Cliente>(
                                        isExpanded: true,
                                        value: _currentcliente,
                                        icon: Icon(Icons.check_circle_outline),
                                        hint: Text("Choose"),
                                        items: snapshot.data
                                            .map((items) => DropdownMenuItem<Cliente>(
                                          child: Text(items.nombre),
                                          value: items,
                                        ))
                                            .toList(),
                                        onChanged: (Cliente newValue) {
                                          setState(() => this._currentcliente = newValue);
                                        },
                                      );
                                    }),
                              ),
                            ),

                            SizedBox(
                              height: 15.0,
                            ),


                            InkWell(
                              child: Text(
                                  _selectedDate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Color(0xFF000000))
                              ),
                              onTap: (){
                                _selectDate(context);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              tooltip: 'Tap to open date picker',
                              onPressed: () {
                                _selectDate(context);
                              },
                            ),

                            SizedBox(
                              height: 15.0,
                            ),


//                            new Flexible(
//                              child: Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: DropdownButton<Item>(
//                                  hint:  Text("Select item"),
//                                  value: selectedUser,
//                                  onChanged: (Item Value) {
//                                    setState(() {
//                                      selectedUser = Value;
//                                    });
//                                  },
//                                  items: users.map((Item user) {
//                                    return  DropdownMenuItem<Item>(
//                                      value: user,
//                                      child: Row(
//                                        children: <Widget>[
//                                          user.icon,
//                                          SizedBox(width: 10,),
//                                          Text(
//                                            user.name,
//                                            style:  TextStyle(color: Colors.black),
//                                          ),
//                                        ],
//                                      ),
//                                    );
//                                  }).toList(),
//                                ),
//                              ),
//                            ),

//                            new Flexible(
//                              child: Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: TextField(
//                                  decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
//                                    labelText: "Text2",
//                                  ),
//                                ),
//                              ),
//                            ),


//                            SizedBox(
//                              height: 5.0,
//                            ),
//
//
//
//                            new Flexible(
//                              child: Padding(
//                                padding: const EdgeInsets.all(5.0),
//                                child: TextField(
//                                  decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
//                                    labelText: "Text3",
//                                  ),
//                                ),
//                              ),
//                            ),



                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: new FutureBuilder(
                                    future: fvendedores,
                                    builder: (BuildContext context,AsyncSnapshot<List<Vendedor>> snapshot) {
                                      if (!snapshot.hasData) return CircularProgressIndicator();
                                      return DropdownButton<Vendedor>(
                                        isExpanded: true,
                                        value: _currentvendedor,
                                        icon: Icon(Icons.check_circle_outline),
                                        hint: Text("Choose"),
                                        items: snapshot.data
                                            .map((items) => DropdownMenuItem<Vendedor>(
                                          child: Text(items.nombre),
                                          value: items,
                                        ))
                                            .toList(),
                                        onChanged: (Vendedor newValue) {
                                          setState(() => this._currentvendedor = newValue);
                                        },
                                      );
                                    }),
                              ),
                            ),



          ],
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
          title: new Text("Pedidos"),
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
//              title: new Text(values[index].nombre+" "+values[index].nombre+" "+values[index].nombre+" "+values[index].nombre+" "+values[index].nombre+" "+values[index].nombre),
              //            title: new Text(AppLocalizations.of(context).reservafiltro +values[index].idreserva.toString()+ AppLocalizations.of(context).nombrefiltro+values[index].nombre),
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
                Navigator.push(context, new MaterialPageRoute(builder: (context) => PedidosIntro()));
              },
            ),
            new Divider(height: 2.0,),
          ],
        );
      },
    );
  }



}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

