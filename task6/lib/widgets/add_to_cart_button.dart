import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddToCartButton({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
