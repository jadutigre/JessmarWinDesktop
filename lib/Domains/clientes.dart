import 'package:jessmarwindesk/Domains/cliente.dart';

class Clientes{

  List<Cliente> cliente;

  Clientes({this.cliente});

  factory Clientes.fromJson(List<dynamic> parsedJson){
    List<Cliente> cliente = List<Cliente>();
    cliente = parsedJson.map((i)=>Cliente.fromJson(i)).toList();
    return Clientes(
      cliente: cliente,
    );
  }

}