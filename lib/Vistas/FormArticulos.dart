import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jessmarwindesk/Domains/Articulos.dart';
import 'package:jessmarwindesk/Domains/articulo.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/grupo.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Domains/pedidos.dart';
import 'package:jessmarwindesk/Domains/unidadmedida.dart';
import 'package:jessmarwindesk/Domains/vendedor.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/ListaArticulos.dart';
import 'package:jessmarwindesk/Vistas/PedidosIntro.dart';
import 'package:color_panel/color_panel.dart';
import 'dart:io' show Platform;

import 'package:nice_button/NiceButton.dart';

import 'ListaPedidos.dart';

class FormArticulos extends StatefulWidget {
  Articulo articu;
  FormArticulos({Key key, @required this.articu}) : super(key: key);
  _FormArticulosState createState() => _FormArticulosState();
}


class _FormArticulosState extends State<FormArticulos> {


  JessmarService service = JessmarService();

  List <String> statusArticulo = [
    'ACTIVO',
    'INACTIVO'
  ] ;

  final TextEditingController _idController = new TextEditingController();
  final TextEditingController _codigoController = new TextEditingController();
  final TextEditingController _descripcionController = new TextEditingController();
  final TextEditingController _grupoController = new TextEditingController();
  final TextEditingController _lugarController = new TextEditingController();
  final TextEditingController _parteController = new TextEditingController();
  final TextEditingController _cvesatController = new TextEditingController();
  final TextEditingController _unidadsatController = new TextEditingController();

  final TextEditingController _maximoController = new TextEditingController();
  final TextEditingController _pordenController = new TextEditingController();
  final TextEditingController _minimoController = new TextEditingController();
  final TextEditingController _codigoanteriorController = new TextEditingController();
  final TextEditingController _estatusController = new TextEditingController();

  final TextEditingController _medidaController = new TextEditingController();
  final TextEditingController _pcio1Controller = new TextEditingController();
  final TextEditingController _pcio2Controller = new TextEditingController();
  final TextEditingController _pcio3Controller = new TextEditingController();
  final TextEditingController _pcio4Controller = new TextEditingController();


  final TextEditingController dateCtl = TextEditingController();
  var firstColor = Color(0xff5b86e5),
      secondColor = Color(0xff36d1dc);

  DateTime date;

  Future<Pedido> fpedido;
  Future<List<Pedido>> fpedidos;
  Future<List<Cliente>> fclientes;
  Future<List<Vendedor>> fvendedores;
  Future<List<Articulo>> farticulos;
  Future<List<Unidadmedida>> funidadmedida;
  Future<List<Grupo>> fgrupos;

  Pedido onepedido;
  List<Pedido> lpedidos;
  List<Pedido_detalle> values;
  List<Cliente> lclientes;
  List<Vendedor> lvendedores;
  List<Articulo> larticulos;
  List<Unidadmedida> lunidadmedida;
  List<Grupo> lgrupos;

  List<DropdownMenuItem<Cliente>> _dropdownMenuItems;

  String valor = "";
  Item selectedUser;


  Pedido _currentpedido;
  Cliente _currentcliente;
  Vendedor _currentvendedor;
  Articulo _currentarticulo;
  String _currentEstatus;
  Unidadmedida _currentUnidadmedida;
  Grupo _currentGrupo;

  Future<Map<String, dynamic>> datos;

  String _selectedDate = 'Tap to select date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      locale: const Locale("fr", "FR"),
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


