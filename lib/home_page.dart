import 'package:flutter/material.dart';
import 'package:login/login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RecipeSearchScreen();
  }
}

class RecipeSearchScreen extends StatefulWidget {
  @override
  _RecipeSearchScreenState createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> allRecipes = [
    {
      'name': 'Omlet',
      'details': ['Yumurta', 'Süt', 'Tuz']
    },
    {
      'name': 'Menemen',
      'details': ['Domates', 'Biber', 'Yumurta']
    },
    {
      'name': 'Patates Kızartması',
      'details': ['Patates', 'Yağ']
    },
    {
      'name': 'Kek',
      'details': ['Un', 'Şeker', 'Yumurta', 'Süt']
    },
  ];

  List<String> allProducts = [
    'Süt',
    'Yumurta',
    'Un',
    'Domates',
    'Yağ',
    'Tuz',
    'Şeker',
    'Peynir',
    'Zeytin',
    'Maydanoz'
  ];

  List<String> selectedProducts = [];
  List<Map<String, dynamic>> filteredRecipes = [];
  List<String> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredRecipes = List.from(allRecipes);
    filteredProducts = List.from(allProducts);
  }

  void toggleProduct(String product) {
    setState(() {
      if (selectedProducts.contains(product)) {
        selectedProducts.remove(product);
      } else {
        selectedProducts.add(product);
      }
      filterRecipes();
    });
  }

  void filterRecipes() {
    setState(() {
      if (selectedProducts.isEmpty) {
        filteredRecipes = List.from(allRecipes);
      } else {
        filteredRecipes = allRecipes.where((recipe) {
          List<String> recipeIngredients = List<String>.from(recipe['details']);
          return Set.from(selectedProducts).containsAll(recipeIngredients);
        }).toList();
      }
    });
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = allProducts
          .where(
              (product) => product.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tarif Seçimi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Ürün ara...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setModalState) {
                        return FractionallySizedBox(
                          heightFactor: 0.5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Ürün ara...',
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setModalState(() {
                                      filteredProducts = allProducts
                                          .where((product) => product
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                          .toList();
                                    });
                                  },
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: ListView(
                                    children: filteredProducts.map((product) {
                                      return CheckboxListTile(
                                        title: Text(product),
                                        value:
                                            selectedProducts.contains(product),
                                        onChanged: (bool? value) {
                                          toggleProduct(product);
                                          setModalState(() {});
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Kaydet'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        filteredRecipes[index]['name']!,
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        filteredRecipes[index]['details'].join(", "),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            selectedProducts.isEmpty
                ? SizedBox.shrink()
                : Container(
                    width: double.infinity,
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: selectedProducts.map((product) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  product,
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () => toggleProduct(product),
                                  child: Icon(Icons.close,
                                      color: Colors.black, size: 16),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
