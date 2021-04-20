import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jessmarwindesk/Domains/Articulos.dart';
import 'package:jessmarwindesk/Domains/articulo.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/hielera.dart';
import 'package:jessmarwindesk/Domains/hieleras.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Domains/pedidos.dart';
import 'package:jessmarwindesk/Domains/pedidos_detalles.dart';
import 'package:jessmarwindesk/Domains/precio.dart';
import 'package:jessmarwindesk/Domains/precios.dart';
import 'package:jessmarwindesk/Domains/vendedor.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Tools/PdfPrevio.dart';
import 'package:jessmarwindesk/Vistas/PedidosIntro.dart';
import 'package:color_panel/color_panel.dart';
import 'package:jessmarwindesk/Vistas/Testautocomplete.dart';
import 'package:pdf/pdf.dart';
import 'dart:io' show Platform;
import 'package:pdf/widgets.dart' as pw;


import 'package:nice_button/NiceButton.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

import 'ListaPedidos.dart';

class PedidosManto extends StatefulWidget {
  PedidosManto({Key key}) : super(key: key);

  _PedidosMantoState createState() => _PedidosMantoState();
}


class _PedidosMantoState extends State<PedidosManto> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _isVisible = false;

  bool _isVisibleClosePedido = false;

  void showToast() {
    setState(() {
      _isVisible = true;
    });
  }

  void hideToast() {
    setState(() {
      _isVisible = false;
    });
  }


  void showClosePedido() {
    setState(() {
      _isVisibleClosePedido = true;
    });
  }

  void hideClosePedido() {
    setState(() {
      _isVisibleClosePedido = false;
    });
  }


  void setPrice(Precio value) {
    setState(() {
      this._currentprecio = value;
      _cantidadController.text = '1';
      _precioController.text = this._currentprecio.precio.toString();
    });
  }

  JessmarService service = JessmarService();

  final TextEditingController _numberpedidoController = new TextEditingController();
  final TextEditingController _areaEntregaController = new TextEditingController();

  /*Controller de Detalle*/
  final TextEditingController _idDetalleController = new TextEditingController();
  final TextEditingController _articuloController = new TextEditingController();
  final TextEditingController _cantidadController = new TextEditingController();
  final TextEditingController _precioController = new TextEditingController();

  final TextEditingController dateCtl = TextEditingController();

  var firstColor = Color(0xff5b86e5),
      secondColor = Color(0xff36d1dc);

  DateTime date;

  Future<Pedido> fpedido;
  Future<List<Pedido>> fpedidos;
  Future<List<Cliente>> fclientes;
  Future<List<Vendedor>> fvendedores;
  Future<List<Articulo>> farticulos;
  Future<List<Hielera>> fhieleras;

  Pedido onepedido;
  List<Pedido> lpedidos;
  List<Pedido_detalle> values;
  List<Cliente> lclientes;
  List<Vendedor> lvendedores;
  List<Articulo> larticulos;
  List<Hielera> lhieleras;

  Future<List<Precio>> fprecios;
  List<Precio> lprecios;

  List<DropdownMenuItem<Cliente>> _dropdownMenuItems;

  String valor = "";
  Item selectedUser;
  double eltotal;

  Pedido pedido;

