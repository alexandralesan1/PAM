import '../../domain/entities/home_data.dart';

class PlanItemModel extends PlanItem {
  const PlanItemModel({
    required super.id,
    required super.title,
    required super.completed,
    required super.total,
    required super.progress,
  });

  factory PlanItemModel.fromJson(Map<String, dynamic> json) => PlanItemModel(
        id: json['id'] as String,
        title: json['title'] as String,
        completed: json['completed'] as int,
        total: json['total'] as int,
        progress: (json['progress'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'completed': completed,
        'total': total,
        'progress': progress,
      };
}

class HomeModel extends HomeData {
  const HomeModel({
    required super.greeting,
    required super.subtitle,
    required super.avatarUrl,
    required super.learnedTitle,
    required super.myCoursesLabel,
    required super.learnedMinutes,
    required super.goalMinutes,
    required super.learnedProgress,
    required super.promptTitle,
    required super.promptAction,
    required super.planTitle,
    required super.plan,
    required super.meetupTitle,
    required super.meetupSubtitle,
  });

  /// [json] este răspunsul de la /feed.
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final header = json['header'] as Map<String, dynamic>;
    final learned = json['learnedToday'] as Map<String, dynamic>;
    final myCourses = json['myCourses'] as Map<String, dynamic>;
    final prompt = json['learningPrompt'] as Map<String, dynamic>;
    final plan = json['learningPlan'] as Map<String, dynamic>;
    final meetup = json['meetup'] as Map<String, dynamic>;

    return HomeModel(
      greeting: header['greeting'] as String,
      subtitle: header['subtitle'] as String,
      avatarUrl: header['avatarUrl'] as String,
      learnedTitle: learned['title'] as String,
      learnedMinutes: learned['learnedMinutes'] as int,
      goalMinutes: learned['goalMinutes'] as int,
      learnedProgress: (learned['progress'] as num).toDouble(),
      myCoursesLabel: myCourses['actionLabel'] as String,
      promptTitle: prompt['title'] as String,
      promptAction: prompt['actionLabel'] as String,
      planTitle: plan['title'] as String,
      plan: (plan['items'] as List)
          .map((e) => PlanItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meetupTitle: meetup['title'] as String,
      meetupSubtitle: meetup['subtitle'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'header': {
          'greeting': greeting,
          'subtitle': subtitle,
          'avatarUrl': avatarUrl,
        },
        'learnedToday': {
          'title': learnedTitle,
          'learnedMinutes': learnedMinutes,
          'goalMinutes': goalMinutes,
          'progress': learnedProgress,
        },
        'myCourses': {'actionLabel': myCoursesLabel},
        'learningPrompt': {'title': promptTitle, 'actionLabel': promptAction},
        'learningPlan': {
          'title': planTitle,
          'items': plan.cast<PlanItemModel>().map((p) => p.toJson()).toList(),
        },
        'meetup': {'title': meetupTitle, 'subtitle': meetupSubtitle},
      };
}
