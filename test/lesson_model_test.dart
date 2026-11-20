import 'package:flutter_test/flutter_test.dart';
import 'package:laab2/data/models/course_overview_model.dart';

void main() {
  test('LessonModel: fromJson si toJson', () {
    final json = <String, dynamic>{
      'id': 'lesson-1',
      'title': 'Introduction to React',
      'duration': '04:28',
      'durationSeconds': 268,
      'completed': false,
      'locked': false,
    };

    final lesson = LessonModel.fromJson(json);

    expect(lesson.title, 'Introduction to React');
    expect(lesson.durationSeconds, 268);
    expect(lesson.toJson(), json);
  });
}
