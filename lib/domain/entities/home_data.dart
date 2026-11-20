class PlanItem {
  final String id;
  final String title;
  final int completed;
  final int total;
  final double progress;

  const PlanItem({
    required this.id,
    required this.title,
    required this.completed,
    required this.total,
    required this.progress,
  });
}

class HomeData {
  final String greeting;
  final String subtitle;
  final String avatarUrl;
  final String learnedTitle;
  final String myCoursesLabel;
  final int learnedMinutes;
  final int goalMinutes;
  final double learnedProgress;
  final String promptTitle;
  final String promptAction;
  final String planTitle;
  final List<PlanItem> plan;
  final String meetupTitle;
  final String meetupSubtitle;

  const HomeData({
    required this.greeting,
    required this.subtitle,
    required this.avatarUrl,
    required this.learnedTitle,
    required this.myCoursesLabel,
    required this.learnedMinutes,
    required this.goalMinutes,
    required this.learnedProgress,
    required this.promptTitle,
    required this.promptAction,
    required this.planTitle,
    required this.plan,
    required this.meetupTitle,
    required this.meetupSubtitle,
  });
}
