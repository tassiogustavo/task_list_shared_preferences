import 'package:flutter/material.dart';
import 'package:task_list_sharedpreferences/controllers/task_manager.dart';

class DisplayDialogHelper {
  static Future<void> displayInputTarefa(BuildContext context, bool isUpdate,
      {int? index, List<String>? names}) {
    TextEditingController titleController = TextEditingController();
    if (isUpdate) {
      titleController.text = names![index!];
    }
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: isUpdate
              ? const Text('Alterar Tarefa')
              : const Text('Nova Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Titulo da tarefa"),
              ),
            ],
          ),
          actions: <Widget>[
            _buildMaterialButton("CANCELAR", Colors.red, () {
              titleController.clear();
              Navigator.pop(context);
            }),
            _buildMaterialButton("SALVAR", Colors.green, () {
              TaskManager taskManager = TaskManager();
              if (isUpdate) {
                if (index != null) {
                  taskManager.editTask(titleController.text, index);
                }
              } else {
                taskManager.addTask(titleController.text);
              }
              titleController.clear();
              Navigator.pop(context);
            }),
          ],
        );
      },
    );
  }

  static Widget _buildMaterialButton(
      String label, Color color, VoidCallback onPressed) {
    return MaterialButton(
      color: color,
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
