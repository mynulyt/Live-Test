import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_text/recip_model.dart';

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({super.key});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/recipes.json',
      );
      final Map<String, dynamic> data = json.decode(response);
      final List<dynamic> recipeList = data['recipes'];
      setState(() {
        recipes = recipeList.map((json) => Recipe.fromJson(json)).toList();
      });
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food Recipes")),
      body: recipes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.restaurant_menu),
                  title: Text(recipes[index].title),
                  subtitle: Text(recipes[index].description),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(recipes[index].title),
                        content: Text(
                          "Ingredients:\n${recipes[index].ingredients.join(", ")}",
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
