import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jessmarwindesk/Domains/Articulos.dart';
import 'package:jessmarwindesk/Domains/articulo.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/estado.dart';
import 'package:jessmarwindesk/Domains/pais.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Domains/pedidos.dart';
import 'package:jessmarwindesk/Domains/usocfdi.dart';
import 'package:jessmarwindesk/Domains/vendedor.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/PedidosIntro.dart';
import 'package:color_panel/color_panel.dart';
import 'dart:io' show Platform;

import 'package:nice_button/NiceButton.dart';

import 'FormClientePrecios.dart';
import 'ListaClientes.dart';
import 'ListaPedidos.dart';

class FormClientes extends StatefulWidget {
  Cliente cliente;
  FormClientes({Key key, @required this.cliente}) : super(key: key);
  _FormClientesState createState() => _FormClientesState();
}


class _FormClientesState extends State<FormClientes> {

  JessmarService service = JessmarService();

  final TextEditingController _codigoController = new TextEditingController();
  final TextEditingController _nombreController = new TextEditingController();
  final TextEditingController _razonsocialController = new TextEditingController();
  final TextEditingController _direccionController =  new TextEditingController();
  final TextEditingController _nointController =  new TextEditingController();
  final TextEditingController _noextController =  new TextEditingController();
  final TextEditingController _coloniaController = new TextEditingController();
  final TextEditingController _ciudadController = new TextEditingController();
  final TextEditingController _municipioController = new TextEditingController();
  final TextEditingController _codigopostController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _telefonoController = new TextEditingController();
  final TextEditingController _rfcController = new TextEditingController();


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
  Future<List<Usocfdi>> fusocfdi;

  Pedido onepedido;
  List<Pedido> lpedidos;
  List<Pedido_detalle> values;
  List<Cliente> lclientes;
  List<Vendedor> lvendedores;
  List<Articulo> larticulos;
  List<Pais> lpaises;
  List<Estado> lestados;
  List<Usocfdi> lusocfdi;

  List<DropdownMenuItem<Cliente>> _dropdownMenuItems;

  String valor = "";
  Item selectedUser;


  Pedido    _currentpedido;
  Cliente  _currentcliente;
  Vendedor _currentvendedor;
  Articulo _currentarticulo;
  Pais _currentpais;
  Estado _currentestado;
  Usocfdi _currentusocfdi;

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

    Cliente cliente = widget.cliente;

    _codigoController.text = cliente.id.toString();
    _nombreController.text = cliente.nombre;
    _razonsocialController.text = cliente.razonsocial;
    _direccionController.text = cliente.direccion;
    _nointController.text = cliente.noint;
    _noextController.text = cliente.noext;
    _coloniaController.text = cliente.colonia;
    _codigopostController.text = cliente.codigopost;
    _emailController.text = cliente.email;
    _ciudadController.text = cliente.ciudad;
    _municipioController.text = cliente.municipio;
    _telefonoController.text = cliente.telefono;
    _rfcController.text = cliente.rfc;

    fpaises   = service.getListaPaises();
    lpaises   = await fpaises;
    var it0 = lpaises.iterator;
    Pais vpais ;
    while (it0.moveNext()) {
      vpais = it0.current;
      if(vpais.id==cliente.pais_id){
        _currentpais=vpais;
        break;
      }
    }


    festados   = service.getListaEstados();
    lestados   = await festados;
    var it1 = lestados.iterator;
    Estado vestado ;
    while (it1.moveNext()) {
      vestado = it1.current;
      if(vestado.id==cliente.estado_id){
        _currentestado=vestado;
        break;
      }
    }


    fusocfdi   = service.getListaUsocfdi();
    lusocfdi   = await fusocfdi;
    var it2 = lusocfdi.iterator;
    Usocfdi vusocfdi ;
    while (it2.moveNext()) {
      vusocfdi = it2.current;
      if(vusocfdi.id==cliente.usocfdi_id){
        _currentusocfdi=vusocfdi;
        break;
      }
    }



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
                                      controller: _codigoController,
                                      obscureText: false,
                                      decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                        labelText: "Codigo del Cliente",
                                      ),
                                    ),
                                  ),
