import 'dart:convert';

import 'package:http/http.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/clientes.dart';
import 'package:jessmarwindesk/Domains/pedidos.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/usuario.dart';
import 'package:jessmarwindesk/Domains/vendedor.dart';
import 'package:jessmarwindesk/Domains/vendedores.dart';

class JessmarService{




  Future<List<Pedido>> getListaPedidos() async {
    print("getListaPedidos");

    String uri = 'http://localhost:8084/JessmarServices/jessmar/getListaPedidos';
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json"
    };
    //Map<String, dynamic>  body = {'nohotel': nohotel};

    Response response = await post(
        uri,
        headers: headers
    );

    String responseBody = utf8.decode(response.bodyBytes);

    var json = jsonDecode(responseBody);
    List<Pedido> pedidos = Pedidos
        .fromJson(json)
        .pedido;
    print(json);
    return pedidos;
  }

  Future<List<Cliente>> getListaClientes() async {
    print("getListaClientes");

    String uri = 'http://localhost:8084/JessmarServices/jessmar/getCatalogoClientes';
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json"
    };
    //Map<String, dynamic>  body = {'nohotel': nohotel};

    Response response = await post(
        uri,
        headers: headers
    );

    String responseBody = utf8.decode(response.bodyBytes);

    var json = jsonDecode(responseBody);
    List<Cliente> clientes = Clientes
        .fromJson(json)
        .cliente;
    print(json);
    return clientes;
  }


  Future<List<Vendedor>> getListaVendedores() async {
    print("getListaVendedores");

    String uri = 'http://localhost:8084/JessmarServices/jessmar/getCatalogoVendedores';
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json"
    };
    //Map<String, dynamic>  body = {'nohotel': nohotel};

    Response response = await post(
        uri,
        headers: headers
    );

    String responseBody = utf8.decode(response.bodyBytes);

    var json = jsonDecode(responseBody);
    List<Vendedor> vendedores = Vendedores
        .fromJson(json)
        .vendedor;
    print(json);
    return vendedores;
  }






  Future<Usuario> getOneUsuario( String idusuario ) async {
    print("getOneUsuario");

    String uri = 'http://localhost:8084/JessmarServices/jessmar/getOneUsuario';
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json"
    };
    Map<String, dynamic>  body = {'idusuario': idusuario};

    Response response = await post(
        uri,
        headers: headers,
        body: body
    );

    String responseBody = utf8.decode(response.bodyBytes);
    //print(responseBody);

    Usuario usuario = new Usuario();
    if( responseBody!=null && responseBody.length!=0 ){
      var json = jsonDecode(responseBody);
      usuario = Usuario.fromJson(json);
      print(json);
    }

    return usuario;

  }







  Future<Pedido> getOnePedido( int idpedido ) async {
    print("getOnePedido");

    String uri = 'http://localhost:8084/JessmarServices/jessmar/getPedidoById';
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json"
    };
    Map<String, dynamic>  body = {'idpedido': idpedido};

    Response response = await post(
        uri,
        headers: headers,
        body: body
    );

    String responseBody = utf8.decode(response.bodyBytes);
    //print(responseBody);

    Pedido pedido = new Pedido();
    if( responseBody!=null && responseBody.length!=0 ){
      var json = jsonDecode(responseBody);
      pedido = Pedido.fromJson(json);
      print(json);
    }

    return pedido;

  }







}