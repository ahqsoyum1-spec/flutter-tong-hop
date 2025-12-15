
import 'package:dio/dio.dart';
import 'package:flutter_exercises_collection/bai_tap/bai9/model/new.dart';

class NewsService {
  final String apiKey = "32e4b57a6e9541438d04336b1a5d3eb6";

  Future<List<New>> fetchTopHeadlines() async {
    final url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey";
    final dio = Dio();

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        List articles = data["articles"] ?? [];

        return articles.map((e) => New.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load news, status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load news: $e");
    }
  }
}
