import "package:flutter/material.dart";


class SNewProduct extends StatefulWidget {
  static const routeName = "/new-products";

  @override
  _SNewProductState createState() => _SNewProductState();
}

class _SNewProductState extends State<SNewProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptioFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit product"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "Title",),
                  textInputAction: TextInputAction.next,  // shows "->" on softkey
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(this._priceFocusNode),
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: "Price",),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: this._priceFocusNode,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(this._descriptioFocusNode),
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: "Description",),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: this._descriptioFocusNode,
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}