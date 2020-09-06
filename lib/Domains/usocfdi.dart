class Usocfdi{

    int id;
    String codigo;
    String descripcion;


    Usocfdi({this.id, this.codigo, this.descripcion});

    factory Usocfdi.fromJson(Map<String, dynamic> parsedJson){
        return Usocfdi(
        id: parsedJson['id'],
        codigo : parsedJson['codigo'],
        descripcion : parsedJson ['descripcion']
        );
    }

}