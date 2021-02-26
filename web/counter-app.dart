import 'dart:html';

import 'framework.dart';
import 'compose.dart';

class CounterApp extends App<CounterState> {

  CounterApp(CounterState state) : super(state);

  @override
  void render(Element app, CounterState state, dispatch) {
    app.add(row([text('menu 1'), text('menu 2'), text('menu 3')]))
        .add(text('Count: ${state.count}'))
        .add(text('Add 5', onClick: () {
      print('add 5 clicked');
      dispatch(Add5());
    }))
        .add(text('Double', onClick: () {
      print('double button clicked');
      dispatch(Double());
    }));
  }

  @override
  Future<DispatchResponse> handleActionDispatch(CounterState state, Action action) async {
    print('counterApp.handleActionDispatch($state, $action)');

    if (action is AddAction) {
      return DispatchResponse(CounterState(state.count + action.value));
    }
    if(action is Double){
      return DispatchResponse(CounterState(state.count + state.count));
    }
    return DispatchResponse(state);

  }
}

class CounterState extends State {
  final int count;

  CounterState(this.count);
}

class AddAction extends Action {
  final int value;

  AddAction(this.value);
}

class Add5 extends AddAction {
  Add5() : super(5);
}

class Double extends Action {}

class AddTen extends AddAction {
  AddTen() : super(10);
}
