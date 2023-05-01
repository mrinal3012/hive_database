import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  TextEditingController _PoemName =TextEditingController();
  TextEditingController _PoemWriterName =TextEditingController();
  TextEditingController _Poem=TextEditingController();
  TextEditingController _UController=TextEditingController();

  Box? _countryBox;

  Box? _countryNameBox;

  @override
  void initState() {

    _countryBox= Hive.box("Country_list");

    _countryNameBox=Hive.box("Writer_name");
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
          controller: _PoemName,
          decoration: InputDecoration(hintText: "Poem Name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
        SizedBox(height: 20,),
        TextField(
          controller: _PoemWriterName,
          decoration: InputDecoration(hintText: "Poem Writer Name", border: OutlineInputBorder( borderRadius: BorderRadius.circular(12))),
        ),
        SizedBox(height: 20,),
        TextField(
          minLines: 2,
          maxLines: 50,
          controller: _Poem,
          decoration: InputDecoration(hintText: "Write Poem",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),

        ),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: () {
          final dataUserPoemName=_PoemName.text;
          _countryBox!.add(dataUserPoemName);

          final dataUserPoemWriterName=_PoemWriterName.text;
          _countryNameBox!.add(dataUserPoemWriterName);


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
                      title:Column(children: [
                        Text("${_countryNameBox!.getAt(index)}"),
                        // Text("${_countryBox!.getAt(index)}"),

                      ],),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(onPressed: () {
                                      _countryBox!.deleteAt(index);
                                    }, child: Text("Delete")),

                                    ElevatedButton(onPressed: () {
                                      _countryBox!.putAt(index, _UController.text);
                                      Navigator.of(context).pop();
                                    }, child: Text("Add Card"))
                                  ],
                                )
                              ]),);
                          }, icon:Icon(Icons.edit)),
                          SizedBox(width: 10,),
                          IconButton(onPressed: () {
                            _countryBox!.deleteAt(index);
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
