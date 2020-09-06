class Articulo{
      int id;
      String codant;
      String codigo;
      String descripcion;
      String estatus;
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
      String cvesat;
      String unidadsat;
      bool activo;
      double prorden;

      Articulo({
        this.id, this.codant, this.codigo,this.descripcion,this.estatus,this.lugar,
         this.maximo,this.minimo,this.parte,this.cvesat,this.unidadsat,this.activo,
      this.grupo_id,this.unidmed_id,this.prorden
      });

      factory Articulo.fromJson(Map<String, dynamic> parsedJson){
        return Articulo(
          id: parsedJson['id'],
          codant: parsedJson['codant'],
          codigo: parsedJson['codigo'],
          descripcion : parsedJson['descripcion'],
          estatus: parsedJson['estatus'],
          lugar: parsedJson['lugar'],
          maximo: parsedJson['maximo'],
          minimo: parsedJson['minimo'],
          parte: parsedJson['parte'],
              cvesat: parsedJson['cvesat'],
              unidadsat: parsedJson['unidadsat'],
              activo: parsedJson['activo'],
              grupo_id: parsedJson['grupo_id'],
              unidmed_id: parsedJson['unidmed_id'],
              prorden: parsedJson['prorden']
        );
      }


      Map toJson() {

            return {
                  'id': id,
                  'codigo': codigo,
                  'codant': codant,
                  'descripcion' : descripcion,
                  'lugar': lugar,
                  'parte': parte,
                  'cvesat': cvesat,
                  'unidadsat': unidadsat,
                  'estatus': estatus,
                  'subgrupo_id':subgrupo_id,
                  'almacen_id':almacen_id,
                  'grupo_id':grupo_id,
                  'unidmed_id': unidmed_id,
                  'activo': activo,
                  'grupo_id': grupo_id,
                  'maximo': maximo,
                  'minimo': minimo,
                  'prorden': prorden
            };
      }


}

