import 'dart:html';

//////////////// *** FRAMEWORK *** ////////////////

abstract class StateRenderer<T extends State> {
  void render(Element app, T state, Dispatch dispatch);
}

class App {
  State state;
  StateRenderer renderer;
  ActionDispatcher dispatcher;
  Element element;

  App(this.state, this.renderer, this.dispatcher) {
    print('app()');
    element = select('app');
    render();
  }

  void render() {
    renderer.render(element, state, dispatch);
  }

  Future<DispatchResponse> dispatch(Action action) async {
    print('dispatching $action');
    var dispatchResponse = await dispatcher.dispatch(state, action);
    handleDispatchResponse(dispatchResponse);
    return dispatchResponse;
  }

  void handleDispatchResponse(DispatchResponse dispatchResponse){
    print('handleDispatchResponse()');
    if (dispatchResponse.state != null) {
      setState(dispatchResponse.state);
    }
  }

  // MUTATIONS

  void setState(State nextState) {
    print('setState($nextState)');
    state = nextState;
    render();
  }
}

Element select(String id) {
  print('select($id)');
  if (id.startsWith('#')) {
    return querySelector(id);
  }
  return querySelector('#$id');
}

//////////////// STRUCTS ////////////////

class Server {
}

class State {
}

class Action {
}

class Client {
  final State state;
  final ActionDispatcher dispatchService;

  Client({this.state, this.dispatchService});
}

class DispatchResponse {
  final State state;

  DispatchResponse(this.state);
}

class Dispatchment<T> {
  final T action;
  final State state;

  Dispatchment({this.action, this.state});
}

//////////////// TYPEDEVS ////////////////

typedef Dispatch = Future<DispatchResponse> Function(Action action);

//////////////// ABSTRACTIONS ////////////////

abstract class ActionDispatcher<T extends State> {
  Future<DispatchResponse> dispatch(T state, Action action);
}



