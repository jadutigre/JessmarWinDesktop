import 'package:jessmarwindesk/Domains/unidadmedida.dart';

class Unidadmedidas{

  List<Unidadmedida> unidadmedida;

  Unidadmedidas({this.unidadmedida});

  factory Unidadmedidas.fromJson(List<dynamic> parsedJson){
    List<Unidadmedida> unidadmedida = List<Unidadmedida>();
    unidadmedida = parsedJson.map((i)=> Unidadmedida.fromJson(i)).toList();
    return Unidadmedidas(
      unidadmedida: unidadmedida,
    );
  }

}
