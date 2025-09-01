import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_text/recip_model.dart';
import 'package:live_text/recips.dart';

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

  void _loadRecipes() {
    final Map<String, dynamic> data = json.decode(jsonData);
    final List<dynamic> recipeList = data['recipes'];

    setState(() {
      recipes = recipeList.map((json) => Recipe.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Food Recipes"),
      ),
      body: recipes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.restaurant_menu),
                  title: Text(recipes[index].title),
                  subtitle: Text(recipes[index].description),
                );
              },
            ),
    );
  }
}
