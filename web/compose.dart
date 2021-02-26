import 'dart:html';

//////////////// ENUMS ////////////////

enum MainAlign { Start, Center, End, Even, Apart }
enum CrossAlign { Start, Center, End, Stretch }
enum Direction { Vertical, Horizontal }

enum BorderStyle { Solid, Dashed }

//////////////// CONSTANT ////////////////

const Direction horizontal = Direction.Horizontal;
const Direction vertical = Direction.Vertical;

MainAlign mainAlignApart = MainAlign.Apart;
MainAlign mainAlignStart = MainAlign.Start;
MainAlign mainAlignEnd = MainAlign.End;
MainAlign mainAlignEven = MainAlign.Even;

CrossAlign crossAlignStretch = CrossAlign.Stretch;

//////////////// CUSTOM ////////////////

Element column(List<Element> children, {Function onClick}) {
  return div(
      children: children,
      direction: vertical,
      mainAlign: mainAlignEnd,
      crossAlign: crossAlignStretch,
      onClick: onClick);
}

Element row(List<Element> children, { Function onClick}) {
  return div(
      children: children,
      direction: horizontal,
      mainAlign: mainAlignEnd,
      crossAlign: crossAlignStretch,
      onClick: onClick);
}

Element text(String value, {Function onClick}) {
  return div(text: value, onClick: onClick);
}


//////////////// BUILDERS ////////////////

Element button(String value, {Function onClick}) {
  final button = input(value: value, type: 'button', onClick: onClick);
  return button;
}

Element input({String value, String type, Function onClick}) {
  final input = tag('input');
  return input;
}

Element tag(String value) {
  return Element.tag(value);
}

Element svg(String url) {
  return Element.svg();
}

Element img(String url) {
  return Element.img();
}

Element div(
    {String text,
    List<Element> children,
    Direction direction,
    MainAlign mainAlign,
    CrossAlign crossAlign,
    Function onClick}) {
  var div = Element.div();
  if (text != null) {
    div.text = text;
  }

  if (onClick != null) {
    div.onClick.listen((event) {
      onClick();
    });
  }
  if (direction != null) {
    div.style.display = 'flex';
    div.style.flexDirection = convertDirectionToFlexDirection(direction);
  }

  if (mainAlign != null) {
    div.style.display = 'flex';
    div.style.justifyContent = convertMainAlignToJustifyContent(mainAlign);
  }
  if (crossAlign != null) {
    div.style.display = 'flex';
    div.style.alignItems = convertCrossAlignToAlignItem(crossAlign);
  }

  return div;
}

//////////////// EXTENSIONS ////////////////

extension ElementExtensions on Element {

  Element clear(){
    children.clear();
    return this;
  }

  Element height(int value){
    return minHeight(value)
          .maxHeight(value);
  }

  Element minHeight(int value) {
    style.minHeight = px(value);
    return this;
  }

  Element maxHeight(int value) {
    style.maxHeight = px(value);
    return this;
  }

  String px(int value){
    return '${value}px';
  }

  Element add(Element element) {
    children.add(element);
    return this;
  }

  Element setBorder({int px = 1, BorderStyle style = BorderStyle.Solid, String color}){
    // TODO Read style and color
    this.style.border = '${px}px solid black';
    return this;
  }
}

//////////////// CONVERSIONS ////////////////

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

  throw Exception('could not parse item: $value');
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
    case MainAlign.Apart:
      return 'space-between';
  }
  throw Exception('could not convert to justify content: $value');
}

//////////////// UTIL ////////////////

Element select(String id){
  if(id.startsWith('#')){
    return querySelector(id);
  }
  return querySelector('#$id');
}