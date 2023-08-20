class Question {
  final int id;
  final String titulo;
  final String pergunta;
  final int gabarito;
  final List<Alternative> alternativas;

  Question({
    required this.id,
    required this.titulo,
    required this.pergunta,
    required this.gabarito,
    required this.alternativas,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    List<dynamic> alternativasJson = json['alternativas'];
    List<Alternative> alternativas = alternativasJson.map((e) => Alternative.fromJson(e)).toList();

    return Question(
      id: json['id'],
      titulo: json['titulo'],
      pergunta: json['pergunta'],
      gabarito: json['gabarito'],
      alternativas: alternativas,
    );
  }
}

class Alternative {
  final int id;
  final String titulo;

  Alternative({
    required this.id,
    required this.titulo,
  });

  factory Alternative.fromJson(Map<String, dynamic> json) {
    return Alternative(
      id: json['id'],
      titulo: json['titulo'],
    );
  }
}