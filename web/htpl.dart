// /***
//  * HTPL - HYPER TEXT PROGRAMMING LANGUAGE
//  *
//  * Hypertext progamming language is a computer programming language designed
//  * by Jerome Saltmarsh (30) on the April 17 of 2021.
//  *
//  * The point of the language is enable developers to
//  */
// import 'dart:io';
// import 'dart:convert';
//
//
// // void main(List<String> arguments) async {
// //
// // htpl(args)
// // }
//
// Future htpl(String args) async {
//   final helloFilePath = 'C:/Users/Jerome/github/dart-sort/hello.htpl';
//   final readFilePath = helloFilePath;
//   final File readFile = File(readFilePath);
//   final List<String> readFileLines = [];
//   String writeContent = "";
//   await readFile
//       .openRead()
//       .map(utf8.decode)
//       .transform(LineSplitter())
//       .forEach((line) {
//     readFileLines.add(line);
//     if(line.startsWith('<text')){
//       final lineValue = line
//           .replaceAll("<text:", "")
//           .replaceAll(">", "");
//       writeContent = lineValue;
//     }
//   });
//   print("imported ${readFile.path}");
//
//
//
//   final writeFileName = readFile.path.replaceAll('htpl', 'html');
//   final writeFile = File(writeFileName);
//   await writeFile.writeAsString(writeContent);
//   print('exported ${writeFile.absolute.path}');
//
//   // the next thing we need to do is generate a website with it using the html
//   // package
// }
