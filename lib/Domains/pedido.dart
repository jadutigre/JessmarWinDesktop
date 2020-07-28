import 'package:jessmarwindesk/Domains/pedido_detalle.dart';

class Pedido{

      int     id;
      int     tipopedido_id;
      String  fechapedido;
      int     clientes_id;
      int     vendedor_id;
      String  usuario;
      Pedido_detalle  pedido_detalle;

      Pedido({this.id, this.tipopedido_id, this.fechapedido, this.clientes_id, this.vendedor_id,
            this.usuario, this.pedido_detalle});

      factory Pedido.fromJson(Map<String, dynamic> parsedJson){
            return Pedido(
                id: parsedJson['id'],
                tipopedido_id: parsedJson['tipopedido_id'],
                fechapedido : parsedJson['fechapedido'],
                clientes_id : parsedJson['clientes_id'],
                vendedor_id: parsedJson['vendedor_id'],
                usuario : parsedJson ['usuario'],
                pedido_detalle: parsedJson['pedido_detalle'] != null ? Pedido_detalle.fromJson( parsedJson['pedido_detalle'] ) : null
            );
      }




}