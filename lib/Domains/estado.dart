class Estado{

  int id;
  int pais_id;
  String nombre;


  Estado({
    this.id,this.pais_id, this.nombre
  });

  factory Estado.fromJson(Map<String, dynamic> parsedJson){
    return Estado(
        id: parsedJson['id'],
        pais_id: parsedJson['pais_id'],
        nombre: parsedJson['nombre']
    );
  }

}