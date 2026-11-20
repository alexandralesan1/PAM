import '../entities/course_overview.dart';
import '../repositories/app_repository.dart';

class GetCourseDetails {
  final AppRepository repository;
  const GetCourseDetails(this.repository);

  Future<CourseOverview> call() => repository.getCourseDetails();
}
