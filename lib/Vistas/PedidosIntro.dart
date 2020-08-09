

import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:nice_button/NiceButton.dart';

import '../navDrawer.dart';
import 'PedidosManto.dart';

class PedidosIntro extends StatefulWidget {
  Pedido_detalle detalle;
  PedidosIntro({Key key, @required this.detalle }) : super(key: key);
  _PedidosIntroState createState() => _PedidosIntroState();
}


class _PedidosIntroState extends State<PedidosIntro> {

  final TextEditingController _cantidadController = new TextEditingController();
  final TextEditingController _precioController = new TextEditingController();


  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);


  @override
  void initState() {
    super.initState();
    _getData();
  }

   void _getData() {

    Pedido_detalle _detalle = widget.detalle;
    _cantidadController.text = _detalle.cantidad.toString();
    _precioController.text = _detalle.precio.toString();

  }



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
                  //color: Colors.deepOrange,
                  child:
                    Column(
                    children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        //controller: _numberpedidoController,
                        obscureText: false,
                        decoration: InputDecoration(
//                                    prefixIcon: Icon(Icons.lock),
                          labelText: "Seleccione el Articulo",
                        ),
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


                      NiceButton(
                        width: 255,
                        elevation: 8.0,
                        radius: 52.0,
                        text: "Aceptar",
                        background: firstColor,
                        onPressed: () {
                         actionButtonRaised();
                        },
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

  Future<void> actionButtonRaised() async {

    JessmarService service = JessmarService();
    Pedido pedido = await service.getOnePedido("1");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context)  => PedidosManto( pedido: pedido ),
      ),
    );
  }


}
