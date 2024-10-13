import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorite.dart';
import 'history.dart';
import 'cart.dart';
import 'detail.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartItemsProvider()),
        ChangeNotifierProvider(create: (_) => LikedItemsProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class HistoryProvider with ChangeNotifier {
  final List<Map<String, String>> _viewedItems = [];

  List<Map<String, String>> get viewedItems => _viewedItems;

  void addToHistory(Map<String, String> item) {
    if (!_viewedItems.contains(item)) {
      _viewedItems.add(item);
      notifyListeners();
    }
  }

  void removeFromHistory(Map<String, String> item) {
    _viewedItems.remove(item);
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build (BuildContext context) {
    return const MaterialApp(
      home: AmazonLikeScreen()
    );
  }
}

class AmazonLikeScreen extends StatefulWidget{
  const AmazonLikeScreen({super.key});

  @override
  AmazonLikeScreenState createState() => AmazonLikeScreenState();
}

class AmazonLikeScreenState extends State<AmazonLikeScreen> {
  String search = "";

  // Product Info
  final List<Map<String, String>> items = [
    {
      "image": "Images/Bottles/Bottle 4.png",
      "name": "Infinity Bottle",
      "price": "Rs. 599",
      "desc": "The Infinity Bottle offers sleek, modern design combined with exceptional durability. Keep your drinks fresh and cool all day long. Its leak-proof build ensures no spills, making it the ideal companion for both workouts and outdoor adventures."
    },
    {
      "image": "Images/SPs/SP 2.png",
      "name": "iPhone 15",
      "price": "Rs. 99999",
      "desc": "The iPhone 15 redefines innovation with its advanced A15 Bionic chip, enhanced camera system, and stunning Super Retina XDR display. Experience unmatched performance and 5G connectivity in a premium design that combines elegance and power."
    },
    {
      "image": "Images/Bottles/Bottle 2.png",
      "name": "Milton Bottle",
      "price": "Rs. 299",
      "desc": "Stay hydrated with the Milton Bottle, known for its rugged build and sleek design. Perfect for daily use, it’s lightweight and ensures your drinks stay fresh. A must-have for school, office, or outdoor activities."
    },
    {
      "image": "Images/SPs/SP 1.png",
      "name": "Oppo Smartphone",
      "price": "Rs. 49999",
      "desc": "The Oppo Smartphone brings exceptional performance with a cutting-edge camera system and a vivid display. Designed to enhance your mobile experience, this phone is perfect for photography enthusiasts and tech-savvy users."
    },
    {
      "image": "Images/Pens/Pen 1.png",
      "name": "Energel Pen",
      "price": "Rs. 99",
      "desc": "Write with precision and ease using the Energel Pen. Known for its smooth flow and quick-drying ink, this pen is perfect for students and professionals alike. A reliable companion for note-taking and detailed writing."
    },
    {
      "image": "Images/Vaselines/Vaseline 1.png",
      "name": "Vaseline Original",
      "price": "Rs. 399",
      "desc": "Vaseline Original is your go-to skincare product for soft, smooth skin. Its petroleum jelly formula locks in moisture, protecting your skin from dryness and providing relief from chapped areas. A household essential for everyday skin care."
    },
    {
      "image": "Images/Vaselines/Vaseline 3.jpg",
      "name": "Vaseline Lip Therapy",
      "price": "Rs. 249",
      "desc": "Vaseline Lip Therapy provides intense hydration for soft, smooth lips. Enriched with healing properties, this balm repairs dry, cracked lips while locking in moisture, leaving you with a healthy and nourished pout."
    },
    {
      "image": "Images/Pens/Pen 2.png",
      "name": "Fountain Pen",
      "price": "Rs. 999",
      "desc": "Experience the art of writing with this elegant Fountain Pen. Crafted with precision, it offers smooth ink flow and a classic design. Ideal for those who appreciate traditional writing instruments with a modern touch."
    },
    {
      "image": "Images/Pens/Pen 4.png",
      "name": "V2 Gel Pen",
      "price": "Rs. 199",
      "desc": "The V2 Gel Pen offers consistent writing performance with a fine tip for detailed work. Its comfortable grip and quick-drying ink make it an excellent choice for students, artists, and professionals looking for precision and comfort."
    },
    {
      "image": "Images/Bottles/Bottle 3.png",
      "name": "Decathlon Bottle",
      "price": "Rs. 259",
      "desc": "Stay refreshed during your workouts with the Decathlon Bottle. Lightweight and durable, it’s designed for fitness enthusiasts. The ergonomic design ensures a comfortable grip while the leak-proof lid keeps spills at bay."
    },
    {
      "image": "Images/Vaselines/Vaseline 4.png",
      "name": "Vaseline Gluta-Hya",
      "price": "Rs. 399",
      "desc": "Vaseline Gluta-Hya offers deep hydration and skin-brightening benefits. With a formula enriched with glutathione and hyaluronic acid, it locks in moisture and brightens dull skin, giving you a radiant and youthful glow."
    },
    {
      "image": "Images/SPs/SP 4.png",
      "name": "Huawei Smartphone",
      "price": "Rs. 10299",
      "desc": "The Huawei Smartphone delivers reliable performance with a strong battery life, crisp display, and fast processing. Whether for work or play, this budget-friendly device keeps you connected with its seamless multitasking capabilities."
    },
    {
      "image": "Images/Bottles/Bottle 1.png",
      "name": "Steel Bottle",
      "price": "Rs. 199",
      "desc": "This Steel Bottle is perfect for the eco-conscious individual. Durable and lightweight, it keeps beverages cold or hot for hours. Ideal for commuting, gym, or travel, this bottle blends functionality with a sleek, minimalist design."
    },
    {
      "image": "Images/Vaselines/Vaseline 2.png",
      "name": "Vaseline Moisturizer",
      "price": "Rs. 499",
      "desc": "Vaseline Moisturizer provides long-lasting hydration for dry skin. Enriched with natural ingredients, it nourishes and soothes, making it ideal for everyday use. Keeps your skin soft and smooth all day long."
    },
    {
      "image": "Images/Pens/Pen 3.png",
      "name": "Coloured Pens Set",
      "price": "Rs. 299",
      "desc": "Add a splash of color to your notes with this Coloured Pens Set. Perfect for creative projects, these pens offer smooth writing with vibrant colors. A must-have for artists, students, and anyone who loves colorful organization."
    },
    {
      "image": "Images/SPs/SP 3.png",
      "name": "Smartphone",
      "price": "Rs. 11999",
      "desc": "This Smartphone combines great performance with a budget-friendly price. Featuring a sleek design and a long-lasting battery, it’s perfect for multitasking, entertainment, and staying connected on the go. A great choice for everyday use."
    }
  ];

  // Color Palette | Steel Blue & Off-White
  // Steel Blue: Color(0xFF4682B4)
  // 87% Black: Colors.black87
  // Indian Red: Color(0xFFCD5C5C)
  // Off-White: Color(0xFFFAFAFA)

  @override
  Widget build (BuildContext context) {
    // Filter Items based on Query
    final filteredItems = items.where((item) {
      final itemName = item['name']!.toLowerCase();
      return itemName.contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: const Color(0xFF4682B4),
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search",
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  search = value; // Update Search Query
                });
              },
            )
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];

                return InkWell(
                    onTap: () {
                      // Save to history before navigating
                      try {
                        Provider.of<HistoryProvider>(context, listen: false).addToHistory(item);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Failed to Add Item to History: $e"))
                        );
                      }
                      // Provider.of<HistoryProvider>(context, listen: false).addToHistory(item);

                      // Navigate to Product Detail
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(item: item),
                        ),
                      );
                    },
                  child: Container(
                    color: const Color(0xFFF0F0F0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children : [
                            Image.asset(item["image"]!, height: 150, width: 150),
                            Text(item["name"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(item["price"]!, style: const TextStyle(color: Color(0xFFCD5C5C))),
                          ]
                        )
                      ],
                    ),
                  )
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History'
          )
        ],
        selectedItemColor: const Color(0xFF4682B4),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.black87,
        type: BottomNavigationBarType.fixed, // Ensure even spacing of items
          onTap: (index) {
            try {
              if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FavoriteScreen())
                );
              } else if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen())
                );
              } else if (index == 3) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryScreen())
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Navigation error: $e"))
              );
            }
          }

      ),
    );
  }
}