import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Domains/pedidos_detalles.dart';

class Pedido{

      int     id;
      int     tipopedido_id;
      String  tipopedidodescripcion;
      String  fechapedido;
      String  fechacierre;
      int     clientes_id;
      String  clientenombre;
      int     vendedor_id;
      int     usrabrio_id;
      int     usrcerro_id;
      String  vendedornombre;
      String  areaentrega;
      String  usuario;
      List<Pedido_detalle>  pedidosdetalle;
      int    hielera_id;
      String hieleranombre;
      String status;
      double total;

      Pedido(
          {
            this.id,
            this.tipopedido_id,
            this.tipopedidodescripcion,
            this.fechapedido,
            this.fechacierre,
            this.clientes_id,
            this.clientenombre,
            this.vendedor_id,
            this.usrabrio_id,
            this.usrcerro_id,
            this.vendedornombre,
            this.areaentrega,
            this.usuario,
            this.pedidosdetalle,
            this.hielera_id,
            this.hieleranombre,
            this.status,
            this.total
      });

      factory Pedido.fromJson(Map<String, dynamic> parsedJson){
            return Pedido(
                id: parsedJson['id'],
                tipopedido_id: parsedJson['tipopedido_id'],
                tipopedidodescripcion: parsedJson['tipopedidodescripcion'],
                fechapedido : parsedJson['fechapedido'],
                fechacierre : parsedJson['fechacierre'],
                clientes_id : parsedJson['clientes_id'],
                clientenombre: parsedJson['clientenombre'],
                vendedor_id: parsedJson['vendedor_id'],
                usrabrio_id: parsedJson['usrabrio_id'],
                usrcerro_id: parsedJson['usrcerro_id'],
                vendedornombre: parsedJson['vendedornombre'],
                areaentrega: parsedJson['areaentrega'],
                usuario : parsedJson ['usuario'],
                pedidosdetalle: parsedJson['pedidosdetalle'] != null ? Pedidos_detalles.fromJson( parsedJson['pedidosdetalle'] ).pedidosdetalle : null,
                hielera_id: parsedJson['hielera_id'],
                status: parsedJson['status']
            );
      }

//      Map<String, dynamic> toJson() =>
//          {
//                'id': id,
//                'tipopedido_id': tipopedido_id,
//                 'fechapedido' : fechapedido,
//                  'clientes_id': clientes_id,
//                  'clientenombre': clientenombre,
//                  'vendedor_id': vendedor_id,
//                  'vendedornombre': vendedornombre,
//                  'areaentrega':areaentrega,
//                  'usuario': usuario,
//                  'pedidosdetalle': pedidosdetalle
//          };


      Map toJson() {

        List<Map<String,dynamic >> pedidosdetalle =
        this.pedidosdetalle != null ? this.pedidosdetalle.map((i) => i.toJson()).toList() : null;

        return {
                'id': id,
                'tipopedido_id': tipopedido_id,
                 'fechapedido' : fechapedido,
                 'fechacierre' : fechacierre,
                  'clientes_id': clientes_id,
                  'clientenombre': clientenombre,
                  'vendedor_id': vendedor_id,
                  'usrabrio_id': usrabrio_id,
                  'usrcerro_id': usrcerro_id,
                  'vendedornombre': vendedornombre,
                  'areaentrega':areaentrega,
                  'usuario': usuario,
                  'pedidosdetalle': pedidosdetalle,
                  'hielera_id': hielera_id,
                  'status': status
        };
      }




}