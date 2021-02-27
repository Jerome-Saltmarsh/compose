import 'dart:html';


//////////////// *** FRAMEWORK *** ////////////////

abstract class StateRenderer<T extends State> {
  Element render(T state, Dispatch dispatch);
}

Element select(String id) {
  print('select($id)');
  if (id.startsWith('#')) {
    return querySelector(id);
  }
  return querySelector('#$id');
}

abstract class IComposer {
  Element compose<T extends State>(T state, Dispatch dispatch);
}




//////////////// STRUCTS ////////////////


class State {
}

class Action {
}


class Dispatchment<T> {
  final T action;
  final State state;

  Dispatchment({this.action, this.state});
}

//////////////// TYPEDEVS ////////////////
typedef Dispatch = void Function(Action action);
typedef Compose = Element Function<T extends State>(T state, Dispatch dispatch);
typedef Handle = Future<State> Function<S extends State, A extends Action>(S state, A action);

abstract class Handler<S extends State> {
  Future<State> handle(S state, Action action);
}

abstract class Dispatcher {
  void dispatch(Action action);
}

abstract class Composer<T extends State> {
  Element compose(T state, Dispatch dispatch);
}

//////////////// ABSTRACTIONS ////////////////

// abstract class DispatchHandler<T extends State> {
//   Future<DispatchResponse> handleActionDispatch(T state, Action action);
// }



