import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/course_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CourseRepository repo;
  HomeCubit(this.repo) : super(HomeLoading());

  Future<void> load() async {
    emit(HomeLoading());
    try {
      emit(HomeSuccess(await repo.loadHome()));
    } catch (e) {
      emit(HomeError('Nu s-au putut încărca datele'));
    }
  }
}