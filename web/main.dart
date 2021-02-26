import 'dart:html';

import 'framework.dart';
import 'compose.dart';

class CounterDispatcher implements DispatchService<CounterState> {
  @override
  Future<DispatchResponse> dispatch(CounterState state, Action action) async {
    if (action is AddAction) {
      State newState = CounterState(state.username, state.count + action.value);
      return DispatchResponse(newState);
    }
    return DispatchResponse(state);
  }
}

// webdev serve
void main() {
  print('main()');
  runApp();
}

//////////////// SERVICES ////////////////

final StateRenderer stateRenderer = CounterRenderer();
final DispatchService dispatchService = CounterDispatcher();

//////////////// STATE ////////////////

State state = CounterState('hello world', 0);

//////////////// HELPER ////////////////

Future<DispatchResponse> dispatch(Action action) {
  return dispatchService.dispatch(state, action);
}

Future runApp() async {
  stateRenderer.render(state);
}

class AddAction extends Action {
  final int value;

  AddAction(this.value);
}

abstract class StateRenderer<T extends State> {
  void render(T state);
}

class CounterRenderer implements StateRenderer<CounterState> {
  @override
  void render(CounterState testState) {
    print('render()');
    var app = querySelector('#app');
    app.children.clear();
    var count = div();
    count.text = 'count: ${testState.count}';

    app.add(count);

    var addButton = text('add', onClick: () async {
      print('add clicked');
      var response = await dispatchService.dispatch(state, AddAction(5));
      if (response.state != null) {
        state = response.state;
        render(state);
      }
    });

    app.add(addButton);
  }
}

class MenuRenderer implements StateRenderer<CounterState> {
  @override
  void render(CounterState testState) {
    select('app')
        .minHeight(500)
        .add(column([
          text('menu 1'),
          text('menu 2'),
          text('menu 3'),
        ]));
  }
}


class CounterState extends State {
  final String username;
  final int count;

  CounterState(this.username, this.count);
}
