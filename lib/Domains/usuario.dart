class Usuario{
  int id;
  String usuario;
  String claveacceso;
  String nombre;

  Usuario({this.id, this.usuario, this.claveacceso,this.nombre});

  factory Usuario.fromJson(Map<String, dynamic> parsedJson){
    return Usuario(
        id: parsedJson['id'],
        usuario : parsedJson['usuario'],
        claveacceso : parsedJson ['claveacceso'],
        nombre: parsedJson['nombre']
    );
  }

}