import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/Models/category_news_model.dart';
import 'package:news_app/Models/news_channel_headline_model.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsHeadlines(
    String channelName,
  ) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=988245b82aee4903861a574811e73a29';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<CategoryNewsModel> fetchCategories(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=988245b82aee4903861a574811e73a29';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return CategoryNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
