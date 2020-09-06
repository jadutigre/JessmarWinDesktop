class Vendedor{
      int id;
      bool activo;
      String clave;
      String nombre;


      Vendedor({this.id, this.activo, this.clave, this.nombre});

      factory Vendedor.fromJson(Map<String, dynamic> parsedJson){
            return Vendedor(
                id: parsedJson['id'],
                activo : parsedJson['activo'],
                clave : parsedJson['clave'],
                nombre : parsedJson ['nombre']
            );
      }


      Map toJson() {

            return {
                  'id': id,
                  'activo' : activo,
                  'clave' : clave,
                  'nombre' : nombre
            };
      }



}