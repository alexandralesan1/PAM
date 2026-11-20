class PlanItem {
  final String id, title;
  final int completed, total;
  final double progress;

  PlanItem.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        title = j['title'],
        completed = j['completed'],
        total = j['total'],
        progress = (j['progress'] as num).toDouble();
}

class HomeData {
  final String greeting, subtitle, avatarUrl;
  final String learnedTitle, myCoursesLabel;
  final int learnedMinutes, goalMinutes;
  final double learnedProgress;
  final String promptTitle, promptAction;
  final String planTitle;
  final List<PlanItem> plan;
  final String meetupTitle, meetupSubtitle;

  HomeData.fromJson(Map<String, dynamic> j)
      : greeting = j['header']['greeting'],
        subtitle = j['header']['subtitle'],
        avatarUrl = j['header']['avatarUrl'],
        learnedTitle = j['learnedToday']['title'],
        learnedMinutes = j['learnedToday']['learnedMinutes'],
        goalMinutes = j['learnedToday']['goalMinutes'],
        learnedProgress = (j['learnedToday']['progress'] as num).toDouble(),
        myCoursesLabel = j['myCourses']['actionLabel'],
        promptTitle = j['learningPrompt']['title'],
        promptAction = j['learningPrompt']['actionLabel'],
        planTitle = j['learningPlan']['title'],
        plan = (j['learningPlan']['items'] as List)
            .map((e) => PlanItem.fromJson(e))
            .toList(),
        meetupTitle = j['meetup']['title'],
        meetupSubtitle = j['meetup']['subtitle'];
}