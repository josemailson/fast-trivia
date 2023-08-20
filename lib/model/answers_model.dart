class Answer {
  final int id;
  final int questionId;
  final int selectedAnswerId;
  final int correctAnswerId;
  final bool isCorrect;

  Answer({
    required this.id,
    required this.questionId,
    required this.selectedAnswerId,
    required this.correctAnswerId,
    required this.isCorrect,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      questionId: json['questionId'],
      selectedAnswerId: json['selectedAnswerId'],
      correctAnswerId: json['correctAnswerId'],
      isCorrect: json['isCorrect'],
    );
  }
}