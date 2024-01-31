import 'package:shared_preferences/shared_preferences.dart';

class TaskManager {
  addTask(String title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> namesNew = prefs.getStringList('names') ?? [];
    namesNew.add(title);
    await prefs.setStringList('names', namesNew);
  }

  editTask(String title, int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? namesNew = prefs.getStringList('names');

    namesNew![index] = title;

    await prefs.setStringList('names', namesNew);
  }

  deleteTask(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? namesNew = prefs.getStringList('names');
    namesNew!.removeAt(index);
    await prefs.setStringList('names', namesNew);
  }
}
