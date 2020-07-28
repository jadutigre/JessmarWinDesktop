import 'package:jessmarwindesk/Domains/respuesta.dart';
import 'package:jessmarwindesk/Domains/usuario.dart';
import 'package:jessmarwindesk/Service/jessmarService.dart';

class Autentica{

     Future<Respuesta> validaAutenticacion(String claveusuario, String password )  async {

           Respuesta respuesta = new Respuesta();

            JessmarService service = new JessmarService();
            Usuario usuario =  await service.getOneUsuario(claveusuario);
            if(usuario.usuario==claveusuario){
                if( usuario.claveacceso==password){
                      respuesta.message="Acceso es un exito";
                      respuesta.status=1;
                }else{
                  respuesta.message="Acceso fallido, password erroneo";
                  respuesta.status=0;
                }
            }else{
              respuesta.message="Acceso fallido, usuario erroneo";
              respuesta.status=0;
            }

            return respuesta;
     }




}