import 'package:json_annotation/json_annotation.dart';

import '../story/story.dart';

part 'chapter_id.g.dart';

@JsonSerializable()
class ChapterIDModel {
  int id;
  String header;
  String slug;
  List<String> body;
  int viewCount;
  String uploadDate;
  String updatedDate;
  StoryModel story;

  ChapterIDModel({
    required this.id,
    required this.header,
    required this.slug,
    required this.body,
    required this.viewCount,
    required this.uploadDate,
    required this.updatedDate,
    required this.story,
  });

  factory ChapterIDModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterIDModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterIDModelToJson(this);
}
