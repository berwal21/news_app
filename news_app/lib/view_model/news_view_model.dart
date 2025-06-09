import 'package:news_app/Models/category_news_model.dart';
import 'package:news_app/Models/news_channel_headline_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsHeadlines(
    String channelName,
  ) async {
    final response = await _repo.fetchNewsHeadlines(channelName);

    return response;
  }

  Future<CategoryNewsModel> fetchCategories(String category) async {
    final response = await _repo.fetchCategories(category);

    return response;
  }
}
