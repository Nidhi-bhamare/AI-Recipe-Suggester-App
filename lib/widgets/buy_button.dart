import 'package:flutter/material.dart';

class BuyButton extends StatelessWidget {
  const BuyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Redirecting to buy page...')),
        );
      },
      child: const Text('Buy'),
    );
  }
}
