import 'package:jessmarwindesk/Domains/usocfdi.dart';

class Usocfdis{

  List<Usocfdi> usocfdi;

  Usocfdis({this.usocfdi});

  factory Usocfdis.fromJson(List<dynamic> parsedJson){
    List<Usocfdi> usocfdi = List<Usocfdi>();
    usocfdi = parsedJson.map((i)=> Usocfdi.fromJson(i)).toList();
    return Usocfdis(
      usocfdi: usocfdi,
    );
  }

}
