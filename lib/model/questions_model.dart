class Questionario {
  final int id;
  final String titulo;
  final List<Questao> questoes;

  Questionario({
    required this.id,
    required this.titulo,
    required this.questoes,
  });

  factory Questionario.fromJson(Map<String, dynamic> json) {
    List<dynamic> questoesJson = json['questoes'];
    List<Questao> questoes = questoesJson.map((e) => Questao.fromJson(e)).toList();

    return Questionario(
      id: json['id'],
      titulo: json['titulo'],
      questoes: questoes,
    );
  }
}

class Questao {
  final int id;
  final String titulo;
  final String pergunta;
  final int gabarito;
  final List<Alternativa> alternativas;

  Questao({
    required this.id,
    required this.titulo,
    required this.pergunta,
    required this.gabarito,
    required this.alternativas,
  });

  factory Questao.fromJson(Map<String, dynamic> json) {
    List<dynamic> alternativasJson = json['alternativas'];
    List<Alternativa> alternativas = alternativasJson.map((e) => Alternativa.fromJson(e)).toList();

    return Questao(
      id: json['id'],
      titulo: json['titulo'],
      pergunta: json['pergunta'],
      gabarito: json['gabarito'],
      alternativas: alternativas,
    );
  }
}

class Alternativa {
  final int id;
  final String titulo;

  Alternativa({
    required this.id,
    required this.titulo,
  });

  factory Alternativa.fromJson(Map<String, dynamic> json) {
    return Alternativa(
      id: json['id'],
      titulo: json['titulo'],
    );
  }
}