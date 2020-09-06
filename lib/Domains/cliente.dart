class Cliente{

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
  String noext;
  String colonia;
  String municipio;
  String codigopost;
  int pais_id;
  int estado_id;
  int usocfdi_id;

  Cliente({this.id, this.iva, this.nucta, this.telefono,this.rfc,this.nombre,this.email,this.observ,this.direccion,this.ciudad,this.diascred,
  this.noext,this.colonia,this.municipio,this.codigopost, this.pais_id, this.estado_id, this.usocfdi_id});

  factory Cliente.fromJson(Map<String, dynamic> parsedJson){
    return Cliente(
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
      noext: parsedJson['noext'],
      colonia: parsedJson['colonia'],
      municipio: parsedJson['municipio'],
      codigopost: parsedJson['codigopost'],
      pais_id: parsedJson['pais_id'],
      estado_id: parsedJson['estado_id'],
      usocfdi_id: parsedJson['usocfdi_id']
    );
  }


  Map toJson() {

    return {
      'id': id,
      'nucta' : nucta,
      'telefono' : telefono,
      'rfc' : rfc,
      'nombre' : nombre,
      'email' : email,
      'observ' : observ,
      'direccion' : direccion,
      'ciudad' : ciudad,
      'diascred' : diascred,
      'noext': noext,
      'colonia': colonia,
      'municipio': municipio,
      'codigopost': codigopost,
      'pais_id': pais_id,
      'estado_id': estado_id,
      'usocfdi_id': usocfdi_id
    };
  }





}