import 'estado.dart';

class Estados{

  List<Estado> estado;

  Estados({this.estado});

  factory Estados.fromJson(List<dynamic> parsedJson){
    List<Estado> estado = List<Estado>();
    estado = parsedJson.map((i)=>Estado.fromJson(i)).toList();
    return Estados(
      estado: estado,
    );
  }

}