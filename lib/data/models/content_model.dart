class ContentModel {
  final String url;
  final String type; // image / video
  final int duration; // seconds

  ContentModel({
    required this.url,
    required this.type,
    required this.duration,
  });

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      url: map['url'],
      type: map['type'],
      duration: map['duration'],
    );
  }
}