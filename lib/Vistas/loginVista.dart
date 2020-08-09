import 'package:flutter/material.dart';
import 'package:jessmarwindesk/Controllers/autentica.dart';
import 'package:jessmarwindesk/Domains/respuesta.dart';
import 'package:jessmarwindesk/Domains/tipoLenguaje.dart';
import 'package:jessmarwindesk/Domains/usuario.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';
import 'package:jessmarwindesk/Vistas/MenuPrincipal.dart';
import '../localization.dart';

class LoginVista extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<LoginVista> {

  Future<List<TipoLenguaje>> tiposlenguajes ;
  List<TipoLenguaje> ltiposlenguajes = new List<TipoLenguaje>() ;
  TipoLenguaje _currenttipolenguaje;

  final TextEditingController _userController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  Future<void> getSWData() async {
       JessmarService service = new JessmarService();
       Usuario usuario  = await service.getOneUsuario("jdelgado");
       print(""+usuario.nombre);

//     clubes = getListaClubVacacional();
  }




  @override
  Widget build(BuildContext context) {


    return new Scaffold(

          appBar: AppBar(
              title: const Text('Jessmar Aplicaciòn'),
          ),

        body: new SingleChildScrollView(


        child: new Stack(

          children: <Widget>[
//            new Container(
//              decoration: new BoxDecoration(
//                image: new DecorationImage(image: new AssetImage("images/imagenfondo.png"), fit: BoxFit.cover,),
//              ),
//            ),
//            new Center(

//                child:  Container(

//                  decoration: _principalContenedor,
//                    Column(
//
//                      children: <Widget>[
            spaceContainer(space: 40.0),
             Column(
               children: <Widget>[




//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Row(
//
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//
//                         Column(
//                           children: [
//
//                             Container(
//                              width: MediaQuery.of(context).size.width * 0.96,
//                              //height: MediaQuery.of(context).size.height*0.50,
//                              color: Colors.blueAccent[400],
//                               child: Column(
//                                 children: [
//                                   Text("xxxxx"),
//                                   Text("xxxxx1"),
//                                   Text("xxxxx2")
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ]
//                   ),
//                 ),


                 Row(
                     children: <Widget>[

                         Expanded(
                           flex: 3,
                           child: Center(
                             child: Column(
                              children: [
                                  Image.asset("images/jessmar.png")
                              ],
                          ),
                           ),
                         ),

                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    _formularioLogin()
                                  ],
                                ),
                              )
                            ],

                        ),
                          ),
                        ),


               ]
             ),


              ]
             )


          ],
        ),
       )



    );

  }

  void toLlegadasProbables(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
       builder: (context) => MenuPrincipal(),
      ),
    );
  }



  Widget _formularioLogin(){
    return Container(
         width: 300.0,
        child: Center(
            child: Column(
              children: <Widget>[



//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: new FutureBuilder(
//                      future: tiposlenguajes,
//                      builder: (BuildContext context,AsyncSnapshot<List<TipoLenguaje>> snapshot) {
//                        if (!snapshot.hasData) return CircularProgressIndicator();
//                        return DropdownButton<TipoLenguaje>(
//                          isExpanded: true,
//                          value: _currenttipolenguaje,
//                          icon: Icon(Icons.check_circle_outline),
//                          hint: Text("Choose"),
//                          items: snapshot.data
//                              .map((items) => DropdownMenuItem<TipoLenguaje>(
//                            child: Text(items.descripcion),
//                            value: items,
//                          ))
//                              .toList(),
//                          onChanged: (TipoLenguaje newValue) {
//                            setState(() {
//                              print(_currenttipolenguaje.codigo);
//                              this._currenttipolenguaje = newValue;
//                              AppLocalizations.load(new Locale(_currenttipolenguaje.codigo));
//                            } );
//
////                      print(newValue.codigo);
////                      print(newValue.descripcion);
////                      print(_currenttipolenguaje.codigo);
////                      print(_currenttipolenguaje.descripcion);
//
//                          },
//                        );
//                      }),
//                ),

                spaceContainer(space: 10.0),

//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: new FutureBuilder(
//                  future: clubes,
//                  builder: (BuildContext context,AsyncSnapshot<List<Club>> snapshot) {
//                    if (!snapshot.hasData) return CircularProgressIndicator();
//                        return DropdownButton<Club>(
//                          isExpanded: true,
//                          value: _currentclub,
//                          icon: Icon(Icons.check_circle_outline),
//                          hint: Text("Choose"),
//                          items: snapshot.data
//                              .map((items) => DropdownMenuItem<Club>(
//                            child: Text(items.nombreclub),
//                            value: items,
//                          ))
//                              .toList(),
//                          onChanged: (Club newValue) {
//                            setState(() => this._currentclub = newValue);
//                             //selectedCountry = newValue;
//                          },
//                    );
//                  }),
//            ),
//             spaceContainer(space: 10.0),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _userController,
                    obscureText: false,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).user
                    ),
                  ),
                ),

//            spaceContainer(space: 10.0),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration:  InputDecoration(
                        labelText: AppLocalizations.of(context).password
                    ),
                  ),
                ),




                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,                    children: <Widget>[
                      RaisedButton(
                        onPressed: actionButtonRaised,
                        child:Row(
                          children: <Widget>[
                            Text('Entrar'),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ],
                  ),
                )




              ],
            )
        )
    );
  }



  Widget spaceContainer({double space}){
    return Container(
      height: space??15.0,
      child:null,
    );
  }

  void changedDropDownItem(String selectedCity) {
    //    setState(() {
    //      _currentCity = selectedCity;
    //    });
  }

  Future<void> actionButtonRaised() async {

    Autentica autentica = new Autentica();
    String claveusuario =  _userController.text;
    String password = _passwordController.text;

      print("Clave "+claveusuario+"Password "+password);
      Respuesta message = await autentica.validaAutenticacion(claveusuario, password);
      if(message.status==1){

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  MenuPrincipal()
              ),
            );

      }else{

            // set up the button
            Widget okButton = FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context, true),
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("My title"),
              content: Text(message.message),
              actions: [
                okButton,
              ],
            );

            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );



      }


  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }


}
