import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/error/failures.dart';
import '../../domain/usecases/get_course_details.dart';
import 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final GetCourseDetails getCourseDetails;
  CourseCubit(this.getCourseDetails) : super(CourseLoading());

  Future<void> load() async {
    emit(CourseLoading());
    try {
      final data = await getCourseDetails();
      emit(data.lessons.isEmpty ? CourseEmpty() : CourseSuccess(data));
    } on Failure catch (f) {
      emit(CourseError(f.message));
    } catch (_) {
      emit(CourseError('A apărut o eroare neașteptată.'));
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
