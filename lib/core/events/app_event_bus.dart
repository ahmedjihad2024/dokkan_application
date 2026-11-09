import 'dart:async';

/// Singleton broadcast stream bus. Fire any event from anywhere,
/// subscribe from any BlocBase via [EventBusMixin].
class AppEventBus {
  AppEventBus._();

  static final AppEventBus instance = AppEventBus._();

  final StreamController<Object> _controller =
      StreamController<Object>.broadcast();

  /// Returns a filtered stream of events of type [T].
  Stream<T> on<T>() => _controller.stream.where((e) => e is T).cast<T>();

  /// Fire an event to all subscribers.
  void fire(Object event) => _controller.add(event);

  void dispose() => _controller.close();
}

/// Event fired whenever a product's favorite status changes.
class ProductFavoriteChanged {
  const ProductFavoriteChanged();
}
