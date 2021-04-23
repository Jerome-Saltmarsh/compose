import 'dart:html';

const json = {
  'text': 'hello',
  'click': {'name': 'hello', 'value': 'world'},
  'padding': 20,
  'class': 'title'
};

const css = {
  'title': {'font-size': 25, 'font-weight': 500, 'padding': 20}
};

buildText(String name) {
  return {
    'text': name,
    'click': {'name': 'hello', 'value': 'world'},
    'padding': 20,
    'id': '123'
  };
}

Element buildWebApp(){
  return compose('hello world');
}

Map<String, dynamic> buildContainer() {
  return {
    'color': 'red',
    'x-even-center': [
      'hello',
      {'text': 'world'},
      150,
      true
    ],
  };
}

Element compose(value) {
  Element div = Element.div();
  if (value is String) {
    div.text = value;
    return div;
  }
  if (value is num) {
    div.text = value.toString();
    return div;
  }
  if (value is Map<String, dynamic>) {
    return convertJsonToCSS(value);
  }
  throw new Exception("could not compose $value");
}

/// reads a map object and converts it into html
Element convertJsonToHtml(Map<String, dynamic> json) {
  Element div = Element.div();
  if (json.containsKey('text')) {
    div.text = json['text'];
  }
  if (json.containsKey('style')) {
    div.style.cssText = json['style'];
  }
  return div;
}

convertJsonToCSS(Map<String, dynamic> json) {

}

// convert a dart function into a javascript function
