import 'package:jessmarwindesk/Domains/pais.dart';

class Paises{

  List<Pais> pais;

  Paises({this.pais});

  factory Paises.fromJson(List<dynamic> parsedJson){
    List<Pais> pais = List<Pais>();
    pais = parsedJson.map((i)=>Pais.fromJson(i)).toList();
    return Paises(
      pais: pais,
    );
  }

}
