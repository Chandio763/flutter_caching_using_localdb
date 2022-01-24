import 'dart:convert';

class UserPost {
    int userId;
    int id;
    String title;
    String body;

  static String userIdKey = 'userId';
  static String idKey = 'id';
  static String titleKey = 'title';
  static String bodyKey = 'body';
  static String tableName = 'Posts';
  static String createTable = 'CREATE TABLE $tableName ($userIdKey INTEGER , $idKey INTEGER , $titleKey TEXT, $bodyKey TEXT)';

  UserPost({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
    

  UserPost copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return UserPost(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory UserPost.fromMap(Map<String, dynamic> map) {
    return UserPost(
      userId: map['userId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPost.fromJson(String source) => UserPost.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserPost(userId: $userId, id: $id, title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserPost &&
      other.userId == userId &&
      other.id == id &&
      other.title == title &&
      other.body == body;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      id.hashCode ^
      title.hashCode ^
      body.hashCode;
  }
  }