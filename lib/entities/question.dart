class Question {
  final int id;
  String name;
  String description;
  bool answered;

  Question({
    required this.id,
    required this.name,
    required this.description,
    this.answered = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      answered: json['answered'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'answered': answered,
      };
}
