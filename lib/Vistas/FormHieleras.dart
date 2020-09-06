import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jessmarwindesk/Domains/Articulos.dart';
import 'package:jessmarwindesk/Domains/articulo.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/estado.dart';
import 'package:jessmarwindesk/Domains/hielera.dart';
import 'package:jessmarwindesk/Domains/pais.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Domains/pedidos.dart';
import 'package:jessmarwindesk/Domains/vendedor.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/PedidosIntro.dart';
import 'package:color_panel/color_panel.dart';
import 'dart:io' show Platform;

import 'package:nice_button/NiceButton.dart';

import 'ListaClientes.dart';
import 'ListaHieleras.dart';
import 'ListaPedidos.dart';
import 'ListaVendedores.dart';

class FormHieleras extends StatefulWidget {
  Hielera hielera;
  FormHieleras({Key key, @required this.hielera}) : super(key: key);
  _FormHielerasState createState() => _FormHielerasState();
}


class _FormHielerasState extends State<FormHieleras> {

  JessmarService service = JessmarService();

  List <String> statusArticulo = [
    'ACTIVO',
    'INACTIVO'
  ] ;

  final TextEditingController _idController = new TextEditingController();
  final TextEditingController _codigoController = new TextEditingController();
  final TextEditingController _nombreController = new TextEditingController();
  // final TextEditingController _direccionController =  new TextEditingController();
  // final TextEditingController _noextController =  new TextEditingController();
  // final TextEditingController _coloniaController = new TextEditingController();
  // final TextEditingController _ciudadController = new TextEditingController();
  // final TextEditingController _municipioController = new TextEditingController();
  // final TextEditingController _codigopostController = new TextEditingController();
  // final TextEditingController _emailController = new TextEditingController();
  // final TextEditingController _telefonoController = new TextEditingController();
  // final TextEditingController _rfcController = new TextEditingController();


  final TextEditingController dateCtl = TextEditingController();
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

  DateTime date ;

  Future<Pedido> fpedido;
  Future<List<Pedido>> fpedidos;
  Future<List<Cliente>> fclientes;
  Future<List<Vendedor>> fvendedores;
  Future<List<Articulo>> farticulos;
  Future<List<Pais>> fpaises;
  Future<List<Estado>> festados;

  Pedido onepedido;
  List<Pedido> lpedidos;
  List<Pedido_detalle> values;
  List<Cliente> lclientes;
  List<Vendedor> lvendedores;
  List<Articulo> larticulos;
  List<Pais> lpaises;
  List<Estado> lestados;

  List<DropdownMenuItem<Cliente>> _dropdownMenuItems;

  String valor = "";
  Item selectedUser;


  // Pedido    _currentpedido;
  // Cliente  _currentcliente;
  // Vendedor _currentvendedor;
  // Articulo _currentarticulo;
  // Pais _currentpais;
  // Estado _currentestado;
  String _currentEstatus;


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

    Hielera hielera = widget.hielera;

    _idController.text = hielera.id.toString();
    _codigoController.text = hielera.clave;
    _nombreController.text = hielera.descripcion;
    _currentEstatus = hielera.activa==true?"ACTIVO":"INACTIVO";

    // _direccionController.text = cliente.direccion;
    // _noextController.text = cliente.noext;
    // _coloniaController.text = cliente.colonia;
    // _codigopostController.text = cliente.codigopost;
    // _emailController.text = cliente.email;
    // _ciudadController.text = cliente.ciudad;
    // _municipioController.text = cliente.municipio;
    // _telefonoController.text = cliente.telefono;
    // _rfcController.text = cliente.rfc;
    //
    // fpaises   = service.getListaPaises();
    // lpaises   = await fpaises;
    // var it0 = lpaises.iterator;
    // Pais vpais ;
    // while (it0.moveNext()) {
    //   vpais = it0.current;
    //   if(vpais.id==cliente.pais_id){
    //     _currentpais=vpais;
    //     break;
    //   }
    // }
    //
    //
    // festados   = service.getListaEstados();
    // lestados   = await festados;
    // var it1 = lestados.iterator;
    // Estado vestado ;
    // while (it1.moveNext()) {
    //   vestado = it1.current;
    //   if(vestado.id==cliente.estado_id){
    //     _currentestado=vestado;
    //     break;
    //   }
    // }


    Map<String,dynamic> datos = new Map();

    Pedido pedido = new Pedido();
    print("Servicio  _getData");

    if(pedido.id == 0 ){
      onepedido = pedido;
    }else{
      onepedido   = await service.getOnePedido(pedido.id.toString());
    }

