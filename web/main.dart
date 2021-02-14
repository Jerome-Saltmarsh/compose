import 'dart:html';

enum MainAlign {
  Start,
  Center,
  End,
  Even,
}

enum CrossAlign { Start, Center, End, Stretch }

enum Direction { Vertical, Horizontal }

void main() {
  print('main()');
  var app = querySelector('#app');
  app.text = 'Your Dart app is running. again again';
  app.style.backgroundColor = 'green';
  app.style.minHeight = '500px';

  app.children.add(horizontal(items));
  app.children.add(vertical(items, MainAlign.End));
  app.children.add(horizontal(items));
}

Element horizontal(List<Element> children,
    [MainAlign mainAlign = MainAlign.Even, CrossAlign crossAlign = CrossAlign.Center]) {
  return container(children, Direction.Horizontal, mainAlign, crossAlign);
}

Element vertical(List<Element> children,
    [MainAlign MainAlign, CrossAlign CrossAlign = CrossAlign.Center]) {
  return container(children, Direction.Vertical, MainAlign, CrossAlign);
}

Element box(Element element) {
  return container(
      [element], Direction.Horizontal, MainAlign.Center, CrossAlign.Center);
}

Element container(
    [List<Element> children,
    Direction direction = Direction.Horizontal,
    MainAlign mainAlign = MainAlign.Even,
    CrossAlign crossAlign = CrossAlign.Center]) {
  var container = Element.div();
  setLayout(container, direction, mainAlign, crossAlign);
  container.children.addAll(children);
  return container;
}

Element setLayout(Element element, Direction direction, MainAlign MainAlign,
    CrossAlign CrossAlign) {
  element.style.display = 'flex';
  element.style.flexDirection = convertDirectionToFlexDirection(direction);
  element.style.justifyContent = convertMainAlignToJustifyContent(MainAlign);
  element.style.alignItems = convertCrossAlignToAlignItem(CrossAlign);
  return element;
}

String convertDirectionToFlexDirection(Direction direction) {
  return direction == Direction.Horizontal ? 'row' : 'column';
}

String convertMainAlignToJustifyContent(MainAlign value) {
  switch (value) {
    case MainAlign.Start:
      return 'flex-start';
    case MainAlign.Center:
      return 'center';
    case MainAlign.End:
      return 'flex-end';
    case MainAlign.Even:
      return 'space-evenly';
  }
  throw Exception('could not convert to justify content: $value');
}

String convertCrossAlignToAlignItem(CrossAlign value) {
  switch (value) {
    case CrossAlign.Start:
      return 'flex-start';
    case CrossAlign.Center:
      return 'center';
    case CrossAlign.End:
      return 'flex-end';
    case CrossAlign.Stretch:
      return 'stretch';
  }

  throw Exception("could not parse item: $value");
}

List<Element> get items {
  return [
    Element.div()..text = 'child 1',
    Element.div()..text = 'child 2',
    Element.div()..text = 'child 3',
    Element.div()..text = 'child 4'
  ];
}

Element text(String value) {
  var d = div();
  d.text = value;
  return d;
}

Element div([Element element1, List<Element> children]) {
  var d = Element.div();

  if (element1 != null) {
    d.children.add(d);
  }

  d.children.addAll(children);
  return d;
}
