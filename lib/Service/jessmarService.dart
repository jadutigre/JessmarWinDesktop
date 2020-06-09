import 'dart:convert';

import 'package:http/http.dart';
import 'package:jessmarwindesk/Domains/pedidos.dart';
import 'package:jessmarwindesk/Domains/pedido.dart';

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



}