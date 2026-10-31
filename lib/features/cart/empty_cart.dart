import 'package:dokkan/features/cart/presentation/cart_card.dart';
import 'package:dokkan/features/cart/presentation/cart_screen.dart';
import 'package:flutter/material.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _hasProduct = true;

  @override
  Widget build(BuildContext context) {
    if (_hasProduct) {
      return FilledCartScreen(
        onCartEmptied: () {
          setState(() => _hasProduct = false);
        },
      );
    }

    return EmptyCartScreen(
      onExploreCollections: () {
        
      },
    );
  }
}
