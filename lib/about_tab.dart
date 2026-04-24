import 'package:flutter/material.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple[700],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.only(top: 30, bottom: 40),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.deepPurple,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Daftar Belanja App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Versi 1.0.0",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Informasi Akademik",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _infoCard(
                    Icons.person_rounded,
                    "Dibuat Oleh",
                    "Muhammad Aziz Mustofa",
                  ),
                  _infoCard(Icons.code_rounded, "Teknologi", "Flutter & Dart"),
                  _infoCard(Icons.school_rounded, "Tujuan", "Latihan Flutter"),
                  const SizedBox(height: 15),
                  Text(
                    "Konsep yang Digunakan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _conceptChip("StatefulWidget"),
                _conceptChip("StatelessWidget"),
                _conceptChip("TabBar"),
                _conceptChip("ListView"),
                _conceptChip("SetState"),
                _conceptChip("Navigator"),
                _conceptChip("Row & Column"),
                _conceptChip("Container"),
              ],
            ),
            const SizedBox(height: 60)
          ],
        ),
      ),
    );
  }
}

Widget _infoCard(IconData icon, String label, String value) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.deepPurple[800]),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    ),
  );
}

Widget _conceptChip(String label) {
  return Chip(
    label: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 13),
    ),
    backgroundColor: Colors.deepPurple[400],
  );
}
