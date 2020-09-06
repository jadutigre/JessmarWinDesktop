class Hielera{
      int id;
      bool activa;
      String clave;
      String descripcion;
      String fecha_adquisicion;
      String fecha_baja;


      Hielera({this.id, this.activa, this.clave, this.descripcion,this.fecha_adquisicion,this.fecha_baja});

      factory Hielera.fromJson(Map<String, dynamic> parsedJson){
            return Hielera(
                id: parsedJson['id'],
                activa : parsedJson['activa'],
                clave : parsedJson['clave'],
                descripcion : parsedJson ['descripcion'],
                fecha_adquisicion: parsedJson['fecha_adquisicion'],
                fecha_baja: parsedJson['fecha_baja']
            );
      }


      Map toJson() {

            return {
                  'id': id,
                  'activa' : activa,
                  'clave' : clave,
                  'descripcion' : descripcion,
                  'fecha_adquisicion' : fecha_adquisicion,
                  'fecha_baja' : fecha_baja
            };
      }



}