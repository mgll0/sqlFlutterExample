import 'package:flutter/material.dart';

import 'dataBase.dart';
import 'main.dart';
import 'utils/sigleton.dart';

class QueryView extends StatefulWidget {
  final Function deleteCallback;

  const QueryView({Key? key, required this.deleteCallback}) : super(key: key);


  @override
  State<QueryView> createState() => _QueryViewState();
}

class _QueryViewState extends State<QueryView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List lista = singleton.getList();
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  height: size.height * 0.8,
                  width: size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: lista.length,
                      itemBuilder: (BuildContext context, int index) {
                        var usuario = lista[index].split(",");

                        return Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text("Usuario Actual: "),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    'User Name: ${usuario[1]}'),
                                                Text('User Age: ${usuario[2]}'),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Text("User ID: ${usuario[0]}")),
                              ElevatedButton(
                                onPressed: () => _edit(context, usuario),
                                child: Icon(Icons.edit),
                              ),
                              ElevatedButton(
                                  onPressed: () => _delete(usuario[0]), child: Icon(Icons.delete))
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _edit(BuildContext context, List usuario){
    final name = TextEditingController();
    final age = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modifica el usuario'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Nuevo Nombre: '),
              TextFormField(
                controller: name,
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.person),
                    errorText: null),
                onChanged: (texto) {},
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Nueva edad(int): '),
              TextFormField(
                controller: age,
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.person),
                    errorText: null),
                onChanged: (texto) {},
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el AlertDialog
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // row to update
                Map<String, dynamic> row = {
                  DatabaseHelper.columnId: usuario[0],
                  DatabaseHelper.columnName: usuario[1],
                  DatabaseHelper.columnAge: usuario[2]
                };
                final rowsAffected = await dbHelper.update(row);
                debugPrint('updated $rowsAffected row(s)');

                Navigator.of(context).pop(); // Cerrar el AlertDialog
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );

  }

  void _delete(id) async {
    // Assuming that the number of rows is the id for the last row.

    final rowsDeleted = await dbHelper.delete(id);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}
