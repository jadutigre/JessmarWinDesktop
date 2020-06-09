

import 'package:flutter/material.dart';

import '../navDrawer.dart';
import 'ClientesIntro.dart';

class PedidosIntro extends StatefulWidget {
  PedidosIntro({Key key}) : super(key: key);
  _PedidosIntroState createState() => _PedidosIntroState();
}


class _PedidosIntroState extends State<PedidosIntro> {

  @override
  Widget build(BuildContext context) {






    return new Scaffold(
        //drawer: NavDrawer(),
        appBar: new AppBar(
          title: new Text("Pedidos Intro"),
        ),
        body: new SingleChildScrollView(
          child: Container(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                children: <Widget>[


                Container(
                  color: Colors.deepOrange,
                  child:
                    Row(
                    children: [

                      Container(
                        color: Colors.red,
                        child: Column(
                        children: <Widget>[
                          RaisedButton(
                            onPressed: actionButtonRaised,
                            child:Row(
                              children: <Widget>[
                                Text('Continuar'),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),RaisedButton(
                            onPressed: actionButtonRaised,
                            child:Row(
                              children: <Widget>[
                                Text('Continuar'),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),RaisedButton(
                            onPressed: actionButtonRaised,
                            child:Row(
                              children: <Widget>[
                                Text('Continuar'),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                  RaisedButton(
                                onPressed: actionButtonRaised,
                                child:Row(
                                children: <Widget>[
                                Text('Continuar'),
                            Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                          RaisedButton(
                            onPressed: actionButtonRaised,
                            child:Row(
                              children: <Widget>[
                                Text('Continuar'),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),

                         ],
               ),
                      ),

              Container(
                width: 800.0,
                  color: Colors.blue,
                  child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              RaisedButton(
                                onPressed: actionButtonRaised,
                                child:Row(
                                  children: <Widget>[
                                    Text('Continuar'),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ),RaisedButton(
                                onPressed: actionButtonRaised,
                                child:Row(
                                  children: <Widget>[
                                    Text('Continuar'),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ),RaisedButton(
                                onPressed: actionButtonRaised,
                                child:Row(
                                  children: <Widget>[
                                    Text('Continuar'),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                  ),
              ),



                    ],
                  ),
                  ),




              ],
              ),
            ),
          ),
        )
    );
  }

  void actionButtonRaised() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientesIntro(),
      ),
    );
  }


}
