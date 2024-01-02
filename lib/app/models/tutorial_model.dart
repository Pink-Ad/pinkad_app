class TutorialModal {
  final int? id;
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? video;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TutorialModal({
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.video,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  TutorialModal.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        thumbnail = json['thumbnail'] as String?,
        video = json['video'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt = json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String);
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'thumbnail': thumbnail,
        'video': video,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
