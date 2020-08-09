import 'articulo.dart';

class Articulos{

  List<Articulo> articulo;

  Articulos({this.articulo});

  factory Articulos.fromJson(List<dynamic> parsedJson){
    List<Articulo> articulo = List<Articulo>();
    articulo = parsedJson.map((i)=>Articulo.fromJson(i)).toList();
    return Articulos(
      articulo: articulo,
    );
  }

}