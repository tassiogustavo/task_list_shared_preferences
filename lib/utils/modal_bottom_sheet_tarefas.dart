import 'package:flutter/material.dart';
import 'package:task_list_sharedpreferences/controllers/task_manager.dart';
import 'package:task_list_sharedpreferences/utils/display_dialog_helper.dart';

class ModalBottomSheetTarefas {
  static Future<void> modalBottomSheetTarefas(
    BuildContext context,
    int index,
    List<String> names,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildActionButton("Editar", () {
                  DisplayDialogHelper.displayInputTarefa(context, true,
                          index: index, names: names)
                      .then((value) {
                    Navigator.pop(context);
                  });
                }),
                _buildActionButton("Excluir", () {
                  TaskManager().deleteTask(index);
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildActionButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
