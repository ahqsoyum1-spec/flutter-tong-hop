
import 'package:dio/dio.dart';
import 'package:flutter_exercises_collection/bai_tap/bai9/model/new.dart';
class NewsService {
  final Dio dio = Dio();

  NewsService() {
    dio.options.baseUrl = "https://newsapi.org/v2/";

    // Thêm interceptor để tự động thêm API Key
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters["apiKey"] = "YOUR_API_KEY";
          return handler.next(options);
        },
      ),
    );
  }

  Future<List<New>> fetchTopHeadlines() async {
    try {
      final response = await dio.get(
        "top-headlines",
        queryParameters: {
          "country": "us",
        },
      );

      final data = response.data;
      List articles = data["new"];

      return articles.map((e) => New.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch news: $e");
    }
  }
}
