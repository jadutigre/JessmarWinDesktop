class Pedido{

      int     id;
      String     fechapedido;
      int     clientes_id;
      int     novendedor;
      String  usuario;

      Pedido({this.id, this.fechapedido, this.clientes_id, this.novendedor,
            this.usuario});

      factory Pedido.fromJson(Map<String, dynamic> parsedJson){
            return Pedido(
                id: parsedJson['id'],
                fechapedido : parsedJson['fechapedido'],
                clientes_id : parsedJson['clientes_id'],
                usuario : parsedJson ['usuario']
            );
      }

}