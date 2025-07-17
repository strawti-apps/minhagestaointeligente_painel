class OptionModel {
  final int? id;
  final int? questionId;
  final String text;
  final bool isCorrect;

  OptionModel({
    this.id,
    this.questionId,
    required this.text,
    required this.isCorrect,
  });

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      id: map['id'],
      questionId: map['questionId'],
      text: map['text'],
      isCorrect: map['isCorrect'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (questionId != null) 'questionId': questionId,
      'text': text,
      'isCorrect': isCorrect,
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  OptionModel copyWith({
    int? id,
    int? questionId,
    String? text,
    bool? isCorrect,
  }) {
    return OptionModel(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
} 