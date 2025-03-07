import 'package:flutter/material.dart';

import '../models/recipe.dart';
import 'buy_button.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(recipe.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("Ingredients: ${recipe.ingredients.join(', ')}"),
        trailing: BuyButton(),
      ),
    );
  }
}
