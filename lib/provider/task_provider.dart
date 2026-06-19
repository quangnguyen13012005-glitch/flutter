import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/task.dart';

// Provider quản lý danh sách công việc
class TaskProvider extends ChangeNotifier {
  // Danh sách công việc
  List<Task> _tasks = [];

  // Getter để các màn hình lấy dữ liệu
  List<Task> get tasks => _tasks;

  // ==========================
  // Lấy danh sách từ SQLite
  // ==========================
  Future<void> loadTasks() async {
    _tasks = await DatabaseHelper.instance.getTasks();

    // Báo cho giao diện cập nhật
    notifyListeners();
  }

  // ==========================
  // Thêm công việc
  // ==========================
  Future<void> addTask(Task task) async {
    // Lưu xuống SQLite
    await DatabaseHelper.instance.insertTask(task);

    // Đọc lại dữ liệu mới nhất
    await loadTasks();
  }
}