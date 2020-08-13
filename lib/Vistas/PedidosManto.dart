import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jessmarwindesk/Domains/Articulos.dart';
import 'package:jessmarwindesk/Domains/articulo.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Domains/pedidos.dart';
import 'package:jessmarwindesk/Domains/vendedor.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/PedidosIntro.dart';
import 'package:color_panel/color_panel.dart';
import 'dart:io' show Platform;

import 'package:nice_button/NiceButton.dart';

import 'ListaPedidos.dart';

class PedidosManto extends StatefulWidget {
  Pedido pedido;
  PedidosManto({Key key, @required this.pedido}) : super(key: key);

  _PedidosMantoState createState() => _PedidosMantoState();
}


class _PedidosMantoState extends State<PedidosManto> {

  JessmarService service = JessmarService();

  final TextEditingController _numberpedidoController = new TextEditingController();
  final TextEditingController _areaEntregaController = new TextEditingController();

  /*Controller de Detalle*/
  final TextEditingController _idDetalleController =  new TextEditingController();
  final TextEditingController _articuloController =  new TextEditingController();
  final TextEditingController _cantidadController = new TextEditingController();
  final TextEditingController _precioController = new TextEditingController();

  final TextEditingController dateCtl = TextEditingController();

  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

  DateTime date ;

  Future<Pedido> fpedido;
  Future<List<Pedido>> fpedidos;
  Future<List<Cliente>> fclientes;
  Future<List<Vendedor>> fvendedores;
  Future<List<Articulo>> farticulos;

  Pedido onepedido;
  List<Pedido> lpedidos;
  List<Pedido_detalle> values;
  List<Cliente> lclientes;
  List<Vendedor> lvendedores;
  List<Articulo> larticulos;

  List<DropdownMenuItem<Cliente>> _dropdownMenuItems;

  String valor = "";
  Item selectedUser;

//  List<Item> users = <Item>[
//    const Item('Android',Icon(Icons.android,color:  const Color(0xFF167F67),)),
//    const Item('Flutter',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
//    const Item('ReactNative',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
//    const Item('iOS',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
//  ];

  Pedido    _currentpedido;
  Cliente  _currentcliente;
  Vendedor _currentvendedor;
  Articulo _currentarticulo;

  Future<Map<String,dynamic>> datos;

  String _selectedDate = 'Tap to select date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      locale : const Locale("fr","FR"),
      initialDate: DateTime.parse(onepedido.fechapedido),
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
    datos = _getData();
  }



  Future<Map<String,dynamic>> _getData() async {

    Pedido pedido = widget.pedido;
    print("Servicio  _getData");

     if(pedido.id == 0 ){
       onepedido = pedido;
     }else{
       onepedido   = await service.getOnePedido(pedido.id.toString());
     }

    _numberpedidoController.value = _numberpedidoController.value.copyWith(text:onepedido.id.toString(),);
    _areaEntregaController.text = onepedido.areaentrega;





    _selectedDate = onepedido.fechapedido;
    dateCtl.text = onepedido.fechapedido;

    lpedidos    = await service.getListaPedidos();

    fclientes   = service.getListaClientes();
    lclientes   = await fclientes;
    var it0 = lclientes.iterator;
    Cliente vcliente ;
    while (it0.moveNext()) {
      vcliente = it0.current;
      if(vcliente.id==onepedido.clientes_id){
            _currentcliente=vcliente;
            break;
      }
    }

    fvendedores = service.getListaVendedores();
    lvendedores = await fvendedores;
    var it1 = lvendedores.iterator;
    Vendedor vvendedor ;
    while (it1.moveNext()) {
      vvendedor = it1.current;
      if(vvendedor.id==onepedido.vendedor_id){
        _currentvendedor=vvendedor;
        break;
      }
    }

    farticulos = service.getListaArticulosFull();
    larticulos = await farticulos;
    _currentarticulo = larticulos[0];


    Map<String,dynamic> datos = new Map();

    datos["onepedido"]= onepedido;

    datos["lpedidos"] = lpedidos;
    datos["fclientes"] = fclientes;
    datos["lclientes"] = lclientes;
    datos["fvendedores"] = fvendedores;

    return datos;

  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      //initialDate: DateTime.now(),
      initialDate:DateTime.parse(onepedido.fechapedido),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    var futureBuilder = new FutureBuilder(
        future: datos,
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
                                child: TextFormField(
                                  enabled: false,
                                  controller: _numberpedidoController,
                                  obscureText: false,
                                  decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                    labelText: "Numero de Pedido",
                                  ),
                                ),
                              ),
                            ),


                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: new FutureBuilder(
                                    future: fclientes,
                                    builder: (BuildContext context,AsyncSnapshot<List<Cliente>> snapshot) {
                                      if (!snapshot.hasData) return CircularProgressIndicator();
                                      return DropdownButtonFormField<Cliente>(
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Cliente",
                                        ),
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
                                          setState(() =>
                                            this._currentcliente = newValue
                                          );
                                        },
                                      );
                                    }),
                              ),
                            ),



                            SizedBox(
                              height: 15.0,
                            ),


