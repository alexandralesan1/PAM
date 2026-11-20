import 'package:equatable/equatable.dart';
import '../models/course_overview.dart';

enum LessonFilter { all, available, locked, favorites }

enum LessonSort { none, shortest, longest }

abstract class CourseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CourseLoading extends CourseState {}

class CourseEmpty extends CourseState {}

class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
  @override
  List<Object?> get props => [message];
}

class CourseSuccess extends CourseState {
  final CourseOverview data;
  final bool showLessons;
  final String query;
  final LessonFilter filter;
  final LessonSort sort;
  final Set<String> favorites;

  CourseSuccess(
      this.data, {
        this.showLessons = true,
        this.query = '',
        this.filter = LessonFilter.all,
        this.sort = LessonSort.none,
        this.favorites = const {},
      });

  CourseSuccess copyWith({
    bool? showLessons,
    String? query,
    LessonFilter? filter,
    LessonSort? sort,
    Set<String>? favorites,
  }) =>
      CourseSuccess(
        data,
        showLessons: showLessons ?? this.showLessons,
        query: query ?? this.query,
        filter: filter ?? this.filter,
        sort: sort ?? this.sort,
        favorites: favorites ?? this.favorites,
      );

  /// Lecțiile după căutare + filtrare + sortare.
  List<Lesson> get visibleLessons {
    final q = query.trim().toLowerCase();
    final list = data.lessons.where((l) {
      if (q.isNotEmpty && !l.title.toLowerCase().contains(q)) return false;
      return switch (filter) {
        LessonFilter.all => true,
        LessonFilter.available => !l.locked,
        LessonFilter.locked => l.locked,
        LessonFilter.favorites => favorites.contains(l.id),
      };
    }).toList();

    if (sort == LessonSort.shortest) {
      list.sort((a, b) => a.durationSeconds.compareTo(b.durationSeconds));
    } else if (sort == LessonSort.longest) {
      list.sort((a, b) => b.durationSeconds.compareTo(a.durationSeconds));
    }
    return list;
  }

  @override
  List<Object?> get props =>
      [data, showLessons, query, filter, sort, favorites];
}