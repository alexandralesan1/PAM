import '../entities/course_overview.dart';
import '../entities/home_data.dart';

/// Contractul pe care Domain îl cere. Data îl implementează.
abstract class AppRepository {
  Future<HomeData> getHome();
  Future<CourseOverview> getCourseDetails();
}
