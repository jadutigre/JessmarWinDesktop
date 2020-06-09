import 'package:jessmarwindesk/Domains/pedido.dart';

class Pedidos{

  List<Pedido> pedido;

  Pedidos({this.pedido});

  factory Pedidos.fromJson(List<dynamic> parsedJson){
    List<Pedido> pedido = List<Pedido>();
    pedido = parsedJson.map((i)=>Pedido.fromJson(i)).toList();
    return Pedidos(
      pedido: pedido,
    );
  }

}