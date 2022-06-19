import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:developer';
import '../models/error_response/error_response.dart';
import './exceptions.dart';

abstract class BaseApi {
  late Dio dio;
  final url = dotenv.env["API_URL"];

  BaseApi() {
    final options = BaseOptions(
        baseUrl: "$url",
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000);

    dio = Dio(options);
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        error: true,
        compact: true,
        responseHeader: true,
        responseBody: true,
      ));
    }
  }

  Future<Map<String, dynamic>> get<T>(
    String path, {
    Map<String, dynamic>? headers,
  }) =>
      makeRequest(
        dio.get<T>(
          path,
          options: Options(headers: headers),
        ),
      );

  Future<Map<String, dynamic>> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) =>
      makeRequest(dio.post<T>(path,
          data: data,
          options: Options(
            headers: headers,
          )));

  Future<Map<String, dynamic>> makeRequest(Future<Response> future) async {
    try {
      final req = await future;

      final data = req.data;

      if ('${req.statusCode}'.startsWith('2') ||
          (data['success'] != null && data['success'])) {
        if (data is Map<String, dynamic>) {
          return data;
        } else {
          return {'data': data};
        }
      }

      if (data['error'] != null) {
        throw Exception(data['error']);
      }

      throw Exception(data['message']);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.other) {
        throw CustomException('Connection Timeout');
      }

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response?.data != null && e.response!.data is Map) {
            throw CustomException(ErrorResponse.fromMap(e.response!.data).errors![0].detail!);
        }
        throw CustomException(e.response?.data);
      } else if ('${e.response?.statusCode}'.startsWith('5')) {
        throw CustomException('Connection  Timeout Exception');
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw CustomException(e.message);
      }
    } catch (err) {
      if (err is DioError) {
        //handle DioError here by error type or by error code

        log('dio error => ${err.response}');
        throw CustomException(err.response!.data.toString());
      } else {
        log('Check here ${err.toString()}');
        throw CustomException('Something went wrong');
      }
    }
  }

  dynamic parseErrorMessage(Map<String, dynamic>? err) {
    if (err != null) {
      if (err['message'] != null) {
        return err['message'];
      }

      if (err['error'] != null) {
        return err['error'];
      }

      if (err['errors'] != null) {
        final errors = ErrorResponse.fromMap(err);
        return errors.errors![0].detail;
      }
    }
    return 'Unknown error';
  }
}
