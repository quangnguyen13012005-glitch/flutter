import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/task_provider.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    // Sau khi giao diện được tạo thì đọc dữ liệu SQLite
    Future.microtask(() {
      context.read<TaskProvider>().loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý Công việc"),
        centerTitle: true,
      ),

      body: provider.tasks.isEmpty

          ? const Center(
              child: Text("Chưa có công việc"),
            )

          : ListView.builder(
              itemCount: provider.tasks.length,

              itemBuilder: (context, index) {

                final task = provider.tasks[index];

                return Card(

                  margin: const EdgeInsets.all(8),

                  child: ListTile(

                    title: Text(task.title),

                    trailing: Checkbox(

                      value: task.status,

                      onChanged: (_) {},

                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTaskScreen(),
            ),
          );

        },
      ),
    );
  }
}