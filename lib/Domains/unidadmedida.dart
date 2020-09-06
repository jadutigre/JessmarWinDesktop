class Unidadmedida{

  int id;
  String clave;
  String descripcion;


  Unidadmedida({this.id, this.clave, this.descripcion});

  factory Unidadmedida.fromJson(Map<String, dynamic> parsedJson){
    return Unidadmedida(
        id: parsedJson['id'],
        clave : parsedJson['clave'],
        descripcion : parsedJson ['descripcion']
    );
  }


}