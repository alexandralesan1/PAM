import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/course_repository.dart';
import 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepository repo;
  CourseCubit(this.repo) : super(CourseLoading());

  Future<void> load() async {
    emit(CourseLoading());
    try {
      final data = await repo.load();
      emit(data.lessons.isEmpty ? CourseEmpty() : CourseSuccess(data));
    } catch (e) {
      emit(CourseError('Nu s-au putut încărca datele'));
    }
  }

  void selectTab(bool showLessons) {
    final s = state;
    if (s is CourseSuccess) emit(s.copyWith(showLessons: showLessons));
  }

  void setQuery(String query) {
    final s = state;
    if (s is CourseSuccess) emit(s.copyWith(query: query));
  }

  void setFilter(LessonFilter filter) {
    final s = state;
    if (s is CourseSuccess) emit(s.copyWith(filter: filter));
  }

  void setSort(LessonSort sort) {
    final s = state;
    if (s is CourseSuccess) emit(s.copyWith(sort: sort));
  }

  void toggleFavorite(String lessonId) {
    final s = state;
    if (s is CourseSuccess) {
      final favs = Set<String>.from(s.favorites);
      if (!favs.add(lessonId)) favs.remove(lessonId);
      emit(s.copyWith(favorites: favs));
    }
  }
}
