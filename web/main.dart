import 'dart:html';

import 'dart-compose.dart';

var menu_item_template = {'text': '{name}', 'size': 28, 'weight': 500};

var data1 = {'name': 'menu item 1'};
var data2 = {'name': 'menu item 2'};
var data3 = {'name': 'menu item 2'};

void main() {
  var app = querySelector('#app');
  var composedApp = compose(buildApp());
  app.children.add(composedApp);
  return;
  var child = compose(list([
    customer(name: 'John', age: 28),
    customer(name: 'Mary', age: 21),
    customer(name: 'Gary', age: 45),
  ], alignment: x_even_center));
  app.children.add(child);
}

Map<String, dynamic> buildApp(){
  // var composedTemplate = compile(data, menu_item_template);
  return mapTemplate(data1, menu_item_template);
}

Element compile(Map<String, dynamic> data, Map<String, dynamic> template) {
  var mapped = mapTemplate(data, template);
  return compose(mapped);
}

Map<String, dynamic> mapTemplate(
    Map<String, dynamic> inputData, Map<String, dynamic> template) {
  final output = <String, dynamic>{};
  template.forEach((key, value) {
    if (value is String && value.startsWith('{')) {
      output[key] = inputData[value.replaceAll('{', '').replaceAll('}', '')];
    } else {
      output[key] = value;
    }
  });
  return output;
}