  Future<Map<String, dynamic>> _getData() async {
    Articulo articulo = widget.articu;

    _idController.text = articulo.id.toString();
    _codigoController.text = articulo.codigo;
    _codigoanteriorController.text = articulo.codant;
    _descripcionController.text = articulo.descripcion;
    _grupoController.text = articulo.grupo_id.toString();
    _lugarController.text = articulo.lugar;
    _parteController.text = articulo.parte;
    _cvesatController.text = articulo.cvesat;
    _unidadsatController.text = articulo.unidadsat;
    _maximoController.text = articulo.maximo.toString();
    _pordenController.text = articulo.prorden.toString();
    _minimoController.text = articulo.minimo.toString();
    _currentEstatus = articulo.estatus=="A"?"ACTIVO":"INACTIVO";

    Map<String, dynamic> datos = new Map();

    Pedido pedido = new Pedido();
    print("Servicio  _getData");

    if (pedido.id == 0) {
      onepedido = pedido;
    } else {
      onepedido = await service.getOnePedido(pedido.id.toString());
    }

    datos["onepedido"] = onepedido;

    funidadmedida = service.getListaUnidadesMedida();
    lunidadmedida = await funidadmedida;
    var it1 = lunidadmedida.iterator;
    Unidadmedida vunidadmedida ;
    while (it1.moveNext()) {
      vunidadmedida = it1.current;
      if(vunidadmedida.id==articulo.unidmed_id){
        _currentUnidadmedida=vunidadmedida;
        break;
      }
    }

    fgrupos = service.getListaGrupos();
    lgrupos = await fgrupos;
    var it2 = lgrupos.iterator;
    Grupo vgrupo ;
    while (it2.moveNext()) {
      vgrupo = it2.current;
      if(vgrupo.id==articulo.grupo_id){
        _currentGrupo=vgrupo;
        break;
      }
    }


    return datos;
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      //initialDate: DateTime.now(),
      initialDate: DateTime.parse(onepedido.fechapedido),
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


                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        enabled: false,
                                        controller: _idController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Id Articulo",
                                        ),
                                      ),
                                    ),


//                            new Flexible(
//                              child:
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _codigoController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Codigo del Articulo",
                                        ),
                                      ),
                                    ),
//                            ),


//                            new Flexible(
//                              child:
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _descripcionController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Descripcion del Articulo",
                                        ),
                                      ),
                                    ),
//                            ),


//                                     Padding(
//                                       padding: const EdgeInsets.all(5.0),
//                                       child: TextFormField(
//                                         controller: _grupoController,
//                                         obscureText: false,
//                                         decoration: InputDecoration(
// //                                    prefixIcon: Icon(Icons.lock),
//                                           labelText: "Grupo Articulo",
//                                         ),
//                                       ),
//                                     ),

                                    Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: DropdownButtonFormField<Grupo>(
                                          decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                            labelText: "Grupo",
                                          ),
                                          isExpanded: true,
                                          value: _currentGrupo,
                                          icon: Icon(Icons.check_circle_outline),
                                          hint: Text("Choose"),
                                          items: lgrupos
                                              .map((items) => DropdownMenuItem<Grupo>(
                                            child: Text(items.descripcion),
                                            value: items,
                                          ))
                                              .toList(),
                                          onChanged: (Grupo newValue) {
                                            setState(() =>
                                            this._currentGrupo = newValue
                                            );
                                          },
                                        )
                                    ),




//                            new Flexible(
//                              child:
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _lugarController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Pasillo Articulo",
                                        ),
                                      ),
                                    ),
//                            ),


//                            new Flexible(
//                              child:
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _parteController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Anaquel Articulo",
                                        ),
                                      ),
                                    ),
//                            ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _cvesatController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Clave Sat",
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _unidadsatController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Unidad Sat",
                                        ),
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

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,

                                  children: <Widget>[


                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _maximoController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Maximo Articulo",
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _pordenController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Punto Reorden Articulo",
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _minimoController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Minimo Articulo",
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _codigoanteriorController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Codigo Anterior Articulo",
                                        ),
                                      ),
                                    ),


                                    Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: DropdownButton<String>(
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


                                    Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: DropdownButtonFormField<Unidadmedida>(
                                          decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                            labelText: "Unidad Medida",
                                          ),
                                          isExpanded: true,
                                          value: _currentUnidadmedida,
                                          icon: Icon(Icons.check_circle_outline),
                                          hint: Text("Choose"),
                                          items: lunidadmedida
                                              .map((items) => DropdownMenuItem<Unidadmedida>(
                                            child: Text(items.descripcion),
                                            value: items,
                                          ))
                                              .toList(),
                                          onChanged: (Unidadmedida newValue) {
                                            setState(() =>
                                            this._currentUnidadmedida = newValue
                                            );
                                          },
                                        )
                                    ),





//                                       TextFormField(
//                                        controller: _estatusController,
//                                        obscureText: false,
//                                        decoration: InputDecoration(
////                                    prefixIcon: Icon(Icons.lock),
//                                          labelText: "Estatus Articulo",
//                                        ),
//                                      ),

//                                    ),


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





