import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db"; //Nombre de base de datos
  static const _databaseVersion = 1; //Version de base de datos

  static const table = "my_table"; //Nombre de la tabla
//Atributos
  static const columnId = "_id";
  static const columnName = "name";
  static const columnAge = "age";

  late Database _db ; //Se crea la instancia de la db atraves de sqlite

  Future<void> init() async{
    final path;
    //Obtencion de la direccion/path para almacenar la DB
    if (kIsWeb) { //indicamos si se va a abrir en web
      path = "/assets/db"; //Local dentro de nuestra app
    } else {
      //Se almacena de forma oculta dentro de la app
      final documentsDirectory = (await getApplicationDocumentsDirectory()).path;
      path = join(documentsDirectory, _databaseName);
    }
    //Fin de obtencion de path

    //Crear y abrir BD
    _db = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY autoincrement,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER NOT NULL
      )
    ''');
  }
  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnId];
    return await _db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
