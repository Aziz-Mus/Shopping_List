import 'package:flutter/material.dart';

class SummaryTab extends StatelessWidget {
  final List<Map<String, dynamic>> shoppingList;
  const SummaryTab({super.key, required this.shoppingList});

  @override
  Widget build(BuildContext context) {
    int totalItems = shoppingList.length;
    int boughtItems = shoppingList
        .where((item) => item['isBought'] == true)
        .length;
    int remainingItems = totalItems - boughtItems;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple[700],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    "Ringkasan Belanja",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _statCard(
                          "Total",
                          totalItems.toString(),
                          Icons.list_alt,
                          Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: _statCard(
                          "Dibeli",
                          boughtItems.toString(),
                          Icons.check_circle,
                          Colors.green,
                        ),
                      ),
                      Expanded(
                        child: _statCard(
                          "Sisa",
                          remainingItems.toString(),
                          Icons.pending,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Text(
                    "Detail per Kategori",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _categoryCard("Makanan", Icons.restaurant, Colors.orange),
                  _categoryCard("Minuman", Icons.local_cafe, Colors.brown),
                  _categoryCard("Kebutuhan Rumah", Icons.home, Colors.blue),
                  _categoryCard("Lainnya", Icons.more_horiz, Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryCard(String category, IconData icon, Color color) {
    int count = shoppingList
        .where((item) => item['category'] == category)
        .length;
    int bought = shoppingList
        .where(
          (item) => item['category'] == category && item['isBought'] == true,
        )
        .length;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox.shrink(),
        ),
        title: Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$bought/$count item sudah dibeli"),
        trailing: Text(
          "$count",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}

Widget _statCard(String title, String value, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Icon(icon, size: 28, color: Colors.white),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title, 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 12,
            fontWeight: FontWeight.bold
          )
        ),
      ],
    ),
  );
}
