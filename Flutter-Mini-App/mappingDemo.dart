void main(){
  var list = [10,20,30,40,50];
  var modifiedList = list.map((e) => "Rs ${e}.00").toList();
  print(modifiedList);
}