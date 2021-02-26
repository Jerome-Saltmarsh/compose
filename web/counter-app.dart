import 'dart:html';

import 'compose.dart';
import 'framework.dart';

App counterApp() {
  print('counterApp()');
  return App(CounterState(0), CounterRenderer(), CounterDispatcher());
}

class CounterState extends State {
  final int count;

  CounterState(this.count);
}

class CounterDispatcher implements ActionDispatcher<CounterState> {
  @override
  Future<DispatchResponse> dispatch(CounterState state, Action action) async {
    print('counterDispatch.dispatch($state, $action);');

    if (action is AddAction) {
      State newState = CounterState(state.count + action.value);
      return DispatchResponse(newState);
    }
    return DispatchResponse(state);
  }
}

class AddAction extends Action {
  final int value;

  AddAction(this.value);
}

class Add5 extends AddAction {
  Add5() : super(5);
}

class AddTen extends AddAction {
  AddTen() : super(10);
}

class CounterRenderer implements StateRenderer<CounterState> {
  @override
  void render(Element app, CounterState state, Dispatch dispatch) {
    print('counterRenderer.render()');
    app
        .clear()
        .add(text('Count: ${state.count}'))
        .add(text('Add 5', onClick: () {
          print('add 5 clicked');
          dispatch(Add5());
        }));
  }
}
