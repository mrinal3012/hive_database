import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  TextEditingController _TController =TextEditingController();
  TextEditingController _UController=TextEditingController();

  Box? _countryBox;

  @override
  void initState() {

    _countryBox= Hive.box("Country_list");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Hive"),),
      body: Column(children: [
        SizedBox(height: 20,),
        TextField(
          controller: _TController,
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
        ElevatedButton(onPressed: () {
          final dataUser=_TController.text;
          _countryBox!.add(dataUser);
        }, child: Text("Add Country Name")),
        Spacer(),
        ValueListenableBuilder(
            valueListenable: Hive.box("Country_list").listenable(),
            builder:(context, value, child) => Container(
              height: 350,
              child: ListView.builder(
              itemCount: _countryBox!.keys.toList().length ,
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      title: Text("${_countryBox!.getAt(index)}"),
                      trailing: Container(width: 130,child: Row(
                        children: [
                          IconButton(onPressed: () {
                            showDialog(context:context , builder: (context) =>
                              AlertDialog(actions: [
                                Text("all is not ok now"),
                                SizedBox(height: 20),
                                TextField(
                                  controller: _UController,
                                  decoration:InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))) ,
                                  
                                ),
                                SizedBox(height: 20,),
                                ElevatedButton(onPressed: () {
                                  _countryBox!.putAt(index, _UController.text);
                                  Navigator.of(context).pop();
                                }, child: Text("Add Card"))
                              ]),);
                          }, icon:Icon(Icons.edit)),
                          SizedBox(width: 10,),
                          IconButton(onPressed: () {
                            _countryBox!.delete(index);
                          }, icon:Icon(Icons.delete)),
                        ],
                      )),
                    ),
                  ),
            ),))


      ],),

    );
  }
}
