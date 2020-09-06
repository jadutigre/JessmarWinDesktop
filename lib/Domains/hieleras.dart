import 'package:jessmarwindesk/Domains/vendedor.dart';

import 'hielera.dart';

class Hieleras{
  List<Hielera> hielera;

  Hieleras({this.hielera});

  factory Hieleras.fromJson(List<dynamic> parsedJson){
    List<Hielera> hielera = List<Hielera>();
    hielera = parsedJson.map((i)=>Hielera.fromJson(i)).toList();
    return Hieleras(
      hielera: hielera,
    );
  }
}