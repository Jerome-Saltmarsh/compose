import 'dart:html';

//////////////// *** FRAMEWORK *** ////////////////

abstract class StateRenderer<T extends State> {
  void render(Element app, T state, Dispatch dispatch);
}

abstract class App<T extends State> implements ActionDispatchHandler<T>, StateRenderer<T> {

  T state;
  Element root;

  App(this.state, {String selector = 'app'}) {
    print('app()');
    root = select(selector);
    if (root == null) {
      throw Exception(('Element with selector $selector could not be found'));
    }
    render(root, state, dispatch);
  }

  Future<DispatchResponse> dispatch(Action action) async{
    print('app.dispatch($action)');
    var response = await handleActionDispatch(state, action);
    setState(response.state);
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
    clear();
    render(root, state, dispatch);
  }

  void clear(){
    print('app.clear()');
    root.children.clear();
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
  final ActionDispatchHandler dispatchService;

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

abstract class ActionDispatchHandler<T extends State> {
  Future<DispatchResponse> handleActionDispatch(T state, Action action);
}



