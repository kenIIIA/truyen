import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:truyen_full/model/category.dart';
import 'package:truyen_full/model/chapter/chapter.dart';
import 'package:truyen_full/service/api.dart';

import '../../model/chapter/chapter_id.dart';
import '../../model/story/story.dart';
part 'category_api.g.dart';

@RestApi()
abstract class CategoryApi {
  factory CategoryApi(Dio dio, {String baseUrl}) = _CategoryApi;

  factory CategoryApi.client({bool? isLoading}) {
    return CategoryApi(
        ClientApi().init()..options.headers['isLoading'] = isLoading);
  }

  @GET('/category')
  Future<List<Category>> getCategory();

  @GET('/category/id/{id}/story')
  Future<List<StoryModel>> getStory(@Path('id') id);

  @GET('/story/{slug}/chapters')
  Future<List<ChapterModel>> getChapters(@Path('slug') slug);

  @GET('/chapter/id/{id}')
  Future<ChapterIDModel> getChaptersID(@Path('id') id);
}
