class Pedido_detalle{

     int id;
     double cantidad;
     double precio;
     double total;
     int    articulo_id;
     String articulodescripcion;
     int    pedido_id;

     Pedido_detalle({this.id, this.cantidad, this.precio, this.total,
      this.articulo_id,
       this.articulodescripcion,
       this.pedido_id});

     factory Pedido_detalle.fromJson(Map<String, dynamic> parsedJson){
       return Pedido_detalle(
           id: parsedJson['id'],
           cantidad : parsedJson['cantidad'],
           precio : parsedJson['precio'],
           total : parsedJson ['total'],
           articulo_id : parsedJson['articulo_id'],
           articulodescripcion: parsedJson['articulodescripcion'],
           pedido_id : parsedJson ['pedido_id'],
       );
     }

      Map<String, dynamic> toJson() =>
          {
                'id': id,
                'cantidad': cantidad,
                 'precio' : precio,
                  'total': total,
                  'articulo_id': articulo_id,
                  'pedido_id': pedido_id
          };


}