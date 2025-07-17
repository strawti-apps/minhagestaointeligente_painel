class MaterialModel {
  final int? id;
  final String title;
  final String fileUrl;
  final DateTime? createdAt;

  MaterialModel({
    this.id,
    required this.title,
    required this.fileUrl,
    this.createdAt,
  });

  factory MaterialModel.fromMap(Map<String, dynamic> map) {
    return MaterialModel(
      id: map['id'],
      title: map['title'],
      fileUrl: map['fileUrl'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'fileUrl': fileUrl,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  MaterialModel copyWith({
    int? id,
    String? title,
    String? fileUrl,
    DateTime? createdAt,
  }) {
    return MaterialModel(
      id: id ?? this.id,
      title: title ?? this.title,
      fileUrl: fileUrl ?? this.fileUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
