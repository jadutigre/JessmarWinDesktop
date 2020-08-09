class Articulo{
      int id;
      String descripcion;

      Articulo({this.id, this.descripcion});

      factory Articulo.fromJson(Map<String, dynamic> parsedJson){
        return Articulo(
          id: parsedJson['id'],
          descripcion : parsedJson['descripcion']
        );
      }


}

