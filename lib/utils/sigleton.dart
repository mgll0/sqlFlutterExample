//clase o punto de acceso global
//Local Data Base
class Singleton {
  static Singleton?
      _instance; //?: Si es nulo/vacio, toma o crea una nueva instancia

  Singleton._internal() {
    _instance = this;
  }

  //Verificar si singleton es nulo/vacio, si si devuelve una nueva instancia
  // si no devuelve la instancia ya creada
  factory Singleton() => _instance ?? Singleton._internal();

  List<Map<String, dynamic>> users = [];


  void iniciarLista() {

  }

  void clearVariables() {
    this.users = [];
  }

  void add(List<Map<String, dynamic>> lista) {
    users = lista;
  }

  List<Map<String, dynamic>> getList() {
    return users;
  }
}

final singleton = Singleton();
