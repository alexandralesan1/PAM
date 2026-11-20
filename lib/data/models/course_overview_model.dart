import '../../domain/entities/course_overview.dart';

class LessonModel extends Lesson {
  const LessonModel({
    required super.id,
    required super.title,
    required super.duration,
    required super.durationSeconds,
    required super.completed,
    required super.locked,
  });

  // JSON -> obiect (deserializare)
  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
        id: json['id'] as String,
        title: json['title'] as String,
        duration: json['duration'] as String,
        durationSeconds: json['durationSeconds'] as int,
        completed: json['completed'] as bool,
        locked: json['locked'] as bool,
      );

  // obiect -> JSON (serializare)
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'duration': duration,
        'durationSeconds': durationSeconds,
        'completed': completed,
        'locked': locked,
      };
}

class CourseOverviewModel extends CourseOverview {
  const CourseOverviewModel({
    required super.title,
    required super.duration,
    required super.heroLabel,
    required super.heroImageUrl,
    required super.description,
    required super.priceLabel,
    required super.enrollLabel,
    required super.lessonCount,
    required super.videoCount,
    required super.classCount,
    required super.rating,
    required super.enrollEnabled,
    required super.lessons,
  });

  /// [json] este răspunsul de la /feed/details (cu cheile `course` și `actions`).
  factory CourseOverviewModel.fromJson(Map<String, dynamic> json) {
    final course = json['course'] as Map<String, dynamic>;
    final hero = course['hero'] as Map<String, dynamic>;
    final actions = json['actions'] as Map<String, dynamic>;
    final price = actions['price'] as Map<String, dynamic>;
    final enroll = actions['enroll'] as Map<String, dynamic>;

    return CourseOverviewModel(
      title: course['title'] as String,
      duration: course['duration'] as String,
      lessonCount: course['lessonCount'] as int,
      rating: (course['rating'] as num).toDouble(),
      heroLabel: hero['label'] as String,
      heroImageUrl: hero['imageUrl'] as String,
      videoCount: hero['videoCount'] as int,
      classCount: hero['classCount'] as int,
      description:
          (course['description'] as Map<String, dynamic>)['text'] as String,
      lessons: (course['lessons'] as List)
          .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceLabel: price['label'] as String,
      enrollLabel: enroll['label'] as String,
      enrollEnabled: enroll['enabled'] as bool,
    );
  }

  /// Serializează câmpurile pe care le păstrează modelul.
  Map<String, dynamic> toJson() => {
        'course': {
          'title': title,
          'duration': duration,
          'lessonCount': lessonCount,
          'rating': rating,
          'hero': {
            'label': heroLabel,
            'imageUrl': heroImageUrl,
            'videoCount': videoCount,
            'classCount': classCount,
          },
          'lessons': lessons.cast<LessonModel>().map((l) => l.toJson()).toList(),
          'description': {'text': description},
        },
        'actions': {
          'price': {'label': priceLabel},
          'enroll': {'label': enrollLabel, 'enabled': enrollEnabled},
        },
      };
}
