import 'package:jessmarwindesk/Domains/pedido_detalle.dart';

class Pedidos_detalles{

  List<Pedido_detalle> pedidosdetalle;

  Pedidos_detalles({this.pedidosdetalle});

  factory Pedidos_detalles.fromJson(List<dynamic> parsedJson){
    List<Pedido_detalle> pedidosdetalle = List<Pedido_detalle>();
    pedidosdetalle = parsedJson.map((i)=>Pedido_detalle.fromJson(i)).toList();
    return Pedidos_detalles(
      pedidosdetalle: pedidosdetalle,
    );
  }

}