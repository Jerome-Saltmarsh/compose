import 'dart:html';

const String x_start_start = 'x-start-start';
const String x_even_start = 'x-even-start';
const String x_even_center = 'x-even-center';

Map<String, dynamic> customer({String name, int age}) {
  return text(name, size: 28, weight: 500);
}

Map<String, dynamic> list(List<Map<String, dynamic>> children,
    {String alignment = x_even_center}) {
  return {'children': children, 'size ': 25, 'weight': 700};
}

Map<String, dynamic> text(String value, {int size = 25, int weight = 700}) {
  return {'text': value, 'size ': 25, 'weight': 700};
}

Element compose(value) {
  var div = Element.div();
  if (value is String) {
    div.text = value;
    return div;
  }
  if (value is num) {
    div.text = value.toString();
    return div;
  }
  if (value is Map<String, dynamic>) {
    return convertJsonToElement(value);
  }
  throw Exception('could not compose $value');
}

/// reads a map object and converts it into html
Element convertJsonToElement(Map<String, dynamic> json) {
  var div = Element.div();
  if (json.containsKey('text')) {
    div.text = json['text'];
  }
  if (json.containsKey('style')) {
    div.style.cssText = json['style'];
  }
  if (json.containsKey('text_color')){
    div.style.color = json['text_color'];
  }
  if (json.containsKey('fill_color')){
    div.style.backgroundColor = json['fill_color'];
  }
  if (json.containsKey('padding')){
    div.style.padding = '${json['padding']}px';
  }
  if (json.containsKey('size')){
    div.style.fontSize = '${json['size']}px';
  }
  if (json.containsKey('children')){
    List children = json['children'];
    div.children = children.map(compose).toList();
  }
  if (json.containsKey('class')){
    div.className = json['class'];
  }
  if (json.containsKey('alignment')){
    div.style.display = 'flex';
    div.style.flexDirection = 'row';
  }
  return div;
}

convertJsonToCSS(Map<String, dynamic> json) {

}

// convert a dart function into a javascript function
