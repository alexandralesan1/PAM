class Lesson {
  final String id;
  final String title;
  final String duration;
  final int durationSeconds;
  final bool completed;
  final bool locked;

  const Lesson({
    required this.id,
    required this.title,
    required this.duration,
    required this.durationSeconds,
    required this.completed,
    required this.locked,
  });
}

class CourseOverview {
  final String title;
  final String duration;
  final String heroLabel;
  final String heroImageUrl;
  final String description;
  final String priceLabel;
  final String enrollLabel;
  final int lessonCount;
  final int videoCount;
  final int classCount;
  final double rating;
  final bool enrollEnabled;
  final List<Lesson> lessons;

  const CourseOverview({
    required this.title,
    required this.duration,
    required this.heroLabel,
    required this.heroImageUrl,
    required this.description,
    required this.priceLabel,
    required this.enrollLabel,
    required this.lessonCount,
    required this.videoCount,
    required this.classCount,
    required this.rating,
    required this.enrollEnabled,
    required this.lessons,
  });
}
