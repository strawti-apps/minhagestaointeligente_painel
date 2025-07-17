class QuestionModel {
  final int? id;
  final int? quizId;
  final String text;
  final int orderIndex;

  QuestionModel({
    this.id,
    this.quizId,
    required this.text,
    required this.orderIndex,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'],
      quizId: map['quizId'],
      text: map['text'],
      orderIndex: map['orderIndex'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (quizId != null) 'quizId': quizId,
      'text': text,
      'orderIndex': orderIndex,
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  QuestionModel copyWith({
    int? id,
    int? quizId,
    String? text,
    int? orderIndex,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      text: text ?? this.text,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
} 