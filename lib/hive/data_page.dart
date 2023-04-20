import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {

  TextEditingController _controller = TextEditingController();
  Box? _CountryBox;

  @override
  void initState() {
    _CountryBox = Hive.box("Country_list");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Hive"),),
        body: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
              TextField(

                controller: _controller,
                // decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12))),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              // SizedBox(height: 120,),

              // ElevatedButton(
              //     onPressed: () {
              //       final userData = _controller.text;
              //       _CountryBox!.add(userData);
              //     },
              //     child: Text("Add to Card")),

              SizedBox(
                height: 20,
              ),

              ValueListenableBuilder(
                valueListenable: Hive.box("Country_list").listenable(),
                builder: (context, value, child) => ListView.builder(
                  itemCount: _CountryBox!.keys.toList().length,
                  itemBuilder: (context, index) => Card(
                      child: ListTile(
                    title: Text("${_CountryBox!.getAt(index)}"),
                  )),
                ),
              )
            ],
          ),
        ));
  }
}
