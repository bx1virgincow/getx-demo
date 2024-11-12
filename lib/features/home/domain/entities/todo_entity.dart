class TodoEntity {
  final int? localId;
  final int? id;
  final int? userId;
  final String? title;
  final String? body;

  TodoEntity({
    this.localId,
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'localId': localId,
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  factory TodoEntity.fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      localId: json['localId'],
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  factory TodoEntity.fromMap(Map<String, dynamic> map) {
    return TodoEntity(
      localId: map['localId'],
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      body: map['body'],
    );
  }
}
