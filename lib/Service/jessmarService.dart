import 'dart:convert';

import 'package:http/http.dart';
import 'package:jessmarwindesk/Domains/Articulos.dart';
import 'package:jessmarwindesk/Domains/Usocfdis.dart';
import 'package:jessmarwindesk/Domains/articulo.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/cliente.dart';
import 'package:jessmarwindesk/Domains/clientes.dart';
import 'package:jessmarwindesk/Domains/estado.dart';
import 'package:jessmarwindesk/Domains/estados.dart';
import 'package:jessmarwindesk/Domains/grupo.dart';
import 'package:jessmarwindesk/Domains/grupos.dart';
import 'package:jessmarwindesk/Domains/hielera.dart';
import 'package:jessmarwindesk/Domains/hieleras.dart';
import 'package:jessmarwindesk/Domains/pais.dart';
import 'package:jessmarwindesk/Domains/paises.dart';
import 'package:jessmarwindesk/Domains/pedido_detalle.dart';
import 'package:jessmarwindesk/Domains/pedidos.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';
import 'package:jessmarwindesk/Domains/pedidos_detalles.dart';
import 'package:jessmarwindesk/Domains/precio.dart';
import 'package:jessmarwindesk/Domains/precios.dart';
import 'package:jessmarwindesk/Domains/unidadmedida.dart';
import 'package:jessmarwindesk/Domains/unidadmedidas.dart';
import 'package:jessmarwindesk/Domains/usocfdi.dart';
import 'package:jessmarwindesk/Domains/usuario.dart';
import 'package:jessmarwindesk/Domains/vendedor.dart';
import 'package:jessmarwindesk/Domains/vendedores.dart';

class JessmarService{

  //String url = 'http://www.spcsystems-cancun.com/JessmarServices/jessmar';
  String url = 'http://localhost:8084/JessmarServices/jessmar';


  Future<List<Articulo>> getListaArticulos() async {
    print("getListaArticulos");

    String uri = url+'/getListaArticulos';
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

    String uri = url+'/getListaPedidos';
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


  Future<List<Unidadmedida>> getListaUnidadesMedida() async {
    print("getListaUnidadMedida");

    String uri = url+'/getCatalogoUnidadesMedida';
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
    List<Unidadmedida> unidadmedida = Unidadmedidas
        .fromJson(json)
        .unidadmedida;
    //print(json);
    return unidadmedida;
  }




  Future<List<Pedido>> getListaPedidosFull() async {
    print("getListaPedidos");

    List<Pedido> pedidos;

    String uri = url+'/getListaPedidosFull';
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

    String uri = url+'/getListaArticulosFull';
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

    String uri = url+'/getListaPedidoDetalleByIdPedido';
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
      //print(json);
      detailPedido = Pedidos_detalles
          .fromJson(json).pedidosdetalle;

    }

    return detailPedido;

  }





  Future<List<Precio>> getListaPreciosByIdCliente(String id) async {
    print("getListaPreciosByIdCliente");

    List<Precio> precios;

    String uri = url+'/getListaPreciosByIdCliente';
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
      //print(json);
      precios = Precios
          .fromJson(json).precios;

    }

    return precios;

  }


  Future<List<Cliente>> getListaClientes() async {
    print("getListaClientes");

    String uri = url+'/getCatalogoClientes';
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


  Future<List<Usocfdi>> getListaUsocfdi() async {
    print("getListaUsocfdi");

    String uri = url+'/getListaUsoCFDI';
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
    List<Usocfdi> usocfdi = Usocfdis
        .fromJson(json)
        .usocfdi;
    //print(json);
    return usocfdi;
  }


  Future<List<Vendedor>> getListaVendedores() async {
    print("getListaVendedores");

    String uri = url+'/getCatalogoVendedores';
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




  Future<List<Hielera>> getListaHieleras() async {
    print("getListaHieleras");

    String uri = url+'/getListaHieleras';
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
    List<Hielera> hieleras = Hieleras
        .fromJson(json)
        .hielera;
    //print(json);
    return hieleras;
  }


  Future<List<Grupo>> getListaGrupos() async {
    print("getListaGrupos");

    String uri = url+'/getListaGrupo';
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
    List<Grupo> grupos = Grupos
        .fromJson(json)
        .grupos;
    print(json);
    return grupos;
  }







  Future<List<Pais>> getListaPaises() async {
    print("getListaPais");

    String uri = url+'/getListaPaises';
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
    List<Pais> paises = Paises
        .fromJson(json)
        .pais;
    //print(json);
    return paises;
  }


  Future<List<Estado>> getListaEstados() async {
    print("getListaEstados");

    String uri = url+'/getListaEstadosFull';
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
    List<Estado> estados = Estados
        .fromJson(json)
        .estado;
    //print(json);
    return estados;
  }




  Future<Usuario> getOneUsuario( String idusuario ) async {
    print("getOneUsuario");

    String uri = url+'/getOneUsuario';
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

        String uri = url+'/getPedidoById';
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
          print('One pedido:'+json);
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

      String uri = url+'/deletePedidoDetalleById';
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

      String uri = url+'/getOneClienteById';
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

      String uri = url+'/getOneVendedorById';
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


  Future<Unidadmedida> getOneUnidadMedida( String id ) async {
    print("getOneUnidadMedida");
    Unidadmedida unidadmedida = new Unidadmedida();

    try {

      String uri = url+'/getUnidadMedidaById';
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
        unidadmedida = Unidadmedida.fromJson(json);
        //print(json);
      }

    } catch (e) {    // <-- removing the on Exception clause
      print(e);
    }

    return unidadmedida;

  }







  void salvaOnePedido( Pedido pedido ) async {
    print("salvaOnePedido");

    String json = jsonEncode(pedido.toJson());
    print("json:"+json);

    try {

      String uri = url+'/insertaPedido';
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


  void salvaOneArticulos( Articulo articulo ) async {
    print("salvaOneArticulo");

    String json = jsonEncode(articulo.toJson());
    print("Salva json:"+json);

    try {

      String uri = url+'/insertaArticulo';
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


  void salvaOneClientes( Cliente cliente ) async {
    print("salvaOneCliente");

    String json = jsonEncode(cliente.toJson());
    print("Salva json:"+json);

    try {

      String uri = url+'/insertaCliente';
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


  void salvaOneVendedor( Vendedor vendedor ) async {
    print("salvaOneVendedor");

    String json = jsonEncode(vendedor.toJson());
    print("Salva json:"+json);

    try {

      String uri = url+'/insertaVendedor';
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

  void salvaOneHielera( Hielera hielera ) async {
    print("salvaOneHielera");

    String json = jsonEncode(hielera.toJson());
    print("Salva json:"+json);

    try {

      String uri = url+'/insertaHielera';
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


  void salvaPreciosArticuloCliente( Precio precio ) async {
    print("salvaPreciosArticuloCliente");

    String json = jsonEncode(precio.toJson());
    print("Salva json:"+json);

    try {

            String uri = url+'/insertaPrecioArticuloCliente';
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