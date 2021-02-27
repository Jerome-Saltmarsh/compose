import 'dart:html';

import 'compose.dart';
import 'framework.dart';

//////////////// STATE  ////////////////

var state = AppState(CounterState(50), AuthState('abc123'));

//////////////// METHODS  ////////////////

void dispatch(Action action) {
  print('dispatch($action)');
  if (action is AddAction) {
    state = AppState(
        CounterState(state.counterState.count + action.value), state.authState);
  }
  renderApp();
}

Element composeApp(AppState state, Dispatch dispatch) {
  print('composeApp()');
  var app = div();
  var auth = composeAuth(state.authState, dispatch);
  var counter = composeCounter(state.counterState, dispatch);

  return app.addAll([
    auth,
    counter,
  ]);
}

Element composeAuth(AuthState state, Dispatch dispatch) {
  return Element.div()
      .setText('authToken: ${state.authToken}')
      .background('red');
}


Element composeCounter(CounterState state, Dispatch dispatch) {
  print('composeCounter()');
  // UI LOGIC
  return div([
    div('count: ${state.count}'),
    div('add 5').handleClick(() {
      dispatch(Add5());
    }),
  ]).background('blue').mainAlignApart.height(500);
}

void render(Element element) {
  var app = select('app');
  app.clear();
  app.add(element);
}

Element select(String id) {
  print('select($id)');
  if (id.startsWith('#')) {
    return querySelector(id);
  }
  return querySelector('#$id');
}

void renderApp() {
  print('renderApp()');
  render(composeApp(state, dispatch));
}

//////////////// MAIN  ////////////////

/// To get start simply enter the following command in the command line
/// webdev serve
void main() {
  print('main()');
  renderApp();
}

//////////////// CLASSES  ////////////////

class CounterState extends State {
  final int count;

  CounterState(this.count);
}

class AuthState extends State {
  final String authToken;

  AuthState(this.authToken);
}

class AppState extends State {
  final CounterState counterState;
  final AuthState authState;

  AppState(this.counterState, this.authState);
}

class FlexState {
  final Direction direction;
  final MainAlign mainAlign;
  final CrossAlign crossAlign;

  FlexState(this.direction, this.mainAlign, this.crossAlign);
}

class AddAction extends Action {
  final int value;

  AddAction(this.value);
}

class Add5 extends AddAction {
  Add5() : super(5);
}

class Add10 extends AddAction {
  Add10() : super(10);
}

//////////////
