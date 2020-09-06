class Grupo{
  int id;
  String clave;
  String descripcion;


  Grupo({this.id, this.clave, this.descripcion});

  factory Grupo.fromJson(Map<String, dynamic> parsedJson){
    return Grupo(
        id: parsedJson['id'],
        clave : parsedJson['clave'],
        descripcion : parsedJson ['descripcion'],
    );
  }


  Map toJson() {

    return {
      'id': id,
      'clave' : clave,
      'descripcion' : descripcion,
    };
  }



}