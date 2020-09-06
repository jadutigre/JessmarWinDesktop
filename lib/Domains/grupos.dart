import 'package:jessmarwindesk/Domains/grupo.dart';

class Grupos{
  List<Grupo> grupos;

  Grupos({this.grupos});

  factory Grupos.fromJson(List<dynamic> parsedJson){
    List<Grupo> grupos = List<Grupo>();
    grupos = parsedJson.map((i)=>Grupo.fromJson(i)).toList();
    return Grupos(
      grupos: grupos,
    );
  }
}