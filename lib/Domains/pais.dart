class Pais{

      int id;
      String nombre;


      Pais({
        this.id, this.nombre
      });

      factory Pais.fromJson(Map<String, dynamic> parsedJson){
        return Pais(
            id: parsedJson['id'],
            nombre: parsedJson['nombre']
        );
      }


}