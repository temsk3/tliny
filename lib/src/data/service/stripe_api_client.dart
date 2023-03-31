import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

final secretKey = dotenv.get('STRIPE_SECRET');

final logger = Logger();

class Server1 {
  Future<String> createCheckout(String priceId) async {
    final auth = 'Basic ${base64Encode(utf8.encode('$secretKey:'))}';
    const url = 'https://api.stripe.com/v1/checkout/sessions';
    final body = {
      'payment_method_types': ['card'],
      'line_items': [
        {
          'price': priceId,
          'quantity': 1,
        }
      ],
      'mode': 'payment',
      'success_url': 'https://success.com/{CHECKOUT_SESSION_ID}',
      'cancel_url': 'https://cancel.com/',
    };
    final options = Options(
      headers: {HttpHeaders.authorizationHeader: auth},
      contentType: 'application/x-www-form-urlencoded',
    );
    try {
      final dio = Dio();
      final response = await dio.post(
        url,
        data: body,
        options: options,
      );
      final responseData = _response(response);
      return responseData['id'].toString();
    } on DioError catch (e) {
      logger.e('DioError', [e.response]);
      rethrow;
    } on Exception catch (e, s) {
      logger.e(e, [e, s]);
      rethrow;
    }
  }
}

dynamic _response(Response response) {
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
