import 'package:jessmarwindesk/Domains/vendedor.dart';

class Vendedores{
  List<Vendedor> vendedor;

  Vendedores({this.vendedor});

  factory Vendedores.fromJson(List<dynamic> parsedJson){
    List<Vendedor> vendedor = List<Vendedor>();
    vendedor = parsedJson.map((i)=>Vendedor.fromJson(i)).toList();
    return Vendedores(
      vendedor: vendedor,
    );
  }
}