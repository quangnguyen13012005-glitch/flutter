import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../provider/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Controller nhập tên công việc
  final TextEditingController _titleController = TextEditingController();

  // Trạng thái công việc (mặc định chưa hoàn thành)
  bool _status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm công việc"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // =========================
            // TextField nhập tên công việc
            // =========================
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Tên công việc",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // =========================
            // Checkbox trạng thái
            // =========================
            Row(
              children: [
                Checkbox(
                  value: _status,
                  onChanged: (value) {
                    setState(() {
                      _status = value ?? false;
                    });
                  },
                ),
                const Text("Đã hoàn thành")
              ],
            ),

            const SizedBox(height: 20),

            // =========================
            // Nút Lưu / Hủy
            // =========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // Nút Hủy
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Hủy"),
                ),

                // Nút Lưu
                ElevatedButton(
                  onPressed: () async {

                    // Validate
                    if (_titleController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Tên công việc không được để trống"),
                        ),
                      );
                      return;
                    }

                    // Tạo task mới
                    final task = Task(
                      title: _titleController.text.trim(),
                      status: _status,
                    );

                    // Gọi Provider để lưu xuống SQLite
                    await context.read<TaskProvider>().addTask(task);

                    // Quay lại màn hình trước
                    Navigator.pop(context);
                  },
                  child: const Text("Lưu"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}