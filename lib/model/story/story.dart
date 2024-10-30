import 'package:json_annotation/json_annotation.dart';

import '../category.dart';

part 'story.g.dart';

@JsonSerializable()
class StoryModel {
  int id;
  String title;
  String author;
  String slug;
  List<String> description;
  String poster;
  List<String> categoryList;
  String status;
  String uploadDate;
  String updatedDate;
  List<Category>? categories;

  StoryModel({
    required this.id,
    required this.title,
    required this.author,
    required this.slug,
    required this.description,
    required this.poster,
    required this.categoryList,
    required this.status,
    required this.uploadDate,
    required this.updatedDate,
    this.categories,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryModelToJson(this);
}