//                                    Padding(
//                                      padding: const EdgeInsets.all(5.0),
//                                      child: TextFormField(
//                                        controller: _medidaController,
//                                        obscureText: false,
//                                        decoration: InputDecoration(
////                                    prefixIcon: Icon(Icons.lock),
//                                          labelText: "Precio 1 Articulo",
//                                        ),
//                                      ),
//                                    ),
//                                    Padding(
//                                      padding: const EdgeInsets.all(5.0),
//                                      child: TextFormField(
//                                        controller: _medidaController,
//                                        obscureText: false,
//                                        decoration: InputDecoration(
////                                    prefixIcon: Icon(Icons.lock),
//                                          labelText: "Precio 2 Articulo",
//                                        ),
//                                      ),
//                                    ),
//                                    Padding(
//                                      padding: const EdgeInsets.all(5.0),
//                                      child: TextFormField(
//                                        controller: _medidaController,
//                                        obscureText: false,
//                                        decoration: InputDecoration(
////                                    prefixIcon: Icon(Icons.lock),
//                                          labelText: "Medida Articulo",
//                                        ),
//                                      ),
//                                    ),
//                                    Padding(
//                                      padding: const EdgeInsets.all(5.0),
//                                      child: TextFormField(
//                                        controller: _medidaController,
//                                        obscureText: false,
//                                        decoration: InputDecoration(
////                                    prefixIcon: Icon(Icons.lock),
//                                          labelText: "Medida Articulo",
//                                        ),
//                                      ),
//                                    ),


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
          title: new Text("Captura Articulos"),
          automaticallyImplyLeading: false,
        ),

        floatingActionButton: Column(

            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              FloatingActionButton(
                child: Icon(
                    Icons.arrow_back
                ),
                onPressed: () {
                  gotoListaArticulos();
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

  gotoListaArticulos(){
    Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => ListaArticulos()),
            (Route<dynamic> route) => false);
  }



  Widget createDataTable(BuildContext context, AsyncSnapshot snapshot) {
    Pedido pedido = snapshot.data["onepedido"];
    values = pedido.pedidosdetalle;

    return DataTable(
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
            (itemRow) =>
            DataRow(
              cells: [
                DataCell(
                  Text(itemRow.id.toString()),
                  showEditIcon: true,
                  placeholder: true,
                  onTap: () {
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


  Future<void> actionButtonRaised() {
//    //Navigator.of(context).pop();
//    Navigator.pop(context); // pass true value

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) =>  ListaArticulos()),
            (Route<dynamic> route) => false
    );

//    Navigator.pushReplacement(
//      context,
//      MaterialPageRoute(
//        builder: (context) => ListaArticulos()
//      ),
//    );

  }

  newRecord() {
//    _idDetalleController.text = "0";
//    _articuloController.text = _detalle.articulodescripcion;
//    _cantidadController.text = _detalle.cantidad.toString();
//    _precioController.text = _detalle.precio.toString();
  }


  editRecord(Pedido_detalle itemRow) {
//    var _detalle = itemRow;
//    _idDetalleController.text = _detalle.id.toString();
//    _articuloController.text = _detalle.articulodescripcion;
//    _cantidadController.text = _detalle.cantidad.toString();
//    _precioController.text = _detalle.precio.toString();
  }

  _deleteRecord(Pedido_detalle detail) async {
//             await service.deletePedidoDetalleById(detail.id.toString());
//             values.remove(detail);
//
//    //values = await service.getListaPedidoDetalleByIdPedido(onepedido.id.toString());
//
//    setState(() {});
//    print("registroBorrado");
  }


  addRecord() {
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
    Articulo articulo = new Articulo();
    articulo.id = int.parse(_idController.text);
    articulo.codigo = _codigoController.text;
    articulo.codant = _codigoanteriorController.text;
    articulo.descripcion = _descripcionController.text;
    articulo.lugar = _lugarController.text;
    articulo.parte = _parteController.text;
    articulo.cvesat = _cvesatController.text;
    articulo.unidadsat = _unidadsatController.text;
    articulo.almacen_id = 1;
    articulo.subgrupo_id = 1;
    articulo.estatus = _currentEstatus=="ACTIVO"?"A":"I";
    articulo.grupo_id = _currentGrupo.id;
    articulo.unidmed_id = _currentUnidadmedida.id;
    articulo.maximo = double.parse(_maximoController.text);
    articulo.prorden = double.parse(_pordenController.text);
    articulo.minimo = double.parse(_minimoController.text);
    articulo.activo = true;
    await service.salvaOneArticulos(articulo);
    actionButtonRaised();
  }

}


  class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
  }

