import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';
import '../models/course_overview_model.dart';
import '../models/home_model.dart';

abstract class RemoteDataSource {
  Future<HomeModel> fetchHome();
  Future<CourseOverviewModel> fetchCourseDetails();
}

/// Singurul loc din aplicație care vorbește cu serverul (HTTP).
class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<HomeModel> fetchHome() async {
    final json = await _getJson(ApiConstants.feed);
    try {
      return HomeModel.fromJson(json);
    } catch (_) {
      throw const ParsingException();
    }
  }

  @override
  Future<CourseOverviewModel> fetchCourseDetails() async {
    final json = await _getJson(ApiConstants.feedDetails);
    try {
      return CourseOverviewModel.fromJson(json);
    } catch (_) {
      throw const ParsingException();
    }
  }

  Future<Map<String, dynamic>> _getJson(String path) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$path');
    final response = await _request(uri);

    if (response.statusCode != 200) {
      throw ServerException(response.statusCode);
    }

    try {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is! Map<String, dynamic>) throw const FormatException();
      return decoded;
    } on FormatException {
      throw const ParsingException();
    }
  }

  Future<http.Response> _request(Uri uri) async {
    try {
      return await client
          .get(uri, headers: const {'Accept': 'application/json'})
          .timeout(ApiConstants.timeout);
    } on TimeoutException {
      throw const NetworkException();
    } on SocketException {
      throw const NetworkException();
    } on http.ClientException {
      throw const NetworkException();
    }
  }
}
