class Respuesta{

      int    status;
      String message;

      Respuesta({this.status,this.message});

      factory Respuesta.fromJson(Map<String, dynamic> parsedJson){
        return Respuesta(
            status: parsedJson['status'],
            message : parsedJson['message']
        );
      }


}