    datos["onepedido"]= onepedido;

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




                      Row(
                        children: [


                          Container(
                            width: 350,
                            padding: const EdgeInsets.all(16.0),
                            //decoration: BoxDecoration(border: Border.all(width: 0.0)),
                            child:




                            Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[





//                            new Flexible(
//                              child:
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextFormField(
                                      controller: _idController,
                                      obscureText: false,
                                      decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                        labelText: "Id. Hielera",
                                      ),
                                    ),
                                  ),
//                            ),


//                            new Flexible(
//                              child:
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: _codigoController,
                                    obscureText: false,
                                    decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                      labelText: "Codigo de Hielera",
                                    ),
                                  ),
                                ),
//                            ),






                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextFormField(
                                      controller: _nombreController,
                                      obscureText: false,
                                      decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                        labelText: "Nombre de Hielera",
                                      ),
                                    ),
                                  ),



                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: _currentEstatus,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String data) {
                                      setState(() {
                                        _currentEstatus = data;
                                      });
                                    },
                                    items: statusArticulo.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),










                                ]
                               )
                              ),



                          Container(
                              width: 350,
                              padding: const EdgeInsets.all(16.0),
                              //decoration: BoxDecoration(border: Border.all(width: 0.0)),
                              child:




                              Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[









                                  ]
                              )
                          ),



                          Container(
                              width: 350,
                              padding: const EdgeInsets.all(16.0),
                              //decoration: BoxDecoration(border: Border.all(width: 0.0)),
                              child:




                              Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[




                                  ]
                              )
                          ),





                        ],
                      )

                    ],
                  );

          }
        }
    );

    return new Scaffold(

        appBar: new AppBar(
          title: new Text("Captura Clientes"),
        ),

        floatingActionButton: Column(

            mainAxisAlignment: MainAxisAlignment.end,
            children: [


              FloatingActionButton(
                child: Icon(
                    Icons.arrow_back
                ),
                onPressed: () {
                  gotoListaHieleras();
                },
                heroTag: null,
              ),


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

  gotoListaHieleras(){
    Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => ListaHieleras()),
            (Route<dynamic> route) => false);
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
        builder: (context) => ListaHieleras(),
      ),
    );

  }

  newRecord() {
//    _idDetalleController.text = "0";
//    _articuloController.text = _detalle.articulodescripcion;
//    _cantidadController.text = _detalle.cantidad.toString();
//    _precioController.text = _detalle.precio.toString();
  }


  editRecord(Pedido_detalle  itemRow) {
//    var _detalle = itemRow;
//    _idDetalleController.text = _detalle.id.toString();
//    _articuloController.text = _detalle.articulodescripcion;
//    _cantidadController.text = _detalle.cantidad.toString();
//    _precioController.text = _detalle.precio.toString();
  }

  _deleteRecord(Pedido_detalle detail) async {

             await service.deletePedidoDetalleById(detail.id.toString());
             values.remove(detail);

    //values = await service.getListaPedidoDetalleByIdPedido(onepedido.id.toString());

    setState(() {});
    print("registroBorrado");
  }





  addRecord(){

//     // int.parse( _idDetalleController.text );
//
//     Pedido_detalle value = new Pedido_detalle();
//     value.id=int.parse(_idDetalleController.text);
//     value.articulo_id=_currentarticulo.id;
//     value.articulodescripcion=_currentarticulo.descripcion;
//     value.cantidad= double.parse( _cantidadController.text );
//     value.precio= double.parse( _precioController.text );
//     value.total= value.cantidad * value.precio;
//     value.pedido_id=int.parse(_numberpedidoController.text);
//
//     if(value.id==0){
//           values.add(value);
//     }else {
//           int index = 0;
//           for (Pedido_detalle element in values) {
//             if (element.id == int.parse(_idDetalleController.text)) {
//               values[index] = value;
//               break;
//             }
//             index = index + 1;
//           }
//     }
//     setState(() {});

  }



  saveRecord() async {

       Hielera hielera = new Hielera();
       hielera.id = int.parse( _idController.text );
       hielera.descripcion= _nombreController.text;
       hielera.activa = _currentEstatus=="ACTIVO"?true:false;
       hielera.clave = _codigoController.text;

       final f = new DateFormat('yyyy-MM-dd hh:mm');
       hielera.fecha_adquisicion= f.format(DateTime.now());
       hielera.fecha_baja= f.format(DateTime.now());

       await service.salvaOneHielera(hielera);
      actionButtonRaised();

  }



}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

