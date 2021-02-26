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

Future<DispatchResponse> dispatch(Action action) async {
  var dispatchResponse = await dispatchService.dispatch(state, action);
  if(dispatchResponse.state != null){
     renderState();
  }
  return dispatchResponse;
}

void renderState(){
  stateRenderer.render(state);
}

Future runApp() async {
  stateRenderer.render(state);
}

class AddAction extends Action {
  final int value;

  AddAction(this.value);
}

class AddFiveAction extends AddAction{
  AddFiveAction() : super(5);
}

class AddTen extends AddAction{
  AddTen() : super(10);
}

abstract class StateRenderer<T extends State> {
  void render(T state);
}

class CounterRenderer implements StateRenderer<CounterState> {
  @override
  void render(CounterState testState) {
    var app = select('app')
        .clear()
        .add(text('Count: ${testState.count}'))
        .add(text('Add 5', onClick: () async {
          await dispatch(AddAction(5));
        })
    );

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

class CounterState extends State {
  final String username;
  final int count;

  CounterState(this.username, this.count);
}
