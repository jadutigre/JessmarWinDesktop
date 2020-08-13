class Articulo{
      int id;
      String codant;
      String codigo;
      String descripcion;
      String status;
      String lugar;
      double maximo;
      double minimo;
      String parte;
      double pcio1;
      double pcio2;
      double pcio3;
      double pcio4;
      double valoriva;
      double valorutmin;
      double valorutsug;
      int grupo_id;
      int subgrupo_id;
      int almacen_id;
      int unidmed_id;

      Articulo({
        this.id, this.codant, this.codigo,this.descripcion,this.status,this.lugar,
         this.maximo,this.minimo,this.parte
      });

      factory Articulo.fromJson(Map<String, dynamic> parsedJson){
        return Articulo(
          id: parsedJson['id'],
          codant: parsedJson['codant'],
          codigo: parsedJson['codigo'],
          descripcion : parsedJson['descripcion'],
          status: parsedJson['status'],
          lugar: parsedJson['lugar'],
          maximo: parsedJson['maximo'],
          minimo: parsedJson['minimo'],
          parte: parsedJson['parte']
        );
      }


}

