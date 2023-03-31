import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../model/zip_code/zipcode_model.dart';

// part 'zip_code_api.g.dart';

// @RestApi(baseUrl: "https://zipcloud.ibsnet.co.jp")
// abstract class ZipCodeToAddressApiClient {
//   factory ZipCodeToAddressApiClient(Dio dio, {String baseUrl}) =
//       _ZipCodeToAddressApiClient;

//   @GET("/api/search")
//   Future<List<Address>?> getZipCodeToAddress(@Query("zipcode") String zipcode);
// }

final logger = Logger();

class ZipCodeToAddressApiClient {
  Future<List<Address>?> getZipCodeToAddress(String zipcode) async {
    try {
      final dio = Dio();
      final url = 'https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipcode';
      final response = await dio.get(url);
      final responseData = _response(response);
      if (responseData['results'] == null) {
        return null;
      }
      final data = responseData['results'] as List<dynamic>;
      final list = data
          .map((value) => Address.fromJson(value as Map<String, dynamic>))
          .toList();
      logger.i(list);
      return list;
    } on Exception {
      rethrow;
    }
  }
}

dynamic _response(Response<dynamic> response) {
  switch (response.statusCode) {
    case 200:
      final responseJson = jsonDecode(response.data.toString());
      return responseJson;
    case 400:
      // 400 Bad Request : 一般的なクライアントエラー
      throw Exception('一般的なクライアントエラーです');
    case 401:
      // 401 Unauthorized : アクセス権がない、または認証に失敗
      throw Exception('アクセス権限がない、または認証に失敗しました');
    case 403:
      // 403 Forbidden ： 閲覧権限がないファイルやフォルダ
      throw Exception('閲覧権限がないファイルやフォルダです');
    case 500:
      // 500 何らかのサーバー内で起きたエラー
      throw Exception('何らかのサーバー内で起きたエラーです');
    default:
      // それ以外の場合
      throw Exception('何かしらの問題が発生しています');
  }
}
