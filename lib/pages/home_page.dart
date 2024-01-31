import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_list_sharedpreferences/utils/display_dialog_helper.dart';
import 'package:task_list_sharedpreferences/utils/modal_bottom_sheet_tarefas.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> names = [];

  void managerTaskList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      names = (prefs.getStringList('names') ?? []);
    });
  }

  @override
  void initState() {
    super.initState();
    managerTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences Tarefas"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ListTile(
              title: Text(
                names[index],
                style: const TextStyle(fontSize: 20),
              ),
              leading: CircleAvatar(
                child: Text(
                  '${names[index][0]}${names[index][1]}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            onTap: () {
              ModalBottomSheetTarefas.modalBottomSheetTarefas(
                      context, index, names)
                  .then((value) => managerTaskList());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DisplayDialogHelper.displayInputTarefa(
            context,
            false,
          ).then(
            (value) {
              managerTaskList();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
