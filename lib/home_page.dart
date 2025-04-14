import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:login/recipe_details.dart';

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
  FocusNode focusNode = FocusNode();

  List<Map<String, dynamic>> allRecipes = [
    {
      'name': 'Omlet',
      'ingredients': ['2 adet Yumurta', '1 yemek kaşığı Süt', 'Tuz'],
      'details': ['Yumurta', 'Süt', 'Tuz'],
      'preparation': 'Yumurtaları bir kaba kırın, süt ve tuz ekleyerek çırpın. Tavada pişirin.'
    },
    {
      'name': 'Menemen',
      'ingredients': ['2 adet Domates', '1 adet Biber', '2 adet Yumurta'],
      'details': ['Domates', 'Biber', 'Yumurta'],
      'preparation': 'Biber ve domatesleri doğrayıp kavurun. Yumurtaları kırıp karıştırın.'
    },
    {
      'name': 'Patates Kızartması',
      'ingredients': ['2 adet Patates', '1 su bardağı Sıvı Yağ'],
      'details': ['Patates', 'Yağ'],
      'preparation': 'Patatesleri doğrayıp kızgın yağda kızartın.'
    },
    {
      'name': 'Kek',
      'ingredients': ['2 su bardağı Un', '1 su bardağı Şeker', '2 adet Yumurta', '1 su bardağı Süt'],
      'details': ['Un', 'Şeker', 'Yumurta', 'Süt'],
      'preparation': 'Tüm malzemeleri karıştırın. Yağlanmış kalıba döküp fırında pişirin.'
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
          .where((product) => product.toLowerCase().startsWith(query.toLowerCase()))
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
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(focusNode); // Klavye açılmasını engelle
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                                  controller: searchController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    labelText: 'Ürün ara...',
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    filterProducts(value);
                                  },
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: ListView(
                                    children: filteredProducts.map((product) {
                                      return CheckboxListTile(
                                        title: Text(product),
                                        value: selectedProducts.contains(product),
                                        onChanged: (bool? value) {
                                          toggleProduct(product);
                                          setModalState(() {}); // Modal'ı güncelle
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredProducts = List.from(allProducts);
                                        searchController.clear(); // Sıfırlama
                                      });
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
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Ürün ara...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
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
                        filteredRecipes[index]['name'],
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        filteredRecipes[index]['details'].join(", "),
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetails(
                              recipeName: filteredRecipes[index]['name'],
                              ingredients: List<String>.from(filteredRecipes[index]['ingredients']),
                              preparation: filteredRecipes[index]['preparation'],
                            ),
                          ),
                        );
                      },
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
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                  child: Icon(Icons.close, color: Colors.black, size: 16),
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
