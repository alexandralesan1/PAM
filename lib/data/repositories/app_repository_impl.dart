import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/course_overview.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/repositories/app_repository.dart';
import '../datasources/remote_data_source.dart';

/// Implementează contractul din Domain și transformă
/// excepțiile tehnice (Exception) în erori pentru utilizator (Failure).
class AppRepositoryImpl implements AppRepository {
  final RemoteDataSource remote;
  const AppRepositoryImpl({required this.remote});

  @override
  Future<HomeData> getHome() => _guard(remote.fetchHome);

  @override
  Future<CourseOverview> getCourseDetails() => _guard(remote.fetchCourseDetails);

  Future<T> _guard<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on NetworkException {
      throw const NetworkFailure();
    } on ServerException catch (e) {
      throw ServerFailure('Serverul a răspuns cu eroare (cod ${e.statusCode}).');
    } on ParsingException {
      throw const ParsingFailure();
    }
  }
}
