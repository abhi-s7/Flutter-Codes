import 'dart:io';
void main(){
  const path = 'E:\\IT\\Flutter\\BVICAM\\dart-basics\\day6 - Flutter\\music_app\\lib\\futuredemo.dart';
  File file = File(path);
  //File has been defined in both 'dart:io' and 'dart:html'
  print('Before Future');
  Future<String> future = file.readAsString();
  future.then((value) => print('Value is $value'))
        .catchError((err)=>print('Error is $err'))
        .whenComplete(() => 'This will run always irrespective of the result');
  
  print('After Future');
}