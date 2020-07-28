

import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Vistas/ListaPedidos.dart';

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
              crossAxisCount: 3,
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
                  child: Image.network("https://placeimg.com/500/500/any"),
                  color: Theme.of(context).backgroundColor,
                  elevation: 0.0,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    // Perform some action
                  },
                ),
                RaisedButton(
                  child: Image.asset("images/informes.jpg"),
                  color: Theme.of(context).backgroundColor,
                  elevation: 0.0,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    // Perform some action
                  },
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






}
