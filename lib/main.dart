import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_tutorial/model/nomer.dart';

late Box<Nomer> nomerBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NomerAdapter());
  nomerBox = await Hive.openBox("Nomeer");
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController txtism = TextEditingController();
  TextEditingController txtnomer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hive"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: txtism,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Ismingizni kirting"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: txtnomer,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nomeringizni kirting"),
            ),
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                Nomer nomer= Nomer(txtism.text, int.parse(txtnomer.text));
                nomerBox.add(nomer);
              });
            },
            color: Colors.red,
            child: const Text("Saqlash"),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: nomerBox.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      color: Colors.green,
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(nomerBox.getAt(index)?.ism ?? "nomalum"),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(nomerBox.getAt(index)?.nomer.toString() ??
                              "nomalum"),
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
