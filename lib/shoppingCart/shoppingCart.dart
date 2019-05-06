import 'package:flutter/material.dart';
import '../components/component.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Text('购物车'),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }
}
