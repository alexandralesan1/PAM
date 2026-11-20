class Lesson {
  final String id, title, duration;
  final int durationSeconds;
  final bool completed, locked;

  Lesson.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        title = j['title'],
        duration = j['duration'],
        durationSeconds = j['durationSeconds'],
        completed = j['completed'],
        locked = j['locked'];
}

class CourseOverview {
  final String title, duration, heroLabel, heroImageUrl, description;
  final String priceLabel, enrollLabel;
  final int lessonCount, videoCount, classCount;
  final double rating;
  final bool enrollEnabled;
  final List<Lesson> lessons;

  CourseOverview.fromJson(Map<String, dynamic> j)
      : title = j['course']['title'],
        duration = j['course']['duration'],
        lessonCount = j['course']['lessonCount'],
        rating = (j['course']['rating'] as num).toDouble(),
        heroLabel = j['course']['hero']['label'],
        heroImageUrl = j['course']['hero']['imageUrl'],
        videoCount = j['course']['hero']['videoCount'],
        classCount = j['course']['hero']['classCount'],
        description = j['course']['description']['text'],
        lessons = (j['course']['lessons'] as List)
            .map((e) => Lesson.fromJson(e))
            .toList(),
        priceLabel = j['actions']['price']['label'],
        enrollLabel = j['actions']['enroll']['label'],
        enrollEnabled = j['actions']['enroll']['enabled'];
}