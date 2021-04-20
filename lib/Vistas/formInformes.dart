
import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:intl/intl.dart';
import 'package:jessmarwindesk/Tools/repPedidosAbiertos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormInformes extends StatefulWidget {
  FormInformes({Key key}) : super(key: key);
  _FormInformesState createState() => _FormInformesState();
}


class _FormInformesState extends State<FormInformes> {

  JessmarService service = JessmarService();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<Map<String,dynamic>> datos;

  Future<List<Pedido>> fpedidos ;
  List<Pedido> pedidos ;

  List<String> filtros = ["Abiertos", "Cerrados", "Cancelados"];

  String menuhorizontalselectoption=null;

  DateTime now = DateTime.now();

  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    datos = _getData();
  }



  Future<Map<String,dynamic>> _getData() async {

    var formatter = new DateFormat('dd/MM/yyyy');
    _startTimeController.text=formatter.format(now);
    _endTimeController.text=formatter.format(now);

    JessmarService service = JessmarService();
    Map<String,dynamic> datos = new Map();

    final SharedPreferences prefs = await _prefs;
    menuhorizontalselectoption = prefs.getString('filtros');

    Pedido pedido = new Pedido();
    Pedido onepedido = new Pedido();
    print("Servicio  _getData");

    if(pedido.id == 0 ){
      onepedido = pedido;
    }else{
      onepedido   = await service.getOnePedido(pedido.id.toString());
    }

    datos["onepedido"]= onepedido;

    return datos;

  }

  InkWell _actividades( Color color, Color txtcolor, String heading, String subheading, String taped) {
    print("Transition "+taped+" Heading "+heading);
    return

      InkWell(
          child: Container(
            width: 120,
height: 40,
            child: Card(

                color: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),

                child:


                Align(
                  alignment: Alignment.center,
                  child:

                  Text(heading ?? " ", style: TextStyle(
                    color: txtcolor,
                    fontFamily: 'PoppinsMedium',
                    fontSize: 10),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,),
                )


            ),
          ),
          onTap:  ()  async {

            print(taped);

            final SharedPreferences prefs = await _prefs;
            await prefs.setString('menuselectoption', heading);
            menuhorizontalselectoption = await prefs.getString("menuselectoption");



            print(taped);
            setState(() {});


          }
      );
  }


  @override
  Widget build(BuildContext context) {

    final formattime = DateFormat("HH:mm");
    final formatdate = DateFormat("yyyy-MM-dd");
    final formatdate1 = DateFormat("dd/MM/yyyy");
    DateTime now = new DateTime.now();

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


                              Expanded(
                                flex: 1,
                                child: Container(
                                          color: Colors.green,
                                          width: 350,
                                          padding: const EdgeInsets.all(16.0),
                                          //decoration: BoxDecoration(border: Border.all(width: 0.0)),
                                          child:

                                          Column(
                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[



                                              ]
                                          )
                                )),



                          Expanded(
                          flex: 2,
                          child:
                          Container(
                                              color: Colors.white,
                                              width: 350,
                                              padding: const EdgeInsets.all(16.0),
                                              //decoration: BoxDecoration(border: Border.all(width: 0.0)),
                                              child:




                                              Column(
                                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[

                                                    SizedBox(height: 40),

                                                    new Text("Reportes de Pedidos",
                                                      style: TextStyle(fontFamily:  'Poppins', fontSize: 24, letterSpacing: 0.5),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 6,),

                                                    SizedBox(height: 40),

                                                    SizedBox(

                                                        height: 30,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: filtros.length,
                                                          itemBuilder: (context, i) {
                                                            print('menuhorizontalselectoption '+menuhorizontalselectoption);
                                                            return
                                                              (menuhorizontalselectoption==filtros[i])  ?
                                                              _actividades(new Color.fromRGBO(244, 106, 24, 1),Colors.white,filtros[i],"","") :
                                                              _actividades(new Color.fromRGBO(223, 223, 223, 1),Colors.black,filtros[i],"","");
                                                          },
                                                        )),

                                                    SizedBox(height: 40),

                                                    new Text("Fecha Inicial "),
                                                    DateTimeField(
                                                      controller: _startTimeController,
                                                      format: formatdate1,
                                                      onShowPicker: (context, currentValue) async {
                                                        final date = await showDatePicker(
                                                            context: context,
                                                            firstDate: DateTime(1900),
                                                            initialDate: currentValue ?? DateTime.now(),
                                                            lastDate: DateTime(2100));
                                                        // if (date != null) {
                                                        //   final time = await showTimePicker(
                                                        //     context: context,
                                                        //     initialTime:
                                                        //     TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                                        //   );
                                                        return DateTimeField.combine(date, new TimeOfDay(hour: now.hour, minute: now.minute));
                                                        // } else {
                                                        //   return currentValue;
                                                        // }
                                                      },
                                                    ),

                                                    SizedBox(height: 40),

                                                    new Text("Fecha Final "),
                                                    DateTimeField(
                                                      controller: _endTimeController,
                                                      format: formatdate1,
                                                      onShowPicker: (context, currentValue) async {
                                                        final date = await showDatePicker(
                                                            context: context,
                                                            firstDate: DateTime(1900),
                                                            initialDate: currentValue ?? DateTime.now(),
                                                            lastDate: DateTime(2100));
                                                        // if (date != null) {
                                                        //   final time = await showTimePicker(
                                                        //     context: context,
                                                        //     initialTime:
                                                        //     TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                                        //   );
                                                          return DateTimeField.combine(date, new TimeOfDay(hour: now.hour, minute: now.minute));
                                                        // } else {
                                                        //   return currentValue;
                                                        // }
                                                      },
                                                    ),


                                                    SizedBox(height: 40),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                                                crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                                                children: <Widget>[


                                                      RaisedButton(child: Text("Generar el Reporte"), onPressed: () async {
                                                        var now = new DateTime.now();
                                                        //var formatter = new DateFormat('yyyy-MM-dd');
                                                        //var formatter = new DateFormat('dd/MM/yyyy');
                                                        String today = formatdate.format(now);
                                                        String startDateTime = "${_startTimeController.text}";
                                                        String endDateTime = "${_endTimeController.text}";
                                                        print(startDateTime);
                                                        print(endDateTime);

                                                         var parsedstartDateTime = new DateFormat('dd/MM/yyyy').parse(startDateTime);
                                                         startDateTime = formatdate.format(parsedstartDateTime);
                                                         var parsedendDateTime = new DateFormat('dd/MM/yyyy').parse(endDateTime);
                                                         endDateTime = formatdate.format(parsedendDateTime);
                                                        //
                                                        // Duration difference = parsedendDateTime .difference(parsedstartDateTime);
                                                        // print(' Days ${difference.inDays}');
                                                        // print(' Hours ${difference.inHours}');
                                                        // print(' Mins ${difference.inMinutes}');

                                                        final SharedPreferences prefs = await _prefs;
                                                        prefs.setString("filtros", menuhorizontalselectoption);
                                                        prefs.setString("finicial", startDateTime);
                                                        prefs.setString("ffinal", endDateTime);


                                                        String _estatus="";
                                                        if(menuhorizontalselectoption=='Abiertos'){
                                                          _estatus="abierto";
                                                        }else if(menuhorizontalselectoption=='Cerrados'){
                                                          _estatus="cerrado";
                                                        }else if(menuhorizontalselectoption=='Cancelados'){
                                                          _estatus="cancelado";
                                                        }

                                                        fpedidos =  service.getListaPedidosFull(_estatus,startDateTime,endDateTime);
                                                        pedidos  = await fpedidos;
                                                        print(pedidos);

                                                        Navigator.pushNamed(context, 'reppedidosabiertos',arguments: {'pedidos': pedidos});

                                                      } ,)



                                                    ],)
                              //
                              // )




                                                  ]
                                              )
                                          ),
                          ),


                          Expanded(
                          flex: 1,
                          child: Container(
                                             color: Colors.green,
                                              width: 350,
                                              padding: const EdgeInsets.all(16.0),
                                              //decoration: BoxDecoration(border: Border.all(width: 0.0)),
                                              child:

                                              Column(
                                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[

                                                  ]
                                              )
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



              // FloatingActionButton(
              //   child: Icon(
              //       Icons.arrow_back
              //   ),
              //   onPressed: () {
              //     //gotoListaVendedores();
              //   },
              //   heroTag: null,
              // ),





              // FloatingActionButton(
              //   child: Icon(
              //       Icons.save
              //   ),
              //   onPressed: () {
              //     //saveRecord();
              //   },
              //   heroTag: null,
              // )
              //


            ]
        ),
        body: new SingleChildScrollView(
          child: futureBuilder,
        )
    );



  }


}