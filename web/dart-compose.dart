import 'dart:html';

enum MainAlign { Start, Center, End, Even, Apart }

enum CrossAlign { Start, Center, End, Stretch }

enum Direction { Vertical, Horizontal }

const Direction horizontal = Direction.Horizontal;
const Direction vertical = Direction.Vertical;

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
    case MainAlign.Apart:
      return 'space-between';
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

Element text(String value) {
  var d = Element.div();
  d.text = value;
  return d;
}

Element hStartStart(List<Element> children) {
  return container(
      children: children, direction: Direction.Horizontal, main: MainAlign.Start, cross: CrossAlign.Start);
}

Element hApartStart(List<Element> children) {
  return container(children: children, direction: Direction.Horizontal, main: MainAlign.Apart, cross: CrossAlign.Start);
}

Element vStartStart(List<Element> children) {
  return container(children: children, direction: Direction.Vertical, main: MainAlign.Start, cross: CrossAlign.Start);
}

Element container({
    Element child,
    List<Element> children,
    Direction direction,
    MainAlign main,
    CrossAlign cross
}) {
  var d = div();

  if (child != null) {
    d.children.add(d);
  }

  if (children != null) {
    d.children.addAll(children);
  }

  if (direction != null) {
    d.style.display = 'flex';
    d.style.flexDirection = convertDirectionToFlexDirection(direction);
  }

  if (main != null) {
    d.style.display = 'flex';
    d.style.justifyContent = convertMainAlignToJustifyContent(main);
  }
  if (cross != null) {
    d.style.display = 'flex';
    d.style.alignItems = convertCrossAlignToAlignItem(cross);
  }

  return d;
}

Element div({String text, Function onClick}){
  var element = Element.div();
  if(text != null){
    element.text = text;
  }

  if(onClick != null){
    element.onClick.listen((event) {
        onClick();
    });
  }
  return element;
}

Element element([String text]){
  var div = Element.div();
  if(text != null){
    div.text = text;
  }
  return div;
}

void addAll(Element parent, List<Element> children) {
  parent.children.addAll(children);
}

void add(Element parent, Element child) {
  parent.children.add(child);
}

////////////////

extension ElementExtensions on Element {
  set minHeight(int value) {
    style.minHeight = '${value}px';
  }
}
