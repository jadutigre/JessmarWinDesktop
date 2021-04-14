class Precio{
  int articulo_id;
  String codigo;
  String descripcion;
  int cliente_id;
  String nombre;
  int precio_id;
  double precio;


  Precio({this.articulo_id, this.codigo, this.descripcion,this.cliente_id, this.nombre,this.precio_id, this.precio});

  factory Precio.fromJson(Map<String, dynamic> parsedJson){
    return Precio(
        articulo_id: parsedJson['articulo_id'],
        codigo : parsedJson['codigo'],
        descripcion : parsedJson['descripcion'],
        cliente_id: parsedJson['cliente_id'],
        nombre : parsedJson ['nombre'],
        precio_id: parsedJson['precio_id'],
        precio: parsedJson['precio']
    );
  }


  Map toJson() {

    return {
      'articulo_id': articulo_id,
      'codigo' : codigo,
      'descripcion' : descripcion,
      'cliente_id' : cliente_id,
      'nombre': nombre,
      'id': precio_id,
      'precio': precio
    };
  }

  @override
  String toString() => descripcion;

}