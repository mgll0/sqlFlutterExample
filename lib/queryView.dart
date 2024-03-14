import 'package:flutter/material.dart';

class QueryView extends StatefulWidget {
  final List<dynamic> lista; // Parámetro lista
  const QueryView({Key? key, required this.lista})
      : super(key: key); // Constructor con lista como parámetro

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
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            ],
      ),
    );
  }
}
