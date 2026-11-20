import '../entities/home_data.dart';
import '../repositories/app_repository.dart';

class GetHome {
  final AppRepository repository;
  const GetHome(this.repository);

  Future<HomeData> call() => repository.getHome();
}
