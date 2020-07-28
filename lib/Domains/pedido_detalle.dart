class Pedido_detalle{

     int id;
     double cantidad;
     double precio;
     double total;
     int    articulo_id;
     int    pedido_id;

     Pedido_detalle({this.id, this.cantidad, this.precio, this.total,
      this.articulo_id, this.pedido_id});

     factory Pedido_detalle.fromJson(Map<String, dynamic> parsedJson){
       return Pedido_detalle(
           id: parsedJson['id'],
           cantidad : parsedJson['cantidad'],
           precio : parsedJson['precio'],
           total : parsedJson ['total'],
           articulo_id : parsedJson['articulo_id'],
           pedido_id : parsedJson ['pedido_id'],
       );
     }


}