//  List<Item> users = <Item>[
//    const Item('Android',Icon(Icons.android,color:  const Color(0xFF167F67),)),
//    const Item('Flutter',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
//    const Item('ReactNative',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
//    const Item('iOS',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
//  ];

  Pedido _currentpedido;
  Cliente _currentcliente;
  Vendedor _currentvendedor;
  Hielera _currenthielera;

  //Articulo _currentarticulo;
  Precio _currentprecio;

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

    // final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    // if (arguments != null){
    //   pedido =   arguments['pedido'];
    //   print(pedido);
    // }

    final SharedPreferences prefs = await _prefs;
    var pedidoid =prefs.getInt("pedidoid");

    print("Servicio  _getData");
    print(pedido);

    if (pedidoid == 0) {
        newPedido();
        onepedido = pedido;
    } else {
        onepedido = await service.getOnePedido(pedidoid.toString());
        var values = onepedido.pedidosdetalle;
        var itvalues = values.iterator;
        eltotal = 0.0;
        while(itvalues.moveNext()){
          Pedido_detalle eldetalle =  itvalues.current;
          eltotal = eltotal + eldetalle.total;
        }
    }

    _numberpedidoController.value =
        _numberpedidoController.value.copyWith(text: onepedido.id.toString(),);
    _areaEntregaController.text = onepedido.areaentrega;


    _selectedDate = onepedido.fechapedido;
    dateCtl.text = onepedido.fechapedido;

    //lpedidos = await service.getListaPedidos();

    fclientes = service.getListaClientes();
    lclientes = await fclientes;
    var it0 = lclientes.iterator;
    Cliente vcliente;
    while (it0.moveNext()) {
      vcliente = it0.current;
      if (vcliente.id == onepedido.clientes_id) {
        _currentcliente = vcliente;
        break;
      }
    }


    fvendedores = service.getListaVendedores();
    lvendedores = await fvendedores;
    var it1 = lvendedores.iterator;
    Vendedor vvendedor;
    while (it1.moveNext()) {
      vvendedor = it1.current;
      if (vvendedor.id == onepedido.vendedor_id) {
        _currentvendedor = vvendedor;
        break;
      }
    }

    fhieleras = service.getListaHieleras();
    lhieleras = await fhieleras;
    var it2 = lhieleras.iterator;
    Hielera vhielera;
    while (it2.moveNext()) {
      vhielera = it2.current;
      // if(vhielera.id==onepedido.hielera_id){
      //   _currenthielera=vhielera;
      //   break;
      // }
    }

    fprecios = service.getListaPreciosByIdCliente(this._currentcliente.id.toString());
    lprecios = await fprecios;
    _currentprecio = lprecios[0];
    _cantidadController.text = "1";
    _precioController.text = _currentprecio.precio.toString();

    Map<String, dynamic> datos = new Map();

    datos["onepedido"] = onepedido;

    datos["lpedidos"] = lpedidos;
    datos["fclientes"] = fclientes;
    datos["lclientes"] = lclientes;
    datos["fvendedores"] = fvendedores;

    return datos;
  }

  newPedido(){
    pedido.id=0;
    pedido.fechapedido= DateTime.now().toString();
    pedido.clientes_id = 1;
    pedido.vendedor_id = 1;
    pedido.tipopedido_id = 1;
    pedido.pedidosdetalle = List<Pedido_detalle>();
    pedido.usuario = "";
    pedido.areaentrega="";
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
                                child:

                                new FutureBuilder(
                                    future: fclientes,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Cliente>> snapshot) {
                                      if (!snapshot.hasData)
                                        return CircularProgressIndicator();
                                      return

                                        DropdownButtonFormField<Cliente>(
                                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                          labelText: "Cliente",
                                        ),
                                        isExpanded: true,
                                        value: _currentcliente,
                                        icon: Icon(Icons.check_circle_outline),
                                        hint: Text("Choose"),
                                        items: snapshot.data
                                            .map((items) =>
                                            DropdownMenuItem<Cliente>(
                                              child: Text(items.nombre),
                                              value: items,
                                            ))
                                            .toList(),
                                        onChanged: (Cliente newValue) async {
                                          setState(() =>
                                          {
                                            this._currentcliente = newValue
                                          }
                                          );
                                          fprecios = service.getListaPreciosByIdCliente(this._currentcliente.id.toString());
                                          lprecios = await fprecios;
                                          _currentprecio = lprecios[0];
                                          _cantidadController.text = '1';
                                          _precioController.text =
                                              this._currentprecio.precio
                                                  .toString();
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
                                  onTap: () async {
                                    date = DateTime(1900);
                                    FocusScope.of(context).requestFocus(
                                        new FocusNode());

                                    date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100));

                                    dateCtl.text = date.toIso8601String();
                                  },
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
                                    builder: (BuildContext context,
                                        AsyncSnapshot<
                                            List<Vendedor>> snapshot) {
                                      if (!snapshot.hasData)
                                        return CircularProgressIndicator();
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
                                            .map((items) =>
                                            DropdownMenuItem<Vendedor>(
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


                                // Expanded(
                                //   flex: 1,
                                //   child: Container(
                                //     constraints: BoxConstraints.expand(
                                //       height: 500,
                                //       width: 50
                                //     ),
                                //     padding: const EdgeInsets.all(8.0),
                                //     color: Colors.blue,
                                //     alignment: Alignment.topLeft,
                                //     child:
                                //
                                //     Column(
                                //       children: <Widget>[
                                //       ],
                                //     ),
                                //   ),
                                // ),


                                Expanded(
                                  flex: 4,
                                  child: Container(
                                      constraints: BoxConstraints.expand(
                                        height: 500,
                                      ),
                                      padding: const EdgeInsets.only(left:12.0,top:8.0,right: 12.0,bottom: 8.0),
                                      color: Colors.white,
                                      alignment: Alignment.topLeft,
                                      child:
                                      SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[

                                            createDataTable(context, snapshot),
                                            Divider(
                                              color: Colors.black,
                                            ),
                                            Row(

                                              children: <Widget>[

                                                Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                    children: [
                                                      Text(
                                                        '  ',
                                                        textAlign: TextAlign.center,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      ) ,
                                                    ])),


                                                Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                    children: [
                                                      Text(
                                                        '  ',
                                                        textAlign: TextAlign.center,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      ) ,
                                                    ])),



                                                Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                        children: [

                                                            Row(

                                                            mainAxisAlignment: MainAxisAlignment.start,

                                                            children: <Widget>[
                                                              Text(
                                                                'Total : ',
                                                                textAlign: TextAlign.center,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ) ,
                                                              Text(
                                                                eltotal.toString(),
                                                                textAlign: TextAlign.center,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              )
                                                            ])

                                                    ])),



                                                ]
                                            ),

                                          ],
                                    //                      transform: Matrix4.rotationZ(0.1),
                                  )
                                      ),
                                 )
                                ),



                                /* Cierre de Pedido */


                                Visibility(
                                  visible: _isVisible,
                                  child: Expanded(
                                    flex: 2,
                                    child: Container(
                                      constraints: BoxConstraints.expand(
                                        height: 500,
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      color: Colors.white,
                                      alignment: Alignment.topLeft,
                                      child:

                                      Column(
                                        children: <Widget>[

                                          // NiceButton(
                                          //
                                          //   width: 30.0,
                                          //   mini: true,
                                          //   icon: Icons.add,
                                          //   background: firstColor,
                                          //   onPressed: () {
                                          //     newRecord();
                                          //   },
                                          // ),


                                          Visibility(
                                            visible: false,
                                            child: TextFormField(
                                              controller: _cantidadController,
                                              obscureText: false,
                                              decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                                                labelText: "Teclee la cantidad",
                                              ),
                                            ),
                                          ),


//                       new Flexible(
//                         child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: new FutureBuilder(
//                               future: fprecios,
//                               builder: (BuildContext context,AsyncSnapshot<List<Precio>> snapshot) {
//                                 if (!snapshot.hasData) return CircularProgressIndicator();
//                                 return DropdownButtonFormField<Precio>(
//                                   decoration: InputDecoration(
// //                                    prefixIcon: Icon(Icons.lock),
//                                     labelText: "Seleccione el Producto",
//                                   ),
//                                   isExpanded: true,
//                                   value: _currentprecio,
//                                   icon: Icon(Icons.check_circle_outline),
//                                   hint: Text("Choose"),
//                                   items: snapshot.data
//                                       .map((items) => DropdownMenuItem<Precio>(
//                                     child: Text(items.descripcion),
//                                     value: items,
//                                   ))
//                                       .toList(),
//                                   onChanged: (Precio newValue) {
//                                       setState(() =>
//                                         this._currentprecio = newValue
//                                       );
//                                       _cantidadController.text = '1';
//                                       _precioController.text = this._currentprecio.precio.toString();
//                                   },
//                                 );
//                               }),
//                         ),
//                       ),


                                          SimpleAutocompleteFormField<Precio>(

                                            decoration: InputDecoration(
                                                labelText: 'Precio',
                                                border: OutlineInputBorder()),
                                            suggestionsHeight: 80.0,
                                            itemBuilder: (context, precio) =>
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(precio.descripcion,
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold)),
                                                        // Text(person.address)
                                                      ]
                                                  ),
                                                ),
                                            maxSuggestions: 6,
                                            onSearch: (search) async =>
                                                lprecios
                                                    .where((precio) =>
                                                    precio.descripcion
                                                        .toLowerCase()
                                                        .contains(
                                                        search.toLowerCase())
                                                  // ||
                                                  // precio.address
                                                  //     .toLowerCase()
                                                  //     .contains(search.toLowerCase())
                                                )
                                                    .toList(),
                                            itemFromString: (string) =>
                                                lprecios.singleWhere(
                                                        (precio) =>
                                                    precio.descripcion
                                                        .toLowerCase() ==
                                                        string.toLowerCase(),
                                                    orElse: () => null
                                                ),
                                            onChanged: (value) =>
                                                setPrice(value),
                                            onSaved: (value) => setPrice(value),
                                            validator: (precio) =>
                                            precio == null
                                                ? 'Invalid person.'
                                                : null,
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

                                          Row(
                                              children: <Widget>[

                                                NiceButton(
                                                  fontSize: 10,
                                                  width: 100,
                                                  elevation: 8.0,
                                                  radius: 45.0,
                                                  text: "Aceptar",
                                                  background: firstColor,
                                                  onPressed: () {
                                                    hideToast();
                                                    addRecord();
                                                  },
                                                ),

                                                NiceButton(
                                                  fontSize: 10,
                                                  width: 100,
                                                  elevation: 8.0,
                                                  radius: 45.0,
                                                  text: "Cancelar",
                                                  background: firstColor,
                                                  onPressed: () {
                                                    hideToast();
                                                  },
                                                ),

                                              ])


                                        ],
                                      ),

                                      //                      transform: Matrix4.rotationZ(0.1),
                                    ),
                                  ),
                                ),


                                Visibility(
                                  visible: _isVisibleClosePedido,
                                  child: Expanded(
                                    flex: 2,
                                    child: Container(
                                      constraints: BoxConstraints.expand(
                                        height: 500,
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      color: Colors.white,
                                      alignment: Alignment.topLeft,
                                      child:

                                      Column(
                                        children: <Widget>[


                                          new Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  5.0),
                                              child: new FutureBuilder(
                                                  future: fhieleras,
                                                  builder: (
                                                      BuildContext context,
                                                      AsyncSnapshot<List<
                                                          Hielera>> snapshot) {
                                                    if (!snapshot.hasData)
                                                      return CircularProgressIndicator();
                                                    return DropdownButtonFormField<
                                                        Hielera>(
                                                      decoration: InputDecoration(
                                                        //                                    prefixIcon: Icon(Icons.lock),
                                                        labelText: "Hielera",
                                                      ),
                                                      isExpanded: true,
                                                      value: this
                                                          ._currenthielera,
                                                      icon: Icon(Icons
                                                          .check_circle_outline),
                                                      hint: Text("Choose"),
                                                      items: snapshot.data
                                                          .map((items) =>
                                                          DropdownMenuItem<
                                                              Hielera>(
                                                            child: Text(items
                                                                .descripcion),
                                                            value: items,
                                                          ))
                                                          .toList(),
                                                      onChanged: (
                                                          Hielera newValue) {
                                                        setState(() =>
                                                        this._currenthielera =
                                                            newValue
                                                        );
                                                      },
                                                    );
                                                  }),
                                            ),
                                          ),


//                       Visibility(
//                         visible: false,
//                         child:TextFormField(
//                           controller: _cantidadController,
//                           obscureText: false,
//                           decoration: InputDecoration(
// //                                    prefixIcon: Icon(Icons.lock),
//                             labelText: "Teclee la cantidad",
//                           ),
//                         ),
//                       ),


//                       new Flexible(
//                         child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: new FutureBuilder(
//                               future: fprecios,
//                               builder: (BuildContext context,AsyncSnapshot<List<Precio>> snapshot) {
//                                 if (!snapshot.hasData) return CircularProgressIndicator();
//                                 return DropdownButtonFormField<Precio>(
//                                   decoration: InputDecoration(
// //                                    prefixIcon: Icon(Icons.lock),
//                                     labelText: "Seleccione el Producto",
//                                   ),
//                                   isExpanded: true,
//                                   value: _currentprecio,
//                                   icon: Icon(Icons.check_circle_outline),
//                                   hint: Text("Choose"),
//                                   items: snapshot.data
//                                       .map((items) => DropdownMenuItem<Precio>(
//                                     child: Text(items.descripcion),
//                                     value: items,
//                                   ))
//                                       .toList(),
//                                   onChanged: (Precio newValue) {
//                                       setState(() =>
//                                         this._currentprecio = newValue
//                                       );
//                                       _cantidadController.text = '1';
//                                       _precioController.text = this._currentprecio.precio.toString();
//                                   },
//                                 );
//                               }),
//                         ),
//                       ),


                                          // SimpleAutocompleteFormField<Precio>(
                                          //
                                          //   decoration: InputDecoration(
                                          //       labelText: 'Precio', border: OutlineInputBorder()),
                                          //   suggestionsHeight: 80.0,
                                          //   itemBuilder: (context, precio) => Padding(
                                          //     padding: EdgeInsets.all(8.0),
                                          //     child: Column(
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         children: [
                                          //           Text(precio.descripcion,style: TextStyle(fontWeight: FontWeight.bold)),
                                          //           // Text(person.address)
                                          //         ]
                                          //     ),
                                          //   ),
                                          //   maxSuggestions: 6,
                                          //   onSearch: (search) async => lprecios
                                          //       .where((precio) =>
                                          //       precio.descripcion
                                          //           .toLowerCase()
                                          //           .contains(search.toLowerCase())
                                          //     // ||
                                          //     // precio.address
                                          //     //     .toLowerCase()
                                          //     //     .contains(search.toLowerCase())
                                          //   )
                                          //       .toList(),
                                          //   itemFromString: (string) => lprecios.singleWhere(
                                          //           (precio) => precio.descripcion.toLowerCase() == string.toLowerCase(),
                                          //       orElse: () => null
                                          //   ),
                                          //   onChanged: (value) => setPrice(value),
                                          //   onSaved: (value) => setPrice(value),
                                          //   validator: (precio) => precio == null ? 'Invalid person.' : null,
                                          // ),


//                       Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: TextFormField(
//                           controller: _cantidadController,
//                           obscureText: false,
//                           decoration: InputDecoration(
// //                                    prefixIcon: Icon(Icons.lock),
//                             labelText: "Teclee la cantidad",
//                           ),
//                         ),
//                       ),


//                       Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: TextFormField(
//                           controller: _precioController,
//                           obscureText: false,
//                           decoration: InputDecoration(
// //                                    prefixIcon: Icon(Icons.lock),
//                             labelText: "Teclee el precio",
//                           ),
//                         ),
//                       ),

                                          SizedBox(
                                            height: 15.0,
                                          ),

                                          Row(
                                              children: <Widget>[

                                                NiceButton(
                                                  fontSize: 10,
                                                  width: 100,
                                                  elevation: 8.0,
                                                  radius: 45.0,
                                                  text: "Aceptar",
                                                  background: firstColor,
                                                  onPressed: () async {


                                                        //hideClosePedido();
                                                        Pedido elpedido = await cierraPedido();

                                                        Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => PdfPrevio(pedido : elpedido),
                                                          ),
                                                        );


                                                  },
                                                ),

                                                NiceButton(
                                                  fontSize: 10,
                                                  width: 100,
                                                  elevation: 8.0,
                                                  radius: 45.0,
                                                  text: "Cancelar",
                                                  background: firstColor,
                                                  onPressed: () {
                                                    hideClosePedido();
                                                  },
                                                ),

                                              ])


                                        ],
                                      ),

                                      //                      transform: Matrix4.rotationZ(0.1),
                                    ),
                                  ),
                                ),


                                // Expanded(
                                // flex: 1,
                                // child: Container(
                                // constraints: BoxConstraints.expand(
                                // height:  500 ,
                                // ),
                                // padding: const EdgeInsets.all(8.0),
                                // color: Colors.white,
                                // alignment: Alignment.topLeft,
                                // child:
                                //
                                // Column(
                                // children: <Widget>[
                                //
                                // ],
                                // ),
                                // ),
                                // ),


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

              FloatingActionButton(

                child: Icon(
                    Icons.cancel,
                ),
                onPressed: () async {
                  await cancelaPedido();
                  //newRecord();
                  actionButtonRaised();
                },
                heroTag: null,
                tooltip: "Cancelar el Pedido",
              ),

              SizedBox(
                height: 5,
              ),

              FloatingActionButton(

                child: Icon(
                    Icons.send_to_mobile
                ),
                onPressed: () {
                  showClosePedido();
                  //newRecord();
                },
                heroTag: null,
                tooltip: "Cerrar el Pedido",
              ),

              SizedBox(
                height: 10,
              ),

              FloatingActionButton(
                tooltip: "Nuevo Pedido",
                child: Icon(
                    Icons.add
                ),
                onPressed: () {
                  showToast();
                  newRecord();
                },
                heroTag: null,
              ),

              SizedBox(
                height: 10,
              ),



              FloatingActionButton(
                tooltip: "Salvar el Pedido",
                child: Icon(
                    Icons.save
                ),
                onPressed: () async {

                        Pedido elpedido = await saveRecord();
                        actionButtonRaised();

                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PdfPrevio(pedido : elpedido),
                        //   ),
                        // );

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
                    //Navigator.push(context, new MaterialPageRoute(builder: (context) => PedidosIntro( detalle: itemRow)));
                    showToast();
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

    Navigator.pushNamed(context, 'listapedidos');

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ListaPedidos(),
    //   ),
    // );

  }

  newRecord() {
    _idDetalleController.text = "0";
//    _articuloController.text = _detalle.articulodescripcion;
//    _cantidadController.text = _detalle.cantidad.toString();
//    _precioController.text = _detalle.precio.toString();
  }


  editRecord(Pedido_detalle itemRow) {
    var _detalle = itemRow;
    _idDetalleController.text = _detalle.id.toString();
    _articuloController.text = _detalle.articulodescripcion;
    _cantidadController.text = _detalle.cantidad.toString();
    _precioController.text = _detalle.precio.toString();
  }

  _deleteRecord(Pedido_detalle detail) async {
    await service.deletePedidoDetalleById(detail.id.toString());
    values.remove(detail);

    var itvalues = values.iterator;
    eltotal = 0.0;
    while(itvalues.moveNext()){
      Pedido_detalle eldetalle =  itvalues.current;
      eltotal = eltotal + eldetalle.total;
    }

    //values = await service.getListaPedidoDetalleByIdPedido(onepedido.id.toString());

    setState(() {});
    print("registroBorrado");
  }


  Future<Pedido>  cierraPedido() async {

    final SharedPreferences prefs = await _prefs;
    prefs.getInt("usuario_id");
    prefs.getString("usuario_nombre");

    Pedido pedido = new Pedido();
    pedido.id = int.parse(_numberpedidoController.text);
    pedido.tipopedido_id = 1;

    pedido.clientes_id = _currentcliente.id;
    pedido.clientenombre = _currentcliente.nombre;

    pedido.hielera_id = _currenthielera.id;
    pedido.hieleranombre = _currenthielera.descripcion;

    pedido.usrabrio_id = pedido.usrabrio_id;
    pedido.usrcerro_id = prefs.getInt("usuario_id");
    pedido.status = 'cerrado';
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    pedido.fechapedido = f.format(
        new DateFormat("yyyy-MM-dd hh:mm").parse(pedido.fechapedido));
    pedido.fechacierre = f.format(DateTime.now());
    pedido.areaentrega = _areaEntregaController.text;
    pedido.usuario = prefs.getString("usuario_clave");

    pedido.pedidosdetalle = values;
    var itvalues = values.iterator;
    eltotal = 0.0;
    while(itvalues.moveNext()){
            Pedido_detalle eldetalle =  itvalues.current;
            eltotal = eltotal + eldetalle.total;
    }
    pedido.total=eltotal;

    pedido.vendedor_id = _currentvendedor.id;
    pedido.vendedornombre = _currentvendedor.nombre;


    await service.salvaOnePedido(pedido);

    //actionButtonRaised();
    return pedido;

  }


  Future<Pedido>  cancelaPedido() async {

    final SharedPreferences prefs = await _prefs;
    prefs.getInt("usuario_id");
    prefs.getString("usuario_nombre");

    Pedido pedido = new Pedido();
    pedido.id = int.parse(_numberpedidoController.text);
    pedido.tipopedido_id = 1;

    pedido.clientes_id = _currentcliente.id;
    pedido.clientenombre = _currentcliente.nombre;

    // pedido.hielera_id = _currenthielera.id;
    // pedido.hieleranombre = _currenthielera.descripcion;

    pedido.usrabrio_id = pedido.usrabrio_id;
    pedido.usrcancelo_id = prefs.getInt("usuario_id");
    pedido.status = 'cancelado';
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    pedido.fechapedido = f.format(
        new DateFormat("yyyy-MM-dd hh:mm").parse(pedido.fechapedido));
    pedido.fechacancelado = f.format(DateTime.now());
    pedido.areaentrega = _areaEntregaController.text;
    pedido.usuario = prefs.getString("usuario_clave");

    pedido.pedidosdetalle = values;
    var itvalues = values.iterator;
    eltotal = 0.0;
    while(itvalues.moveNext()){
      Pedido_detalle eldetalle =  itvalues.current;
      eltotal = eltotal + eldetalle.total;
    }
    pedido.total=eltotal;

    pedido.vendedor_id = _currentvendedor.id;
    pedido.vendedornombre = _currentvendedor.nombre;


    await service.salvaOnePedido(pedido);

    //actionButtonRaised();
    return pedido;

  }






  // void testReceipt(NetworkPrinter printer) {
  //   printer.text(
  //       'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  //   printer.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
  //       styles: PosStyles(codeTable: 'CP1252'));
  //   printer.text('Special 2: blåbærgrød',
  //       styles: PosStyles(codeTable: 'CP1252'));
  //
  //   printer.text('Bold text', styles: PosStyles(bold: true));
  //   printer.text('Reverse text', styles: PosStyles(reverse: true));
  //   printer.text('Underlined text',
  //       styles: PosStyles(underline: true), linesAfter: 1);
  //   printer.text('Align left', styles: PosStyles(align: PosAlign.left));
  //   printer.text('Align center', styles: PosStyles(align: PosAlign.center));
  //   printer.text('Align right',
  //       styles: PosStyles(align: PosAlign.right), linesAfter: 1);
  //
  //   printer.text('Text size 200%',
  //       styles: PosStyles(
  //         height: PosTextSize.size2,
  //         width: PosTextSize.size2,
  //       ));
  //
  //   printer.feed(2);
  //   printer.cut();
  // }


  addRecord() {
    // int.parse( _idDetalleController.text );

    Pedido_detalle value = new Pedido_detalle();
    value.id = int.parse(_idDetalleController.text);
    value.articulo_id = _currentprecio.articulo_id;
    value.articulodescripcion = _currentprecio.descripcion;
    value.cantidad = double.parse(_cantidadController.text);
    value.precio = double.parse(_precioController.text);
    value.total = value.cantidad * value.precio;
    value.pedido_id = int.parse(_numberpedidoController.text);

    if (value.id == 0) {
      values.add(value);
    } else {
      int index = 0;
      for (Pedido_detalle element in values) {
        if (element.id == int.parse(_idDetalleController.text)) {
          values[index] = value;
          break;
        }
        index = index + 1;
      }
    }

    var itvalues = values.iterator;
    eltotal = 0.0;
    while(itvalues.moveNext()){
      Pedido_detalle eldetalle =  itvalues.current;
      eltotal = eltotal + eldetalle.total;
    }


    setState(() {});

  }


  Future<Pedido> saveRecord() async {

    final SharedPreferences prefs = await _prefs;
    prefs.getInt("usuario_id");
    prefs.getString("usuario_nombre");

    Pedido pedido = new Pedido();
    pedido.id = int.parse(_numberpedidoController.text);
    pedido.tipopedido_id = 1;
    pedido.clientes_id = _currentcliente.id;
    pedido.clientenombre = _currentcliente.nombre;
    pedido.vendedor_id = _currentvendedor.id;

    final f = new DateFormat('yyyy-MM-dd hh:mm');
    pedido.fechapedido = f.format(
        new DateFormat("yyyy-MM-dd hh:mm").parse(onepedido.fechapedido));

    pedido.areaentrega = _areaEntregaController.text;
    pedido.usuario = "jdelgado";
    pedido.pedidosdetalle = values;

    pedido.vendedor_id = _currentvendedor.id;
    pedido.vendedornombre = _currentvendedor.nombre;

    pedido.usrabrio_id = prefs.get("usuario_id");

    await service.salvaOnePedido(pedido);

    return pedido;

  }

  Future<Uint8List> imprimepedido(PdfPageFormat format, Pedido elpedido) async
  {


    final pdf = pw.Document();


    // pdf.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return pw.Center(
    //         child: pw.Text("Hello World"),
    //       ); // Center
    //     })); //

    pdf.addPage(pw.Page(
      //pageFormat: PdfPageFormat.a4,
        pageFormat: PdfPageFormat(8 * PdfPageFormat.cm, 10 * PdfPageFormat.cm, marginAll: 0.5 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Hello World"),
                // _contentTable(context,onepedido)
              ]
          ); // Center
        }));


     return pdf.save();

  }



}




class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

