import 'package:flutter/material.dart';
import './category_screen.dart';
import './upload_screen.dart';
import '../widgets/category_card.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Books', 'icon': Icons.book, 'color': Colors.blue},
      {'name': 'PDFs', 'icon': Icons.picture_as_pdf, 'color': Colors.red},
      {'name': 'Mark Sheets', 'icon': Icons.assessment, 'color': Colors.green},
      {'name': 'Documents', 'icon': Icons.description, 'color': Colors.orange},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('File Manager'),
      ),
      drawer: const CustomDrawer(),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            name: categories[index]['name'],
            icon: categories[index]['icon'],
            color: categories[index]['color'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    category: categories[index]['name'],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UploadScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
