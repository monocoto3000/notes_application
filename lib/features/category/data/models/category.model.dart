class Category {
  final int id;
  final String name;
  final String color;
  final bool isDefault;
  final int? userId;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.name,
    required this.color,
    required this.isDefault,
    this.userId,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      color: json['color'] as String,
      isDefault: (json['is_default'] as int) == 1,
      userId: json['user_id'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'is_default': isDefault ? 1 : 0,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
      'is_default': isDefault ? 1 : 0,
      'user_id': userId,
    };
  }

  factory Category.create({
    required String name,
    required String color,
    bool isDefault = false,
    int? userId,
  }) {
    return Category(
      id: 0,
      name: name,
      color: color,
      isDefault: isDefault,
      userId: userId,
      createdAt: DateTime.now(),
    );
  }

  Category copyWith({
    int? id,
    String? name,
    String? color,
    bool? isDefault,
    int? userId,
    DateTime? createdAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, color: $color, isDefault: $isDefault, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}