import 'package:json_annotation/json_annotation.dart';

part 'chapter.g.dart';

@JsonSerializable()
class ChapterModel {
  int id;
  String header;
  String slug;
  int viewCount;
  String updatedDate;

  StoryChapter story;

  ChapterModel({
    required this.id,
    required this.header,
    required this.slug,
    required this.viewCount,
    required this.updatedDate,
    required this.story,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterModelToJson(this);
}

@JsonSerializable()
class StoryChapter {
  int id;
  String slug;

  StoryChapter({
    required this.id,
    required this.slug,
  });

  factory StoryChapter.fromJson(Map<String, dynamic> json) =>
      _$StoryChapterFromJson(json);

  Map<String, dynamic> toJson() => _$StoryChapterToJson(this);
}