//                            InkWell(
//                              child: Text(
//                                  _selectedDate,
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(color: Color(0xFF000000))
//                              ),
//                              onTap: (){
//                                _selectDate(context);
//                              },
//                            ),
//                            IconButton(
//                              icon: Icon(Icons.calendar_today),
//                              tooltip: 'Tap to open date picker',
//                              onPressed: () {
//                                _selectDate(context);
//                              },
//                            ),




                          new Flexible(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: dateCtl,
                                decoration: InputDecoration(
                                  labelText: "Fecha del Pedido",
                                  hintText: "Ex. Insert your dob",),
                                onTap: () async{
                                  date = DateTime(1900);
                                  FocusScope.of(context).requestFocus(new FocusNode());

                                  date = await showDatePicker(
                                      context: context,
                                      initialDate:DateTime.now(),
                                      firstDate:DateTime(1900),
                                      lastDate: DateTime(2100));

                                  dateCtl.text = date.toIso8601String();},
                                ),
                          ),
                          ),





                            SizedBox(
                              height: 15.0,
                            ),


                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: new FutureBuilder(
                                    future: fvendedores,
                                    builder: (BuildContext context,AsyncSnapshot<List<Vendedor>> snapshot) {
                                      if (!snapshot.hasData) return CircularProgressIndicator();
                                      return DropdownButtonFormField<Vendedor>(
                                        decoration: InputDecoration(
   //                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Vendedor",
                                        ),
                                        isExpanded: true,
                                        value: this._currentvendedor,
                                        icon: Icon(Icons.check_circle_outline),
                                        hint: Text("Choose"),
                                        items: snapshot.data
                                            .map((items) => DropdownMenuItem<Vendedor>(
                                          child: Text(items.nombre),
                                          value: items,
                                        ))
                                            .toList(),
                                        onChanged: (Vendedor newValue) {
                                          setState(() =>
                                            this._currentvendedor = newValue
                                          );
                                        },
                                      );
                                    }),
                              ),
                            ),




                            new Flexible(
                               child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  controller: _areaEntregaController,
                                  obscureText: false,
                                  decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                    labelText: "Area Entrege",
                                  ),
                                ),
                              ),
                            ),


                        ],
                      ),


                      ),


          /* Lista de Productos */




          Container(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[


            Expanded(
              flex: 1,
              child: Container(
                constraints: BoxConstraints.expand(
                  height:  500 ,
                ),
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                alignment: Alignment.topLeft,
                child:

                Column(
                  children: <Widget>[

                  ],
                ),
              ),
            ),


              Expanded(
              flex: 4,
              child: Container(
                          constraints: BoxConstraints.expand(
                            height:  500 ,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.white,
                          alignment: Alignment.topLeft,
                          child: createDataTable(context, snapshot)
                        //                      transform: Matrix4.rotationZ(0.1),
                      ),
              ),







            Expanded(
              flex: 1,
              child: Container(
                  constraints: BoxConstraints.expand(
                    height:  500 ,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  child:

                  Column(
                    children: <Widget>[

//          Container(
//          child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//
//            NiceButton(
//              mini: true,
//              icon: Icons.add,
//              background: firstColor,
//              onPressed: () {
//                print("hello");
//              },
//            ),
//            NiceButton(
//              mini: true,
//              icon: Icons.edit,
//              background: firstColor,
//              onPressed: () {
//                print("hello");
//              },
//            ),
//            NiceButton(
//              mini: true,
//              icon: Icons.delete,
//              background: firstColor,
//              onPressed: () {
//                print("hello");
//              },
//            )
//
//          ]
//          )
//          ),


                        NiceButton(

                          width: 30.0,
                          mini: true,
                          icon: Icons.add,
                          background: firstColor,
                          onPressed: () {
                            newRecord();
                          },
                        ),



                       Visibility(
                          visible: false,
                          child:TextFormField(
                          controller: _cantidadController,
                          obscureText: false,
                          decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                            labelText: "Teclee la cantidad",
                          ),
                        ),
                       ),




                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new FutureBuilder(
                              future: farticulos,
                              builder: (BuildContext context,AsyncSnapshot<List<Articulo>> snapshot) {
                                if (!snapshot.hasData) return CircularProgressIndicator();
                                return DropdownButtonFormField<Articulo>(
                                  decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                    labelText: "Seleccione el Producto",
                                  ),
                                  isExpanded: true,
                                  value: _currentarticulo,
                                  icon: Icon(Icons.check_circle_outline),
                                  hint: Text("Choose"),
                                  items: snapshot.data
                                      .map((items) => DropdownMenuItem<Articulo>(
                                    child: Text(items.descripcion),
                                    value: items,
                                  ))
                                      .toList(),
                                  onChanged: (Articulo newValue) {
                                    setState(() =>
                                    this._currentarticulo = newValue
                                    );
                                  },
                                );
                              }),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: _cantidadController,
                          obscureText: false,
                          decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                            labelText: "Teclee la cantidad",
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: _precioController,
                          obscureText: false,
                          decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                            labelText: "Teclee el precio",
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 15.0,
                      ),

                      NiceButton(
                        fontSize: 14,
                        width: 200,
                        elevation: 8.0,
                        radius: 45.0,
                        text: "Aceptar",
                        background: firstColor,
                        onPressed: () {
                          addRecord();
                        },
                      ),



                    ],
                  ),

                //                      transform: Matrix4.rotationZ(0.1),
              ),
            ),





          Expanded(
          flex: 1,
          child: Container(
          constraints: BoxConstraints.expand(
          height:  500 ,
          ),
          padding: const EdgeInsets.all(8.0),
          color: Colors.white,
          alignment: Alignment.topLeft,
          child:

          Column(
          children: <Widget>[

          ],
          ),
          ),
          ),





            ]
           )
          )







                    ],
                  );

          }
        }
    );

    return new Scaffold(

        appBar: new AppBar(
          title: new Text("Pedidos"),
        ),

        floatingActionButton: Column(

            mainAxisAlignment: MainAxisAlignment.end,
            children: [
//              FloatingActionButton(
//                child: Icon(
//                    Icons.add
//                ),
//                onPressed: () {
//                  //...
//                },
//                heroTag: null,
//              ),
//              SizedBox(
//                height: 10,
//              ),
              FloatingActionButton(
                child: Icon(
                    Icons.save
                ),
                onPressed: () {
                     saveRecord();
                },
                heroTag: null,
              )
            ]
        ),



        body: new SingleChildScrollView(
          child: futureBuilder,
        )
    );



  }

  void _getSelectedRowInfo() {
    print('Selected Item Row Name Here...');
  }





  Widget createDataTable(BuildContext context, AsyncSnapshot snapshot) {

    Pedido pedido = snapshot.data["onepedido"] ;
    values = pedido.pedidosdetalle;

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
          label: Text('Descripcion'),
        ),
        DataColumn(
          label: Text('Cantidad'),
        ),
        DataColumn(
          label: Text('Precio'),
        ),
        DataColumn(
          label: Text('Total'),
        ),
        DataColumn(
          label: Text('DELETE'),
        )

      ],
      rows: values
          .map(
            (itemRow) => DataRow(
          cells: [
            DataCell(
              Text(itemRow.id.toString()),
              showEditIcon: true,
              placeholder: true,
              onTap: () {
                 //Navigator.push(context, new MaterialPageRoute(builder: (context) => PedidosIntro( detalle: itemRow)));
                 editRecord(itemRow);
              },
            ),
            DataCell(
              Text(itemRow.articulo_id.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised(itemRow),
            ),
            DataCell(
              Text(itemRow.articulodescripcion),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised(itemRow),
            ),
            DataCell(
              Text(itemRow.cantidad.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(
              Text(itemRow.precio.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(
              Text(itemRow.total.toString()),
              showEditIcon: false,
              placeholder: false,
              //onTap: actionButtonRaised,
            ),
            DataCell(IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
                _deleteRecord(itemRow);
            },
            )
            )
          ],
        ),
      )
          .toList(),
    );


    }


//  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
//
//    Pedido pedido = snapshot.data["onepedido"];
//    List<Pedido_detalle> values = pedido.pedidosdetalle;
//
//    return new ListView.builder(
//      itemCount: values.length,
//      itemBuilder: (BuildContext context, int index) {
//        return new Column(
//          children: <Widget>[
//
//            new ListTile(
////              title: new Text(values[index].nombre+" "+values[index].nombre+" "+values[index].nombre+" "+values[index].nombre+" "+values[index].nombre+" "+values[index].nombre),
//              //            title: new Text(AppLocalizations.of(context).reservafiltro +values[index].idreserva.toString()+ AppLocalizations.of(context).nombrefiltro+values[index].nombre),
//              title: new Text(
//                      values[index].id.toString()+" "+
//                      values[index].articulo_id.toString()+" "+
//                      values[index].cantidad.toString()+" "+
//                      values[index].precio.toString()+" "+
//                      values[index].total.toString()+" "
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
//                //Navigator.push(context, new MaterialPageRoute(builder: (context) => PedidosIntro( detalle: values[index] )));
//              },
//            ),
//            new Divider(height: 2.0,),
//          ],
//        );
//      },
//    );
//  }

  Future<void> actionButtonRaised() {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ListaPedidos(),
      ),
    );

  }

  newRecord() {
    _idDetalleController.text = "0";
//    _articuloController.text = _detalle.articulodescripcion;
//    _cantidadController.text = _detalle.cantidad.toString();
//    _precioController.text = _detalle.precio.toString();
  }


  editRecord(Pedido_detalle  itemRow) {
    var _detalle = itemRow;
    _idDetalleController.text = _detalle.id.toString();
    _articuloController.text = _detalle.articulodescripcion;
    _cantidadController.text = _detalle.cantidad.toString();
    _precioController.text = _detalle.precio.toString();
  }

  _deleteRecord(Pedido_detalle detail) async {

             await service.deletePedidoDetalleById(detail.id.toString());
             values.remove(detail);

    //values = await service.getListaPedidoDetalleByIdPedido(onepedido.id.toString());

    setState(() {});
    print("registroBorrado");
  }





  addRecord(){

     // int.parse( _idDetalleController.text );

     Pedido_detalle value = new Pedido_detalle();
     value.id=int.parse(_idDetalleController.text);
     value.articulo_id=_currentarticulo.id;
     value.articulodescripcion=_currentarticulo.descripcion;
     value.cantidad= double.parse( _cantidadController.text );
     value.precio= double.parse( _precioController.text );
     value.total= value.cantidad * value.precio;
     value.pedido_id=int.parse(_numberpedidoController.text);

     if(value.id==0){
           values.add(value);
     }else {
           int index = 0;
           for (Pedido_detalle element in values) {
             if (element.id == int.parse(_idDetalleController.text)) {
               values[index] = value;
               break;
             }
             index = index + 1;
           }
     }
     setState(() {});

  }



  saveRecord() async {

      Pedido pedido = new Pedido();
      pedido.id = int.parse(_numberpedidoController.text);
      pedido.tipopedido_id=1;
      pedido.clientes_id = _currentcliente.id;
      pedido.vendedor_id = _currentvendedor.id;
      final f = new DateFormat('yyyy-MM-dd hh:mm');
      pedido.fechapedido = f.format(DateTime.now());
      pedido.areaentrega = _areaEntregaController.text;
      pedido.usuario = "jdelgado";
      pedido.pedidosdetalle = values;
      await service.salvaOnePedido(pedido);
      actionButtonRaised();

  }



}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

