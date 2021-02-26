
class Server {

}

abstract class Data {

}

class State {
}

class Action {

}

abstract class DispatchService<T extends State> {
  Future<DispatchResponse> dispatch(T state, Action action);
}

class Client {
  final State state;
  final DispatchService dispatchService;

  Client({this.state, this.dispatchService});
}

class Dispatch<T> {
  final T action;
  final State state;

  Dispatch({this.action, this.state});
}

class DispatchResponse {
  final State state;
  DispatchResponse(this.state);
}