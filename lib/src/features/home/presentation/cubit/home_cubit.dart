import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_msar/src/features/home/domain/entities/home_stats.dart';
import 'package:admin_msar/src/features/home/domain/use_cases/watch_home_stats_use_case.dart';
import 'package:admin_msar/src/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._watchStats) : super(const HomeInitial()) {
    _subscription = _watchStats().listen(
      (stats) => emit(HomeLoaded(stats)),
      onError: (_) => emit(const HomeError('تعذر تحميل الإحصائيات')),
    );
  }

  final WatchHomeStatsUseCase _watchStats;
  StreamSubscription<HomeStats>? _subscription;

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
