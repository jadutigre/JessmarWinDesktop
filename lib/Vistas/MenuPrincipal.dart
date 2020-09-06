

import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Vistas/ListaArticulos.dart';
import 'package:jessmarwindesk/Vistas/ListaPedidos.dart';

import 'ListaClientes.dart';
import 'ListaHieleras.dart';
import 'ListaVendedores.dart';
import 'PedidosIntro.dart';

class MenuPrincipal extends StatefulWidget {
  MenuPrincipal({Key key}) : super(key: key);
  _MenuPrincipalState createState() => _MenuPrincipalState();
}


class _MenuPrincipalState extends State<MenuPrincipal> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Menu Principal"),
        ),
        body:

        Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.50,
            padding: EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 22.0,
              mainAxisSpacing: 8.0,
              children: <Widget>[
                  RaisedButton(
                  child: Image.asset("images/pedidos.jpg"),
                  color: Theme.of(context).backgroundColor,
                  elevation: 0.0,
                  splashColor: Colors.blueGrey,
                  onPressed: actionButtonRaised,
                ),
                RaisedButton(
                  child: Image.asset("images/notaventa.png"),
                  color: Theme.of(context).backgroundColor,
                  elevation: 0.0,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    // Perform some action
                  },
                ),
                RaisedButton(
                  child: Image.asset("images/factura.jpg"),
                  color: Theme.of(context).backgroundColor,
                  elevation: 0.0,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    // Perform some action
                  },
                ),
                RaisedButton(
                  child: Image.asset("images/inventarios.jpg"),
                  color: Theme.of(context).backgroundColor,
                  elevation: 0.0,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    // Perform some action
                  },
                ),
                RaisedButton(
                  child: Image.asset("images/productos.jpg"),
                  color: Theme.of(context).backgroundColor,
                  elevation: 0.0,
                  splashColor: Colors.blueGrey,
                  onPressed: actionButtonArticulos,
                ),


                RaisedButton(
                  child: Image.asset("images/clientes.png"),
                  color: Theme.of(context).backgroundColor,
                  elevation: 0.0,
                  splashColor: Colors.blueGrey,
                  onPressed: actionButtonClientes,
                ),

                RaisedButton(
                  child:  Image.asset("images/vendedores.png"),
                  color: Theme.of(context).backgroundColor,
                  elevation: 0.0,
                  splashColor: Colors.blueGrey,
                  onPressed: actionButtonVendedores,
                ),


                RaisedButton(
                  child: Image.asset("images/hielera.jpg"),
                  color: Theme.of(context).backgroundColor,
                  elevation: 0.0,
                  splashColor: Colors.blueGrey,
                  onPressed: actionButtonHieleras,
                ),




                  ],
            ),
          ),
        )


    );

  }


  Future<void> actionButtonRaised() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListaPedidos(),
      ),
    );
  }

    Future<void> actionButtonArticulos() async {

//      Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) => ListaArticulos(),
//        ),
//      );

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) =>  ListaArticulos()),
              (Route<dynamic> route) => false
      );


  }

  Future<void> actionButtonClientes() async {

//    Navigator.push(
////      context,
////      MaterialPageRoute(
////        builder: (context) => ListaClientes(),
////      ),
////    );


    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) =>  ListaClientes()),
            (Route<dynamic> route) => false
    );

  }

  Future<void> actionButtonVendedores() async {



    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) =>  ListaVendedores()),
            (Route<dynamic> route) => false
    );

  }

  Future<void> actionButtonHieleras() async {



    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) =>  ListaHieleras()),
            (Route<dynamic> route) => false
    );

  }

}
