import 'package:flutter/material.dart';

class RowDemo extends StatelessWidget {
  //for making it private
  _getContainer(var colorName){
    return Container(width: 100,height: 100, color: colorName,);
  }

  _getIcons(var icon){
    return Icon(
      icon,
      size: 30,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Layout examples')),
      body: Row(
        //opposite to layout
        crossAxisAlignment: CrossAxisAlignment.center,
        /*
        .stretch will take all the size availabel in crossAxis
        //along the Layout
        .center will align them from center
        .end align fom bottom

        .baseline - used with String arragement
        textBaseLine:TextBaseline.alphabetic- when we have same languages

        //if some other language use
        TextBaseline.ideographic    

        textDirection: TextDirection.rtl or ltr - left to right or right to left
        verticalDirection: VerticalDirection.down,    
        */
        mainAxisAlignment: MainAxisAlignment
        .spaceEvenly
        ,
        children: <Widget>[
          _getContainer(Colors.amberAccent),
          _getContainer(Colors.blueAccent),
        // _getContainer(Colors.redAccent),
          _getIcons(Icons.message)
      ],),
    );
  }
}
