import 'package:dio/dio.dart';
import 'package:excercise_2/models/new_model.dart';

class DioClient {
  final Dio _dio = Dio();
  NewModel? n;
  List<NewModel> newList = [];
  final _baseUrl = 'http://18.218.244.144/intern/apis/news?page=1';
}
