//////////////// *** COMPOSE *** ////////////////

// A library to make building html in dart easy

//////////////// IMPORTS ////////////////
import 'dart:html';

//////////////// ENUMS ////////////////

enum MainAlign { Start, Center, End, Even, Apart }
enum CrossAlign { Start, Center, End, Stretch }
enum Direction { Vertical, Horizontal }
enum BorderStyle { Solid, Dashed }

//////////////// CONSTANT ////////////////

const Direction directionHorizontal = Direction.Horizontal;
const Direction directionVertical = Direction.Vertical;
const MainAlign mainAlignApart = MainAlign.Apart;
const MainAlign mainAlignStart = MainAlign.Start;
const MainAlign mainAlignEnd = MainAlign.End;
const MainAlign mainAlignEven = MainAlign.Even;
const MainAlign mainAlignCenter = MainAlign.Center;
const CrossAlign crossAlignStretch = CrossAlign.Stretch;
const CrossAlign crossAlignCenter = CrossAlign.Center;

//////////////// CUSTOM ////////////////

Element heightBox(int height) {
  return div().height(height);
}

//////////////// BUILDERS ////////////////

Element text(String value) {
  return div(value);
}

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

Element div([var value]) {
  var div = Element.div();

  if (value != null) {
    if (value is String) {
      div.text = value;
    }
    if (value is Iterable<Element>) {
      div.children.addAll(value);
    }
  }
  return div;
}

//////////////// EXTENSIONS ////////////////

extension ElementExtensions on Element {
  Element clear() {
    children.clear();
    return this;
  }

  Element height(int value) {
    return minHeight(value).maxHeight(value);
  }

  Element minHeight(int value) {
    style.minHeight = px(value);
    return this;
  }

  Element maxHeight(int value) {
    style.maxHeight = px(value);
    return this;
  }

  Element minWidth(int value) {
    style.minWidth = px(value);
    return this;
  }

  Element maxWidth(int value) {
    style.maxWidth = px(value);
    return this;
  }

  Element addText(String value) {
    return add(text(value));
  }

  Element addHeightBox(int height) {
    return add(Element.div().height(height));
  }

  Element add(Element element) {
    children.add(element);
    return this;
  }

  Element div(dynamic value){

    var element = Element.div();
    if(value is String){
      element.text = value;
    }
    if(value is Iterable<Element>){
      element.children.addAll(value);
    }
    children.add(element);

    return this;
  }

  Element background(String color) {
    style.backgroundColor = color;
    return this;
  }

  Element textColor(String value){
    style.color = value;
    return this;
  }

  Element setText(String value) {
    this.text = value;
    return this;
  }

  Element padding(int amount) {
    style.padding = px(amount);
    return this;
  }

  Element handleClick(Function onClick) {
    print('handleClick()');
    this.onClick.listen((event) {
      onClick();
    });
    return this;
  }

  Element addAll(List<Element> values) {
    children.addAll(values);
    return this;
  }

  Element setBorder(
      {int px = 1, BorderStyle style = BorderStyle.Solid, String color = 'black', int radius = 0}) {
    // TODO Read style and color
    this.style.border = '${px}px solid $color';

    if(radius != null){
      this.style.borderRadius = '${radius}px';
    }

    return this;
  }

  Element get expand {
    expandWidth;
    expandHeight;
    return this;
  }

  Element get expandWidth {
    style.width = '100%';
    return this;
  }

  Element get expandHeight {
    style.height = '100%';
    return this;
  }

  Element get centerV {
    return center(Direction.Vertical);
  }

  Element get centerH {
    return center(Direction.Horizontal);
  }

  Element get mainAlignStart {
    return mainAlign(MainAlign.Start);
  }

  Element get mainAlignEnd {
    return mainAlign(MainAlign.End);
  }

  Element get mainAlignCenter {
    return mainAlign(MainAlign.Center);
  }

  Element get mainAlignEven {
    return mainAlign(MainAlign.Even);
  }

  Element get mainAlignApart {
    return mainAlign(MainAlign.Apart);
  }

  Element center(Direction direction) {
    expand;
    mainAlign(MainAlign.Center);
    crossAlign(crossAlignCenter);
    return this.direction(direction);
  }

  Element get horizontal {
    return direction(Direction.Horizontal);
  }

  Element get vertical {
    return direction(Direction.Vertical);
  }

  Element direction(Direction value) {
    flex();
    style.flexDirection = convertDirectionToFlexDirection(value);
    return this;
  }

  Element mainAlign(MainAlign value) {
    flex();
    style.justifyContent = convertMainAlignToJustifyContent(value);
    return this;
  }

  Element crossAlign(CrossAlign value) {
    flex();
    style.alignItems = convertCrossAlignToAlignItem(value);
    return this;
  }

  Element flex() {
    style.display = 'flex';
    return this;
  }
}

//////////////// CONVERSIONS ////////////////

String px(int value) {
  return '${value}px';
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

Element select(String id) {
  print('select($id)');
  if (id.startsWith('#')) {
    return querySelector(id);
  }
  return querySelector('#$id');
}
