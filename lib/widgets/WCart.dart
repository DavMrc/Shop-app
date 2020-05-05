import "package:flutter/material.dart";

class WCart extends StatefulWidget {
  @override
  _WCartState createState() => _WCartState();
}

class _WCartState extends State<WCart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          child: Icon(
            Icons.shopping_cart
          )
        ),
        
        Positioned(
          top: 8,
          right: 8,
          
          child: Container(
            // width: 20,
            // height: 20,
            // alignment: Alignment.topRight,
            constraints: BoxConstraints(
              minHeight: 16,
              minWidth: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).accentColor,
            ),
            child: Text(
              "k"
            ),
          ),
        ),
      ],
    );
  }
}