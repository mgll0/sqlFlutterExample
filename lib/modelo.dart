final String table = "my_table";

//manejo dentro ed la vista
class ModelDatabase {
  static final List<String> value = [
    //Add all fields
    id, name, age
  ];

  static final String id = "id";
  static final String age = "age";
  static final String name = "name";
}

//Creacion de variables dentro de json
class Model {
  final int? id;  //?Control de variables Nulo, vacio o un valor
  final int age;
  final String name;

  const Model({
    this.id,
    required this.age,
    required this.name
  });

  //Perder los datos
  Model copy({
    int? id,
    int? age,
    String? name,

  }) =>
      Model(id: id ?? this.id, age: age ?? this.age, name: name ?? this.name);

  static Model fromJson(Map<String, Object?> json) => Model(
    id: json[ModelDatabase.id] as int?,
    age: json[ModelDatabase.age] as int,
    name: json[ModelDatabase.name] as String
  );

  Map<String, Object?> toJason() => {
    ModelDatabase.id : id,
    ModelDatabase.age : age,
    ModelDatabase.name : name,
  };
}