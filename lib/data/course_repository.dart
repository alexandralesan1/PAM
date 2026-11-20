import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/course_overview.dart';
import '../models/home_data.dart';

class CourseRepository {
  Future<Map<String, dynamic>> _readJson() async {
    await Future.delayed(const Duration(seconds: 1)); // simulare încărcare
    final raw = await rootBundle.loadString('assets/data/lab_v4.json');
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<CourseOverview> load() async {
    final map = await _readJson();
    return CourseOverview.fromJson(map['courseOverviewPage']);
  }

  Future<HomeData> loadHome() async {
    final map = await _readJson();
    return HomeData.fromJson(map['homePage']);
  }
}