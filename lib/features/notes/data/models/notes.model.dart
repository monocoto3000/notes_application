class Note {
  final int id;
  final String title;
  final String content;
  final int userId;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String categoryName;
  final String categoryColor;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryName,
    required this.categoryColor,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      userId: json['user_id'] ?? 0,
      categoryId: json['category_id'] ?? 1,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      categoryName: json['category_name'] ?? 'Sin categoria',
      categoryColor: json['category_color'] ?? '#808080',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'user_id': userId,
      'category_id': categoryId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'category_name': categoryName,
      'category_color': categoryColor,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'categoryId': categoryId,
    };
  }

  factory Note.create({
    required String title,
    required String content,
    required int categoryId,
    String categoryName = 'Sin categoria',
    String categoryColor = '#808080',
  }) {
    final now = DateTime.now();
    return Note(
      id: 0,
      title: title,
      content: content,
      userId: 0, 
      categoryId: categoryId,
      createdAt: now,
      updatedAt: now,
      categoryName: categoryName,
      categoryColor: categoryColor,
    );
  }

  Note copyWith({
    int? id,
    String? title,
    String? content,
    int? userId,
    int? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? categoryName,
    String? categoryColor,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryName: categoryName ?? this.categoryName,
      categoryColor: categoryColor ?? this.categoryColor,
    );
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, content: $content, userId: $userId, categoryId: $categoryId, createdAt: $createdAt, updatedAt: $updatedAt, categoryName: $categoryName, categoryColor: $categoryColor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Note && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

