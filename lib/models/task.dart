// Model đại diện cho một công việc

class Task {
  int? id;
  String title;
  bool status;

  // Constructor
  Task({
    this.id,
    required this.title,
    required this.status,
  });

  // Chuyển object Task thành Map để lưu SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'status': status ? 1 : 0, // SQLite lưu bool dưới dạng 0 hoặc 1
    };
  }

  // Chuyển Map lấy từ SQLite thành object Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      status: map['status'] == 1,
    );
  }
}