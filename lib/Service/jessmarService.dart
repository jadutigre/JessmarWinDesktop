import 'dart:convert';

import 'package:http/http.dart';
import 'package:jessmarwindesk/Domains/Articulos.dart';
import 'package:jessmarwindesk/Domains/articulo.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/clientes.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Domains/pedidos.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedidos_detalles.dart';
import 'package:jessmarwindesk/Domains/usuario.dart';
import 'package:jessmarwindesk/Domains/vendedor.dart';
import 'package:jessmarwindesk/Domains/vendedores.dart';

class JessmarService{

  Future<List<Articulo>> getListaArticulos() async {
    print("getListaArticulos");

    String uri = 'http://localhost:8084/JessmarServices/jessmar/getListaArticulos';
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

    var json = jsonDecode(responseBody)['payload'];
    List<Articulo> articulos = Articulos
        .fromJson(json)
        .articulo;
    //print(json);
    return articulos;
  }



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
    //print(json);
    return pedidos;
  }




  Future<List<Pedido>> getListaPedidosFull() async {
    print("getListaPedidos");

    List<Pedido> pedidos;

    String uri = 'http://localhost:8084/JessmarServices/jessmar/getListaPedidosFull';
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

    if( responseBody!=null && responseBody.length!=0 ){
      var json = jsonDecode(responseBody)['payload'];
      pedidos = Pedidos
          .fromJson(json)
          .pedido;
      //print(json);
    }

    return pedidos;

  }


  Future<List<Articulo>> getListaArticulosFull() async {
    print("getListaArticulosFull");

    List<Articulo> articulos;

    String uri = 'http://localhost:8084/JessmarServices/jessmar/getListaArticulosFull';
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

    if( responseBody!=null && responseBody.length!=0 ){
      var json = jsonDecode(responseBody)['payload'];
      articulos = Articulos
          .fromJson(json)
          .articulo;
      //print(json);
    }

    return articulos;

  }



  Future<List<Pedido_detalle>> getListaPedidoDetalleByIdPedido(String id) async {
    print("getListaPedidoDetalleByIdPedido");

    List<Pedido_detalle> detailPedido;

    String uri = 'http://localhost:8084/JessmarServices/jessmar/getListaPedidoDetalleByIdPedido';
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json"
    };

    Map<String, dynamic>  body = {'id': id};

    Response response = await post(
        uri,
        headers: headers,
        body : body
    );

    String responseBody = utf8.decode(response.bodyBytes);

    if( responseBody!=null && responseBody.length!=0 ){
      var json = jsonDecode(responseBody)['payload'];
      print(json);
      detailPedido = Pedidos_detalles
          .fromJson(json).pedidosdetalle;

    }

    return detailPedido;

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
    //print(json);
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
    //print(json);
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
      //print(json);
    }

    return usuario;

  }







  Future<Pedido> getOnePedido( String id ) async {
    print("getOnePedido");
    Pedido pedido = new Pedido();

    try {

        String uri = 'http://localhost:8084/JessmarServices/jessmar/getPedidoById';
        Map<String, String> headers = {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json"
        };
        Map<String, dynamic>  body = {'id': id};

        Response response = await post(
            uri,
            headers: headers,
            body: body
        );

        String responseBody = utf8.decode(response.bodyBytes);
        //print(responseBody);

        if( responseBody!=null && responseBody.length!=0 ){
          var json = jsonDecode(responseBody)['payload'];
          pedido = Pedido.fromJson(json);
          //print(json);
        }

    } catch (e) {    // <-- removing the on Exception clause
        print(e);
    }

    return pedido;

  }

  Future<Map> deletePedidoDetalleById( String id ) async {
    print("deletePedidoDetalleById");
    Map json;

    try {

      String uri = 'http://localhost:8084/JessmarServices/jessmar/deletePedidoDetalleById';
      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
      };
      Map<String, dynamic>  body = {'id': id};

      Response response = await post(
          uri,
          headers: headers,
          body: body
      );

      String responseBody = utf8.decode(response.bodyBytes);
      //print(responseBody);

      if( responseBody!=null && responseBody.length!=0 ){
        json = jsonDecode(responseBody)['payload'];
        //print(json);
      }

    } catch (e) {    // <-- removing the on Exception clause
      print(e);
    }

    return json;

  }





  Future<Cliente> getOneCliente( String id ) async {
    print("getOneCliente");
    Cliente cliente = new Cliente();

    try {

      String uri = 'http://localhost:8084/JessmarServices/jessmar/getOneClienteById';
      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
      };
      Map<String, dynamic>  body = {'id': id};

      Response response = await post(
          uri,
          headers: headers,
          body: body
      );

      String responseBody = utf8.decode(response.bodyBytes);
      //print(responseBody);

      if( responseBody!=null && responseBody.length!=0 ){
        var json = jsonDecode(responseBody);
        cliente = Cliente.fromJson(json);
        //print(json);
      }

    } catch (e) {    // <-- removing the on Exception clause
      print(e);
    }

    return cliente;

  }

  Future<Vendedor> getOneVendedor( String id ) async {
    print("getOneVendedor");
    Vendedor vendedor = new Vendedor();

    try {

      String uri = 'http://localhost:8084/JessmarServices/jessmar/getOneVendedorById';
      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
      };
      Map<String, dynamic>  body = {'id': id};

      Response response = await post(
          uri,
          headers: headers,
          body: body
      );

      String responseBody = utf8.decode(response.bodyBytes);
      //print(responseBody);

      if( responseBody!=null && responseBody.length!=0 ){
        var json = jsonDecode(responseBody);
        vendedor = Vendedor.fromJson(json);
        //print(json);
      }

    } catch (e) {    // <-- removing the on Exception clause
      print(e);
    }

    return vendedor;

  }

  void salvaOnePedido( Pedido pedido ) async {
    print("salvaOnePedido");

    String json = jsonEncode(pedido.toJson());
    print("json:"+json);

    try {

      String uri = 'http://localhost:8084/JessmarServices/jessmar/insertaPedido';
      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
      };
      Map<String, dynamic>  body = {'json': json};

      Response response = await post(
          uri,
          headers: headers,
          body: body
      );

      String responseBody = utf8.decode(response.bodyBytes);
      //print(responseBody);

//      if( responseBody!=null && responseBody.length!=0 ){
//        var json = jsonDecode(responseBody);
//        vendedor = Vendedor.fromJson(json);
//        //print(json);
//      }

    } catch (e) {    // <-- removing the on Exception clause
      print(e);
    }

//    return vendedor;

  }





}