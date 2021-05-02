import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jessmarwindesk/Tools/PdfPrevio.dart';
import 'package:jessmarwindesk/Tools/repPedidosAbiertos.dart';
import 'package:jessmarwindesk/Vistas/FormArticulos.dart';
import 'package:jessmarwindesk/Vistas/FormClientePrecios.dart';
import 'package:jessmarwindesk/Vistas/FormClientes.dart';
import 'package:jessmarwindesk/Vistas/ListaArticulos.dart';
import 'package:jessmarwindesk/Vistas/ListaClientes.dart';
import 'package:jessmarwindesk/Vistas/ListaHieleras.dart';
import 'package:jessmarwindesk/Vistas/ListaPedidos.dart';
import 'package:jessmarwindesk/Vistas/ListaVendedores.dart';
import 'package:jessmarwindesk/Vistas/MenuPrincipal.dart';
import 'package:jessmarwindesk/Vistas/PedidosManto.dart';
import 'package:jessmarwindesk/Vistas/formInformes.dart';
import 'package:jessmarwindesk/localization.dart';
import 'package:jessmarwindesk/Vistas/loginVista.dart';


//import 'package:pmsmobil/Vistas/dashboard.dart';
//import 'package:pmsmobil/Vistas/datatableSample.dart';
//import 'package:pmsmobil/Vistas/llegadasReservas.dart';
//import 'package:pmsmobil/Vistas/loginVista.dart';
//import 'package:pmsmobil/localization.dart';
//import 'Vistas/checkoutReservas.dart';
//import 'package:pmsmobil/Vistas/llegadasDTReservas.dart';

void main() {

  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [Locale("es"), Locale("en"), Locale("pt")],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {

        // Check if the current device locale is supported
//        for (var supportedLocale in supportedLocales) {
//          if ( supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
//                return supportedLocale;
//              }
//        }
//        // If the locale of the device is not supported, use the first one
//        // from the list (English, in this case).
//        return supportedLocales.first;

        for (var supportedLocale in supportedLocales) {
          if (locale!=null && locale.languageCode!=null && locale.countryCode!=null && supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode){
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, or locale returns null
        // use the last one from the list (Hindi, in your case).
        return supportedLocales.last;
      },
      // initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // '/': (context) => LoginVista(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        "loginvista":(BuildContext context)=> new LoginVista(),
        "listapedidos":(BuildContext context)=> new ListaPedidos(),
        "pedidosmanto":(BuildContext context)=> new PedidosManto(),
        "listaclientes":(BuildContext context)=> new ListaClientes(),
        "formclientes":(BuildContext context)=> new FormClientes(),
        "formclienteprecios":(BuildContext context)=> new FormClientePrecios(),
        "listaarticulos":(BuildContext context)=> new ListaArticulos(),
        "listavendedores":(BuildContext context)=> new ListaVendedores(),
        "listahieleras":(BuildContext context)=> new ListaHieleras(),
        "menuprincipal":(BuildContext context)=> new MenuPrincipal(),
        "forminformes":(BuildContext context)=> new FormInformes(),
        "reppedidosabiertos":(BuildContext context)=> new RepPedidosAbiertos(),
        "pdfprevio":(BuildContext context)=> PdfPrevio(),
      },
      home: new LoginVista(),
      title:'Tarjeta de Registro',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData.dark(),
      //home: Home(title: 'Flutter Desktop Example'),
      // home: LoginVista(),
    );
  }
}