import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 0,
      ),
      child: const Text('Add to Cart', style: TextStyle(fontSize: 12)),
    );
  }
}
