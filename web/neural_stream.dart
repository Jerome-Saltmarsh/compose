library event_stream;

class Call {
  final dynamic input;
  final dynamic output;
  final DateTime started;
  final DateTime ended;
  final SubscriptionException error;

  Call({this.input, this.output, this.started, this.ended, this.error});
}

class NeuralStream {
  final List<Subscription> subscriptions = [];

  void add<T>(T trigger) {
    if (trigger == null) return;

    subscriptions
        .where((subscription) => subscription.canHandle(trigger))
        .forEach((subscription) {
      SubscriptionException subscriptionException;
      DateTime started = DateTime.now();

      Future futureResult =
          subscription.handle(trigger).catchError((error, stacktrace) {
        subscriptionException =
            SubscriptionException(error, subscription, stacktrace, trigger);
        add(subscriptionException);
        return null;
      });

      futureResult.then((output) {
        subscription.calls.add(Call(
            input: trigger,
            output: output,
            error: subscriptionException,
            started: started,
            ended: DateTime.now()));

        if (output == null) return;

        if (output is CancelSubscription) {
          cancel(subscription);
          return;
        }

        add(output);
      });
    });
  }

  Subscription<T> listen<T>(Reaction<T> function,
      {String description, bool enabled = true, int max}) {
    final Subscription subscription = Subscription<T>(
        function: function,
        description: description,
        enabled: enabled,
        maxCalls: max);
    subscriptions.add(subscription);
    return subscription;
  }

  void cancel(Subscription subscription) {
    subscriptions.remove(subscription);
  }
}

/// This is used to cancel a subscription from within a computation
/// if the computation returns this object its subscription will be cancelled
class CancelSubscription {
  final Subscription subscription;

  CancelSubscription(this.subscription);
}

extension CallExtensions on Call {
  Duration get duration => started.difference(ended);

  bool get hasError => error != null;
}

NeuralStream globalNeuralStream = NeuralStream();

void add<T>(T trigger) => globalNeuralStream.add(trigger);

void subscribe<T>(Reaction<T> reaction) => globalNeuralStream.listen(reaction);

typedef Future Reaction<E>(E event);

/// A Neuron
class Subscription<T> {
  // injected
  final String description;
  final Reaction<T> function;
  final int maxCalls;
  final List<Call> calls = [];

  bool enabled;
  int _totalCalls = 0;

  int get callCount => _totalCalls;

  int get totalErrors => calls.where((call) => call.error != null).length;

  Type get type => T;

  Subscription({
    this.function,
    this.description,
    this.maxCalls,
    this.enabled = true,
  });

  Future handle(var value) async {
    _totalCalls++;
    return await function(value);
  }

  bool canHandle(var value) {
    if (maxCalls != null && _totalCalls >= maxCalls) return false;

    return enabled && value is T;
  }

  @override
  String toString() {
    return 'Subscription{description: $description, function: $function, maxCalls: $maxCalls, enabled: $enabled, _calls: $_totalCalls}';
  }
}

class SubscriptionException implements Exception {
  final Subscription subscription;
  final dynamic exception;
  final StackTrace stackTrace;
  final dynamic trigger;

  SubscriptionException(
      this.exception, this.subscription, this.stackTrace, this.trigger);

  @override
  String toString() {
    return 'SubscriptionException{subscription: $subscription, exception: $exception, stackTrace: $stackTrace, trigger: $trigger}';
  }
}
