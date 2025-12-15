import 'package:dio/dio.dart';
import 'package:flutter_exercises_collection/bai_tap/bai10/product.dart';

class API {
  Future<List<Product>> getAllProduct() async {
    // async là rẽ nhánh --> await
    var url = 'https://fakestoreapi.com/products';
    var dio = Dio();
    var response = await dio.request(url);
    List<Product> ls = [];
    if (response.statusCode == 200) {
      List data = response.data;
      ls = data.map((json) => Product.fromJson(json)).toList();
    } else {
      print('Loi');
    }
    return ls;
  }
}

var test_api = API();
