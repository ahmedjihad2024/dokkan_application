import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_event_bus.dart';

/// Mixin that lets any [BlocBase] subscribe to [AppEventBus] events and
/// automatically cancel all subscriptions when the bloc is closed.
///
/// Usage:
/// ```dart
/// class MyCubit extends Cubit<MyState> with EventBusMixin {
///   MyCubit() : super(initial) {
///     subscribe<ProductFavoriteChanged>(_onFavoriteChanged);
///   }
///
///   void _onFavoriteChanged(ProductFavoriteChanged event) { ... }
/// }
/// ```
mixin EventBusMixin<S> on BlocBase<S> {
  final List<StreamSubscription<dynamic>> _subscriptions = [];

  /// Subscribe to bus events of type [T].
  void subscribe<T>(void Function(T event) callback) {
    final subscription = AppEventBus.instance.on<T>().listen(callback);
    _subscriptions.add(subscription);
  }

  @override
  Future<void> close() async {
    for (final sub in _subscriptions) {
      await sub.cancel();
    }
    _subscriptions.clear();
    return super.close();
  }
}

