import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const TodaApp(),
    );
  }
}

class TodaApp extends StatefulWidget {
  const TodaApp({super.key});

  @override
  State<TodaApp> createState() => _TodaAppState();
}

class _TodaAppState extends State<TodaApp> {
  late TextEditingController _titleController;
  late TextEditingController _detailController;
  final List<Map<String, String>> _myList = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _detailController = TextEditingController();
  }

  // เพิ่มฟังก์ชันแก้ไขรายการ
  void editTodoHandle(BuildContext context, int index) {
    _titleController.text = _myList[index]["title"] ?? "";
    _detailController.text = _myList[index]["detail"] ?? "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task title",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _detailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task detail",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _myList[index] = {
                    "title": _titleController.text,
                    "detail": _detailController.text,
                  };
                });
                _titleController.text = "";
                _detailController.text = "";
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void addTodoHandle(BuildContext context) {
    _titleController.text = "";
    _detailController.text = "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add new task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task title",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _detailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task detail",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _myList.add({
                    "title": _titleController.text,
                    "detail": _detailController.text,
                  });
                });
                _titleController.text = "";
                _detailController.text = "";
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: _myList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_myList[index]["title"] ?? ""),
            subtitle: Text(_myList[index]["detail"] ?? ""),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                editTodoHandle(context, index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
