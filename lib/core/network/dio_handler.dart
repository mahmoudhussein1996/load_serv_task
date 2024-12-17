import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:load_serv_task/core/network/api_consts.dart';

class DioHandler {
  final Dio dio = Dio();

  DioHandler() {
    dio.options.baseUrl = ApiConstants.apiBaseUrl;
  }

//!POST
//   Future post(
//       String path, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         bool? useToken = true,
//         bool isFormData = false,
//       }) async {
//
//     debugPrint("path = $path");
//     debugPrint("body = $data");
//
//     try {
//       var res = await dio.post(
//         path,
//         data: data,
//         options: Options(
//             headers: {
//                // "Accept-Language": "en",  // Adding the token in the header
//             }),
//         queryParameters: queryParameters,
//       );
//       debugPrint("data response = ${res.data}");
//       return res.data;
//     } on DioException catch (e) {
//       return e.response?.data;
//     }
//   }

//!GET
  Future get(
      String path, {
        Object? data,
        bool? useToken = true,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      debugPrint("path = $path");
      var res = await dio.get(
        path,
        data: data,
        options: Options(
            headers: {
              "Accept-Language": "en", // Adding the token in the header
        }),
        queryParameters: queryParameters,
      );
      debugPrint("data response = ${res.data}");
      return res.data;
    } on DioException catch (e) {
      return e.response?.data;
      //handleDioException(e);
    }
  }

//!DELETE
  Future delete(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      var res = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

//!PATCH
  Future patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false,
      }) async {
    try {
      var res = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}