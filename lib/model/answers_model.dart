class Answer {
  final String id;
  final AnswerDetails respostas;

  Answer({
    required this.id,
    required this.respostas,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      respostas: AnswerDetails.fromJson(json['respostas']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'respostas': respostas.toJson(),
    };
  }
}

class AnswerDetails {
  final int id;
  final List<Questao> questoes;

  AnswerDetails({
    required this.id,
    required this.questoes,
  });

  factory AnswerDetails.fromJson(Map<String, dynamic> json) {
    return AnswerDetails(
      id: json['id'],
      questoes: List<Questao>.from(
        json['questoes'].map((questao) => Questao.fromJson(questao)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questoes': questoes.map((questao) => questao.toJson()).toList(),
    };
  }
}

class Questao {
  final int id;
  final int resposta;

  Questao({
    required this.id,
    required this.resposta,
  });

  factory Questao.fromJson(Map<String, dynamic> json) {
    return Questao(
      id: json['id'],
      resposta: json['resposta'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resposta': resposta,
    };
  }
}