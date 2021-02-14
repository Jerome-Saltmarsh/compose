import 'dart:html';

enum MainAxisAlignment {
  Start,
  Center,
  End,
  Even,
}

enum CrossAxisAlignment { Start, Center, End, Stretch }

enum Direction { Vertical, Horizontal }

void main() {
  print('main()');
  var app = querySelector('#app');
  app.text = 'Your Dart app is running. again again';
  app.style.backgroundColor = 'green';

  app.style.minHeight = '500px';

  // app.onClick.listen((event) {
  //   app.style.backgroundColor = 'red';
  // });

  app.children.add(vertical(items, mainAxisAlignment: MainAxisAlignment.End));
  app.children.add(horizontal(items));
  // app.children.add(buildMenu());
}

Element horizontal(List<Element> children,
    {MainAxisAlignment mainAxisAlignment}) {

  return container(
      children: children,
      direction: Direction.Horizontal,
      mainAxisAlignment: mainAxisAlignment);
}

Element vertical(List<Element> children,
    {MainAxisAlignment mainAxisAlignment}) {
  return container(
      children: children,
      direction: Direction.Vertical,
      mainAxisAlignment: mainAxisAlignment);
}

Element container(
    {List<Element> children,
    Direction direction = Direction.Horizontal,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.Even,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.Center}) {
  var container = Element.div();
  setLayout(container, direction, mainAxisAlignment, crossAxisAlignment);
  container.children.addAll(children);
  return container;
  // row.style.display = 'flex';
  // row.style.flexDirection = convertDirectionToFlexDirection(direction);
  // row.style.justifyContent = convertMainAxisAlignmentToJustifyContent(main);
  // row.style.alignItems = convertCrossAxisAlignmentToAlignItem(cross);
  // if(children != null){
  //   row.children.addAll(children);
  // }
  // return row;
}

Element setLayout(
    Element element,
    Direction direction,
    MainAxisAlignment mainAxisAlignment,
    CrossAxisAlignment crossAxisAlignment) {

  element.style.display = 'flex';
  element.style.flexDirection = convertDirectionToFlexDirection(direction);
  element.style.justifyContent =
      convertMainAxisAlignmentToJustifyContent(mainAxisAlignment);
  element.style.alignItems =
      convertCrossAxisAlignmentToAlignItem(crossAxisAlignment);
}

String convertDirectionToFlexDirection(Direction direction) {
  return direction == Direction.Horizontal ? 'row' : 'column';
}

String convertMainAxisAlignmentToJustifyContent(MainAxisAlignment value) {
  switch (value) {
    case MainAxisAlignment.Start:
      return 'flex-start';
    case MainAxisAlignment.Center:
      return 'center';
    case MainAxisAlignment.End:
      return 'flex-end';
    case MainAxisAlignment.Even:
      return 'space-evenly';
  }
  throw Exception('couldt not convert to justify content');
}

String convertCrossAxisAlignmentToAlignItem(CrossAxisAlignment value) {
  switch (value) {
    case CrossAxisAlignment.Start:
      return 'flex-start';
    case CrossAxisAlignment.Center:
      return 'center';
    case CrossAxisAlignment.End:
      return 'flex-end';
    case CrossAxisAlignment.Stretch:
      return 'stretch';
  }

  throw Exception("could not parse item");
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
