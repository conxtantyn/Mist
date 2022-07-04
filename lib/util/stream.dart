import 'dart:async';

extension StreamDisposable on StreamSubscription<dynamic> {
  void include(List<StreamSubscription<dynamic>> subscriptions) {
    subscriptions.add(this);
  }
}
