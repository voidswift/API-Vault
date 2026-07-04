import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/security/app_state.dart';

class AppStateNotifier extends Notifier<AppState> {
  @override
  AppState build() {
    return AppState.initial;
  }

  void updateState(AppState state) {
    this.state = state;
  }
}

final appStateProvider = NotifierProvider<AppStateNotifier, AppState>(() {
  return AppStateNotifier();
});
