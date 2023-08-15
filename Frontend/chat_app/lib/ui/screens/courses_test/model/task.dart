// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  final String title;
  final bool? isChecked;
  Task({
    required this.title,
    this.isChecked,
  }){
    this.isChecked ?? false;
  }

  Task copyWith({
    String? title,
    bool? isChecked,
  }) {
    return Task(
      title: title ?? this.title,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
