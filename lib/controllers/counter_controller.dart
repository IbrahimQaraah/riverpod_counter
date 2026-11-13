
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Application State
class CounterState {
  final int count;
  final int elapsedSeconds;
  final bool isRunning;
  final String lifecycleState;

  const CounterState({
    this.count = 0,
    this.elapsedSeconds = 0,
    this.isRunning = false,
    this.lifecycleState = 'Resumed',
  });

  CounterState copyWith({
    int? count,
    int? elapsedSeconds,
    bool? isRunning,
    String? lifecycleState,
  }) {
    return CounterState(
      count: count ?? this.count,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      isRunning: isRunning ?? this.isRunning,
      lifecycleState: lifecycleState ?? this.lifecycleState,
    );
  }
}

// Controller
class CounterController extends Notifier<CounterState>
    with WidgetsBindingObserver {
  Timer? _timer;

  @override
  CounterState build() {
    WidgetsBinding.instance.addObserver(this);

    ref.onDispose(() {
      _timer?.cancel();
      WidgetsBinding.instance.removeObserver(this);
    });

    return const CounterState();
  }

  // Counter Methods
  void increment() {
    state = state.copyWith(count: state.count + 1);
  }

  void decrement() {
    if (state.count > 0) {
      state = state.copyWith(count: state.count - 1);
    }
  }

  void resetCounter() {
    state = state.copyWith(count: 0);
  }

  // Timer Methods
  void startTimer() {
    if (state.isRunning) return;

    state = state.copyWith(isRunning: true);

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        state = state.copyWith(
          elapsedSeconds: state.elapsedSeconds + 1,
        );
      },
    );
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;

    state = state.copyWith(isRunning: false);
  }

  void resetTimer() {
    pauseTimer();

    state = state.copyWith(elapsedSeconds: 0);
  }

  // App Lifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycle) {
    state = state.copyWith(
      lifecycleState: lifecycle.name,
    );

    if (lifecycle == AppLifecycleState.paused ||
        lifecycle == AppLifecycleState.inactive ||
        lifecycle == AppLifecycleState.hidden) {
      pauseTimer();
    }
  }
}
