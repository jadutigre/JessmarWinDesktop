class Clientes{

  int id;
  double iva;
  int nucta;
  String telefono;
  String rfc;
  String nombre;
  String email;
  String observ;
  String direccion;
  String ciudad;
  int diascred;

  Clientes({this.id, this.iva, this.nucta, this.telefono,this.rfc,this.nombre,this.email,this.observ,this.direccion,this.ciudad,this.diascred});

  factory Clientes.fromJson(Map<String, dynamic> parsedJson){
    return Clientes(
        id: parsedJson['id'],
        nucta : parsedJson['nucta'],
        telefono : parsedJson['telefono'],
        rfc : parsedJson ['rfc'],
      nombre : parsedJson ['nombre'],
      email : parsedJson ['email'],
      observ : parsedJson ['observ'],
      direccion : parsedJson ['direccion'],
      ciudad : parsedJson ['ciudad'],
      diascred : parsedJson ['diascred'],
    );
  }



}