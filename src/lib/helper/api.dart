import 'dart:convert';

import 'package:dio/dio.dart';

class Api {
  final Dio dio;
  Api({required this.dio});
  Future<dynamic> get({
    required String url,
    String? token,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Map<String, String> header = {};
      if (token != null) {
        header.addAll({
          'Authorization': 'Bearer $token',
        });
      }

      final response = await dio.get(
        url,
        options: Options(
          headers: header,
        ),
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        print("api is working");
        return response.data;
      } else {
        throw Exception('error in status code${response.statusCode}');
      }
    } catch (e) {
      throw Exception('error to fetch data $e');
    }
  }

  Future<dynamic> post({
    required String url,
    dynamic? body,
    String? token,
  }) async {
    Map<String, String> header = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    if (token != null) {
      header.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    Response response = await dio.post(url,
        data: jsonEncode(body),
        options: Options(
          headers: header,
        ));
    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else if (response.data is String) {
        return response.data;
      } else {
        return jsonDecode(response.data);
      }
    } else {
      throw Exception(
          'error in status code${response.statusCode}  with body ${response.data}');
    }
  }

  Future<dynamic> put({
    required String url,
    dynamic body,
    String? token,
    bool isFormData = false,
  }) async {
    try {
      Map<String, String> header = {
        'accept': '*/*',
        if (!isFormData) 'Content-Type': 'application/json',
      };

      if (token != null) {
        header.addAll({
          'Authorization': 'Bearer $token',
        });
      }

      final data = isFormData ? body : jsonEncode(body);

      final response = await dio.put(
        url,
        data: data,
        options: Options(
          headers: header,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else if (response.data is String && response.data.isNotEmpty) {
          return jsonDecode(response.data);
        }
        return response.data;
      } else {
        throw Exception('Error in status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in PUT request: $e');
    }
  }

  Future<dynamic> delete({
    required String url,
    dynamic? body,
    String? token,
  }) async {
    Map<String, String> header = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    if (token != null) {
      header.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    Response response = await dio.delete(
      url,
      data: body != null ? jsonEncode(body) : null,
      options: Options(
        headers: header,
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else if (response.data is String && response.data.isNotEmpty) {
        return jsonDecode(response.data);
      }
      return null;
    } else {
      throw Exception(
          'error in status code ${response.statusCode} with body ${response.data}');
    }
  }
}
