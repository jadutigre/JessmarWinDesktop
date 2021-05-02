import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/precio.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/ListaClientes.dart';

class FormClientePrecios extends StatefulWidget {
  Cliente cliente;
  FormClientePrecios({Key key, @required this.cliente}) : super(key: key);
  _FormClientePreciosState createState() => _FormClientePreciosState();
}



class _FormClientePreciosState extends State<FormClientePrecios> {

  JessmarService service = JessmarService();

  List<TextEditingController> _controllers = new List();
  Future<List<Precio>> fprecios;
  List<Precio> lprecios;


  @override
  void initState() {
    super.initState();
    _getData();
  }


  // int getLengthData()  {
  //      Future<int> listalongitud;
  //      listalongitud = await _getData();
  //     return listalongitud;
  // }


  Future<List<Precio>> _getData() async {
      fprecios   = service.getListaPreciosByIdCliente(widget.cliente.id.toString());
      return fprecios;
  }


  // Map<String, int> quantities = {};
  //
  // void takeNumber(String text, String itemId) {
  //   try {
  //     int number = int.parse(text);
  //     quantities[itemId] = number;
  //     print(quantities);
  //   } on FormatException {}
  // }




  gotoListaClientes(){
      Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => ListaClientes()),
      (Route<dynamic> route) => false);
  }

  saveRecord(){
    var it0 = lprecios.iterator;
    Precio vprecio ;
    while (it0.moveNext()) {
          vprecio = it0.current;
          service.salvaPreciosArticuloCliente(vprecio);
    }
  }



  Widget singleItemList(int index, TextEditingController controllertxt, Precio precio) {

    Precio item = precio;
    controllertxt.text = precio.precio.toString();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [

          Expanded(
              flex: 1,
              child: Text(" ")
          ),

          Expanded(
              flex: 1,
              child: Text("${index + 1}")
          ),


          Expanded(
            flex: 1,
            child:
            new TextField(
                enabled: false,
                decoration: InputDecoration(
                labelText: lprecios[index].codigo,
              ),
            ),
          ),

          Expanded(
              flex: 1,
              child: Text(" ")
          ),



          Expanded(
            flex: 3,
            child:
            new TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: lprecios[index].descripcion,
              ),
            ),
          ),

          Expanded(
              flex: 1,
              child: Text(" ")
          ),


          Expanded(
            flex: 1,
            child:
              new TextField(
              controller: controllertxt,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                 //takeNumber(text, lprecios[index].articulo_id.toString());
                 lprecios[index].precio= double.parse(text);
              },
              decoration: InputDecoration(
                labelText: "Precio",
              ),
            ),
          ),

          Expanded(
              flex: 1,
              child: Text(" ")
          ),


        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {


    return
      Scaffold(
      appBar: AppBar(title: Text("Captura de Precios x Cliente")),
        floatingActionButton: Column(

            mainAxisAlignment: MainAxisAlignment.end,
            children: [

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
                  Navigator.pushNamed(context, 'listaclientes');
                },
                heroTag: null,
              )


            ]
        ),

      body:


            Center(
              child:

              Container(
                child:

                FutureBuilder<List<Precio>>(
                    future: _getData(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState != ConnectionState.done) {
                        // return: show loading widget
                      }
                      if(snapshot.hasError) {
                        // return: show error widget
                      }
                      this.lprecios = snapshot.data ?? [];
                      return
                        SingleChildScrollView(
                          physics: ScrollPhysics(),
                      child: Column(
                      children: <Widget>[

                      Align(
                        alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        //decoration: BoxDecoration(border: Border.all(width: 0.0)),
                        child: new TextField(
                          //        controller: _searchview,
                          decoration: InputDecoration(
                              hintText: " Lista de Articulos x Cliente :  "+widget.cliente.id.toString()+"  "+widget.cliente.nombre
          //                          hintStyle: new TextStyle(color: Colors.grey[300]),
                          ),
                          textAlign: TextAlign.left,
                          enabled: false,
                        ),
                       ),
                      ),

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: this.lprecios.length,
                            itemBuilder: (context, index) {
                              _controllers.add(new TextEditingController());
                              if (this.lprecios.isEmpty) {
                                return CircularProgressIndicator();
                              } else {
                                return  singleItemList(index, _controllers[index], this.lprecios[index]);
                              }
                            }),




                          ],
                        ),
                      );
                    }),
              ),


            ),



    );

  }
}




class Item {
  final String id;
  final String name;

  Item(this.id, this.name);
}

