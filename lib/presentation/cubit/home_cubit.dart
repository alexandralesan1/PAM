import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/error/failures.dart';
import '../../domain/usecases/get_home.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHome getHome;
  HomeCubit(this.getHome) : super(HomeLoading());

  Future<void> load() async {
    emit(HomeLoading());
    try {
      emit(HomeSuccess(await getHome()));
    } on Failure catch (f) {
      emit(HomeError(f.message));
    } catch (_) {
      emit(HomeError('A apărut o eroare neașteptată.'));
    }
  }
}