//                            ),



                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextFormField(
                                      controller: _razonsocialController,
                                      obscureText: false,
                                      decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                        labelText: "Razon Social del Cliente",
                                      ),
                                    ),
                                  ),


                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: _nombreController,
                                    obscureText: false,
                                    decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                      labelText: "Nombre del Cliente",
                                    ),
                                  ),
                                ),




                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: _direccionController,
                                    obscureText: false,
                                    decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                      labelText: "Direccion del Cliente",
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: _nointController,
                                    obscureText: false,
                                    decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                      labelText: "No. Int. del Cliente",
                                    ),
                                  ),
                                ),



                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: _noextController,
                                    obscureText: false,
                                    decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                      labelText: "No. Ext. del Cliente",
                                    ),
                                  ),
                                ),



                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: _coloniaController,
                                    obscureText: false,
                                    decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                      labelText: "Colonia del Cliente",
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: _ciudadController,
                                    obscureText: false,
                                    decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                      labelText: "Ciudad del Cliente",
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
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[


                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _municipioController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Municipio del Cliente",
                                        ),
                                      ),
                                    ),


                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _codigopostController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Codigo Postal del Cliente",
                                        ),
                                      ),
                                    ),





                                    Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: DropdownButtonFormField<Pais>(
                                          decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                            labelText: "Paises",
                                          ),
                                          isExpanded: true,
                                          value: _currentpais,
                                          icon: Icon(Icons.check_circle_outline),
                                          hint: Text("Choose"),
                                          items: lpaises
                                              .map((items) => DropdownMenuItem<Pais>(
                                            child: Text(items.nombre),
                                            value: items,
                                          ))
                                              .toList(),
                                          onChanged: (Pais newValue) {
                                            setState(() =>
                                            this._currentpais = newValue
                                            );
                                          },
                                        )
                                    ),




                                    Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: DropdownButtonFormField<Estado>(
                                          decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                            labelText: "Estados",
                                          ),
                                          isExpanded: true,
                                          value: _currentestado,
                                          icon: Icon(Icons.check_circle_outline),
                                          hint: Text("Choose"),
                                          items: lestados
                                              .map((items) => DropdownMenuItem<Estado>(
                                            child: Text(items.nombre),
                                            value: items,
                                          ))
                                              .toList(),
                                          onChanged: (Estado newValue) {
                                            setState(() =>
                                            this._currentestado = newValue
                                            );
                                          },
                                        )
                                    ),




                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _emailController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Email del Cliente",
                                        ),
                                      ),
                                    ),



//                            new Flexible(
//                              child:
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _telefonoController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Telefono del Cliente",
                                        ),
                                      ),
                                    ),
//                            ),


//                            new Flexible(
//                              child:
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: _rfcController,
                                        obscureText: false,
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Rfc del Cliente",
                                        ),
                                      ),
                                    ),
//                            ),


                                    Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: DropdownButtonFormField<Usocfdi>(
                                          decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                            labelText: "Uso Cfdi",
                                          ),
                                          isExpanded: true,
                                          value: _currentusocfdi,
                                          icon: Icon(Icons.check_circle_outline),
                                          hint: Text("Choose"),
                                          items: lusocfdi
                                              .map((items) => DropdownMenuItem<Usocfdi>(
                                            child: Text(items.descripcion),
                                            value: items,
                                          ))
                                              .toList(),
                                          onChanged: (Usocfdi newValue) {
                                            setState(() =>
                                            this._currentusocfdi = newValue
                                            );
                                          },
                                        )
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
                    Icons.attach_money
                ),
                onPressed: () {
                  gotoPrecios();
                },
                heroTag: null,
              ),

              FloatingActionButton(
                child: Icon(
                    Icons.arrow_back
                ),
                onPressed: () {
                  gotoListaClientes();
                },
                heroTag: null,
              ),



              FloatingActionButton(
                child: Icon(
                    Icons.save
                ),
                onPressed: () {
                     saveRecord();
                     gotoListaClientes();
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

  gotoListaClientes(){

    //Navigator.pushNamedAndRemoveUntil(context,'listaclientes', (Route<dynamic> route) => false);
    Navigator.pushNamed(context, 'listaclientes');

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



  Future<void> actionButtonRaised() {

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ListaClientes(),
    //   ),
    // );

    Navigator.pushNamed(context, 'listaclientes');

  }


  Future<void> actionButtonRaisedPrecios() {


    Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => FormClientePrecios(cliente: widget.cliente)),
            (Route<dynamic> route) => false);


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

      Cliente cliente = new Cliente();
      cliente.id = int.parse( _codigoController.text);
      cliente.razonsocial= _razonsocialController.text;
      cliente.nombre= _nombreController.text;
      cliente.direccion = _direccionController.text;
      cliente.noint = _nointController.text;
      cliente.noext = _noextController.text;
      cliente.colonia = _coloniaController.text;
      cliente.ciudad = _ciudadController.text;
      cliente.municipio = _municipioController.text;
      cliente.codigopost = _codigopostController.text;
      cliente.pais_id = _currentpais.id;
      cliente.estado_id = _currentestado.id;
      cliente.usocfdi_id = _currentusocfdi.id;
      cliente.email = _emailController.text;
      cliente.telefono = _telefonoController.text;
      cliente.rfc = _rfcController.text;

      await service.salvaOneClientes(cliente);
      // actionButtonRaised();

  }


  gotoPrecios(){
      actionButtonRaisedPrecios();
  }



}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

