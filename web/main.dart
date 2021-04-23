import 'dart:html';

void main() {
  var app = querySelector('#app');
  final element = Element.div();
  element.text = 'hello world';
  app.children.add(element);
}