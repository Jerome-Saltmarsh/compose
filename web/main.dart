import 'dart:html';

import 'framework.dart';
import 'dart-compose.dart';

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

StateRenderer stateRenderer = CounterRenderer();
DispatchService dispatchService = CounterDispatcher();
State state = CounterState('hello world', 0);

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

    add(app, count);

    var addButton = div(text: 'add', onClick: () async {
      print('add clicked');
      var response = await dispatchService.dispatch(state, AddAction(5));
      if (response.state != null) {
        state = response.state;
        render(state);
      }
    });
    add(app, addButton);
  }
}

class MenuRenderer implements StateRenderer<CounterState> {
  @override
  void render(CounterState testState) {
    print('render()');

    var app = querySelector('#app');
    app.minHeight = 500;

    var menu = vStartStart(
        [menuItem('menu 1'), menuItem('menu 2'), menuItem('menu 3')]);

    var content = div();
    content.text = 'content';

    var sidebar = div();
    sidebar.text = 'side bar';

    add(app, hApartStart([menu, content, sidebar]));
  }
}


class CounterState extends State {
  final String username;
  final int count;

  CounterState(this.username, this.count);
}

Element menuItem(String text) {
  var e = element(text);
  e.minHeight = 50;
  e.style.border = '1px solid black';
  return e;
}
