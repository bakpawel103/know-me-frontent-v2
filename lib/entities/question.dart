class Question {
  final int id;
  final String name;
  final String description;
  final bool answered;

  const Question({
    required this.id,
    required this.name,
    required this.description,
    required this.answered,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      answered: json['answered'],
    );
  }
}