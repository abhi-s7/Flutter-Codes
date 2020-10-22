void main(){

  Future<String> future = getFuture();
  print('Before Future comes after 5 seconds');
  future.then((value) => print(value));

}

Future<String> getFuture(){
  return Future.delayed(Duration(seconds: 5), ()=> 'Future successfully got....');
}