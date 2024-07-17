import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime initDate;
  final DateTime? endDate;

  const Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.initDate,
    this.endDate
  });

  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? initDate,
    DateTime? endDate
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      initDate: initDate ?? this.initDate,
      endDate: endDate
    );
  }

  @override
  List<Object> get props => [id, title, isCompleted];
}
