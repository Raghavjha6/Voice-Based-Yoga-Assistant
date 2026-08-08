import 'package:flutter/material.dart';

class NetworkImageCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const NetworkImageCard({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.contain,

              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;

                return const Center(child: CircularProgressIndicator());
              },

              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
