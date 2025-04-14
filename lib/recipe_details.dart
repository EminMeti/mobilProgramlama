import 'package:flutter/material.dart';

class RecipeDetails extends StatelessWidget {
  final String recipeName;
  final List<String> ingredients;
  final String preparation;

  const RecipeDetails({
    super.key,
    required this.recipeName,
    required this.ingredients,
    required this.preparation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipeName,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/chef.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text('Malzemeler', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...ingredients.map((item) => ListTile(title: Text(item))),
            const Divider(),
            const Text('Hazırlanışı', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(preparation),
            ),
          ],
        ),
      ),
    );
  }
}
