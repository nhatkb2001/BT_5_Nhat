import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:excercise_2/blocs/newBloc/new_event.dart';
import 'package:excercise_2/models/new_model.dart';

class NewRepository {
  @override
  Future<List<NewModel>> getNewList(String page) async {
    final Dio _dio = Dio();
    List<NewModel> newList = [];
    final _baseUrl = 'http://18.218.244.144/intern/apis/news?page=$page';
    Response newData = await _dio.get(_baseUrl);
    List respon = newData.data;
    try {
      respon.forEach((element) {
        newList.add(NewModel.fromJson(element));
      });
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return newList;
  }
}
