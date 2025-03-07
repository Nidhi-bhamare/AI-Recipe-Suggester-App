import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _ingredientController = TextEditingController();
  List<dynamic> suggestedRecipes = [];
  final String apiKey =
      "ef99030b3fcb4413b41720d9be3634e1"; // Replace with your Spoonacular API key

  Future<void> fetchRecipes() async {
    if (_ingredientController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter ingredients!")),
      );
      return;
    }

    String ingredients =
        _ingredientController.text.replaceAll(" ", "").toLowerCase();
    String apiUrl =
        "https://api.spoonacular.com/recipes/findByIngredients?ingredients=$ingredients&number=5&apiKey=$apiKey";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          suggestedRecipes = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching recipes: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean background
      appBar: AppBar(
        title: const Text(
          'Recipe Finder 🍽️',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orangeAccent, // Beautiful accent color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Box
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: TextField(
                controller: _ingredientController,
                decoration: const InputDecoration(
                  labelText: 'Enter ingredients (comma separated)',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                  prefixIcon: Icon(Icons.search, color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Animated Search Button
            ElevatedButton(
              onPressed: fetchRecipes,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text(
                'Find Recipes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Recipes List
            Expanded(
              child: suggestedRecipes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/empty.png',
                              width: 120), // Add an empty state image
                          const SizedBox(height: 10),
                          const Text(
                            "No recipes found!",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: suggestedRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = suggestedRecipes[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4, // Shadow effect
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                recipe['image'],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              recipe['title'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.orange),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen(
                                    recipeId: recipe['id'],
                                    recipeTitle: recipe['title'],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
