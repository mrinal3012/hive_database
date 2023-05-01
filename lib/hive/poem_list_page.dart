import 'package:flutter/material.dart';

class PoemListPage extends StatefulWidget {
  const PoemListPage({Key? key}) : super(key: key);

  @override
  State<PoemListPage> createState() => _PoemListPageState();
}

class _PoemListPageState extends State<PoemListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Poem List"),),
      body: ListView(

      ),
    );
  }
}
