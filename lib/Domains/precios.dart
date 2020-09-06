import 'package:jessmarwindesk/Domains/precio.dart';

class Precios{
  List<Precio> precios;

  Precios({this.precios});

  factory Precios.fromJson(List<dynamic> parsedJson){
    List<Precio> precios = List<Precio>();
    precios = parsedJson.map((i)=>Precio.fromJson(i)).toList();
    return Precios(
      precios: precios,
    );
  }
}