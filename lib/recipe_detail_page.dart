import 'package:flutter/material.dart';

class RecipeDetailPage extends StatefulWidget {
  final String name;
  final List<String> details;
  final String description;
  final String videoUrl;

  const RecipeDetailPage({
    Key? key, // Key parametresi eklendi
    required this.name,
    required this.details,
    required this.description,
    required this.videoUrl,
  }) : super(key: key); // Super constructor düzeltildi

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {

  @override
  void initState() {
    super.initState();
    // WebViewController'ı başlatma
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Malzemeler:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...widget.details.map((d) => Text("- $d")),
            const SizedBox(height: 15),
            const Text(
              "Tarif Açıklaması:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(widget.description),
            const SizedBox(height: 15),
            const Text(
              "Yapılış Videosu:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            
          ],
        ),
      ),
    );
  }
}