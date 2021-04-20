

import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Vistas/ListaArticulos.dart';
import 'package:jessmarwindesk/Vistas/ListaPedidos.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ListaClientes.dart';
import 'ListaHieleras.dart';
import 'ListaVendedores.dart';
import 'PedidosIntro.dart';

class MenuPrincipal extends StatefulWidget {
  MenuPrincipal({Key key}) : super(key: key);
  _MenuPrincipalState createState() => _MenuPrincipalState();
}


class _MenuPrincipalState extends State<MenuPrincipal> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Menu Principal"),
        ),
        body:

        Center(
          child:

          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.50,
              padding: EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 22.0,
                mainAxisSpacing: 8.0,
                children: <Widget>[

                  Container(
                    //margin: EdgeInsets.symmetric(vertical:10.0),
                      color: Colors.blueGrey,
                      //height: 244,
                      child: InkWell(
                          child: Container(
                            width: 120.0,
                            child: Card(
                              child: Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Center(child: Image.asset("images/pedidos.jpg",height: 120, width:   120 )),
                                  ),
                                  ListTile(
                                    title:
                                    new Row(children: <Widget>[
                                      new Text("PEDIDOS",
                                        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),)
                                    ], mainAxisAlignment: MainAxisAlignment.center,),
                                    // subtitle: new Row(children: <Widget>[
                                    //   new Text("Centered Title#",
                                    //     style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0),)
                                    // ], mainAxisAlignment: MainAxisAlignment.center,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                                actionButtonRaised();
                          }
                      )
                  ),


                  Container(
                    //margin: EdgeInsets.symmetric(vertical:10.0),
                      color: Colors.blueGrey,
                      //height: 244,
                      child: InkWell(
                          child: Container(
                            width: 120.0,
                            child: Card(
                              child: Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Center(child: Image.asset("images/notaventa.png",height: 120, width:   120 )),
                                  ),
                                  ListTile(
                                    title:
                                    new Row(children: <Widget>[
                                      new Text("REMISIONES",
                                        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),)
                                    ], mainAxisAlignment: MainAxisAlignment.center,),
                                    // subtitle: new Row(children: <Widget>[
                                    //   new Text("Centered Title#",
                                    //     style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0),)
                                    // ], mainAxisAlignment: MainAxisAlignment.center,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                            //actionButtonRaised();
                          }
                      )
                  ),


                  Container(
                    //margin: EdgeInsets.symmetric(vertical:10.0),
                      color: Colors.blueGrey,
                      //height: 244,
                      child: InkWell(
                          child: Container(
                            width: 120.0,
                            child: Card(
                              child: Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Center(child: Image.asset("images/factura.jpg",height: 120, width:   120 )),
                                  ),
                                  ListTile(
                                    title:
                                    new Row(children: <Widget>[
                                      new Text("FACTURAS",
                                        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),)
                                    ], mainAxisAlignment: MainAxisAlignment.center,),
                                    // subtitle: new Row(children: <Widget>[
                                    //   new Text("Centered Title#",
                                    //     style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0),)
                                    // ], mainAxisAlignment: MainAxisAlignment.center,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                            //actionButtonRaised();
                          }
                      )
                  ),



                  Container(
                    //margin: EdgeInsets.symmetric(vertical:10.0),
                      color: Colors.blueGrey,
                      //height: 244,
                      child: InkWell(
                          child: Container(
                            width: 120.0,
                            child: Card(
                              child: Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Center(child: Image.asset("images/informes.jpg",height: 120, width:   120 )),
                                  ),
                                  ListTile(
                                    title:
                                    new Row(children: <Widget>[
                                      new Text("INFORMES",
                                        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),)
                                    ], mainAxisAlignment: MainAxisAlignment.center,),
                                    // subtitle: new Row(children: <Widget>[
                                    //   new Text("Centered Title#",
                                    //     style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0),)
                                    // ], mainAxisAlignment: MainAxisAlignment.center,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () async {

                            final SharedPreferences prefs = await _prefs;
                            prefs.setString("filtros", "Abiertos");
                            actionButtonInformes();

                          }
                      )
                  ),


                  Container(
                    //margin: EdgeInsets.symmetric(vertical:10.0),
                      color: Colors.blueGrey,
                      //height: 244,
                      child: InkWell(
                          child: Container(
                            width: 120.0,
                            child: Card(
                              child: Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Center(child: Image.asset("images/productos.jpg",height: 120, width:   120 )),
                                  ),
                                  ListTile(
                                    title:
                                    new Row(children: <Widget>[
                                      new Text("PRODUCTOS",
                                        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),)
                                    ], mainAxisAlignment: MainAxisAlignment.center,),
                                    // subtitle: new Row(children: <Widget>[
                                    //   new Text("Centered Title#",
                                    //     style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0),)
                                    // ], mainAxisAlignment: MainAxisAlignment.center,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                            actionButtonArticulos();
                          }
                      )
                  ),


                  Container(
                    //margin: EdgeInsets.symmetric(vertical:10.0),
                      color: Colors.blueGrey,
                      //height: 244,
                      child: InkWell(
                          child: Container(
                            width: 120.0,
                            child: Card(
                              child: Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Center(child: Image.asset("images/clientes.png",height: 120, width:   120 )),
                                  ),
                                  ListTile(
                                    title:
                                    new Row(children: <Widget>[
                                      new Text("CLIENTES",
                                        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),)
                                    ], mainAxisAlignment: MainAxisAlignment.center,),
                                    // subtitle: new Row(children: <Widget>[
                                    //   new Text("Centered Title#",
                                    //     style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0),)
                                    // ], mainAxisAlignment: MainAxisAlignment.center,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                            actionButtonClientes();
                          }
                      )
                  ),

                  Container(
                    //margin: EdgeInsets.symmetric(vertical:10.0),
                      color: Colors.blueGrey,
                      //height: 244,
                      child: InkWell(
                          child: Container(
                            width: 120.0,
                            child: Card(
                              child: Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Center(child: Image.asset("images/vendedores.png",height: 120, width:   120 )),
                                  ),
                                  ListTile(
                                    title:
                                    new Row(children: <Widget>[
                                      new Text("VENDEDORES",
                                        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),)
                                    ], mainAxisAlignment: MainAxisAlignment.center,),
                                    // subtitle: new Row(children: <Widget>[
                                    //   new Text("Centered Title#",
                                    //     style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0),)
                                    // ], mainAxisAlignment: MainAxisAlignment.center,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                            actionButtonVendedores();
                          }
                      )
                  ),



                  Container(
                    //margin: EdgeInsets.symmetric(vertical:10.0),
                      color: Colors.blueGrey,
                      //height: 244,
                      child: InkWell(
                          child: Container(
                            width: 120.0,
                            child: Card(
                              child: Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Center(child: Image.asset("images/hielera.jpg",height: 120, width:   120 )),
                                  ),
                                  ListTile(
                                    title:
                                    new Row(children: <Widget>[
                                      new Text("NEVERAS",
                                        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),)
                                    ], mainAxisAlignment: MainAxisAlignment.center,),
                                    // subtitle: new Row(children: <Widget>[
                                    //   new Text("Centered Title#",
                                    //     style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0),)
                                    // ], mainAxisAlignment: MainAxisAlignment.center,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                            actionButtonHieleras();
                          }
                      )
                  ),



    ],
              ),
            ),
          ),
        )


    );

  }


  Future<void> actionButtonRaised() async {

    Navigator.pushNamed(context, 'listapedidos');



  }

    Future<void> actionButtonArticulos() async {

      Navigator.pushNamed(context, 'listaarticulos');

  }

  Future<void> actionButtonClientes() async {

    Navigator.pushNamed(context, 'listaclientes');


  }

  Future<void> actionButtonInformes() async {

    Navigator.pushNamed(context, 'forminformes');


  }

  Future<void> actionButtonVendedores() async {

    Navigator.pushNamed(context, 'listavendedores');


  }

  Future<void> actionButtonHieleras() async {

    Navigator.pushNamed(context, 'listahieleras');



  }

}
