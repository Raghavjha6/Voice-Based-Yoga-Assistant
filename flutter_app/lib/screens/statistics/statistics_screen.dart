import 'package:flutter/material.dart';

import '../../core/constants/image_urls.dart';
import '../../widgets/network_image_card.dart';
import '../../widgets/section_title.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  Widget reportTile({
    required IconData icon,
    required String title,
    required String accuracy,
    required String precision,
    required String recall,
    required String f1,
  }) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Accuracy : $accuracy\n\n"
            "Precision : $precision\n"
            "Recall : $recall\n"
            "F1 Score : $f1",
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Statistics")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.workspace_premium,
                          size: 70,
                          color: Colors.amber,
                        ),

                        SizedBox(height: 15),

                        Text(
                          "Best Performing Model",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          "Support Vector Machine",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 15),

                        Text("Accuracy", style: TextStyle(color: Colors.grey)),

                        SizedBox(height: 5),

                        Text(
                          "88.37 %",
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const SectionTitle(
                title: "Accuracy Comparison",
                icon: Icons.bar_chart,
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 420,
                child: NetworkImageCard(
                  title: "Model Accuracy",
                  imageUrl: ImageUrls.accuracy,
                ),
              ),

              const SizedBox(height: 25),

              const SectionTitle(
                title: "PCA Visualization",
                icon: Icons.scatter_plot,
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 420,
                child: NetworkImageCard(
                  title: "PCA Distribution",
                  imageUrl: ImageUrls.pca,
                ),
              ),

              const SizedBox(height: 30),

              const SectionTitle(
                title: "Confusion Matrices",
                icon: Icons.grid_view,
              ),

              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TabBar(
                  isScrollable: true,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "SVM"),

                    Tab(text: "LR"),

                    Tab(text: "DT"),

                    Tab(text: "NN"),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 460,
                child: TabBarView(
                  children: [
                    NetworkImageCard(
                      title: "Support Vector Machine",
                      imageUrl: ImageUrls.svm,
                    ),

                    NetworkImageCard(
                      title: "Logistic Regression",
                      imageUrl: ImageUrls.lr,
                    ),

                    NetworkImageCard(
                      title: "Decision Tree",
                      imageUrl: ImageUrls.dt,
                    ),

                    NetworkImageCard(
                      title: "Neural Network",
                      imageUrl: ImageUrls.nn,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const SectionTitle(
                title: "Classification Reports",
                icon: Icons.description,
              ),

              const SizedBox(height: 15),

              reportTile(
                icon: Icons.memory,
                title: "Support Vector Machine (SVM)",
                accuracy: "88.37%",
                precision: "0.89",
                recall: "0.88",
                f1: "0.88",
              ),

              reportTile(
                icon: Icons.analytics,
                title: "Logistic Regression",
                accuracy: "83.72%",
                precision: "0.84",
                recall: "0.84",
                f1: "0.84",
              ),

              reportTile(
                icon: Icons.account_tree,
                title: "Decision Tree",
                accuracy: "79.70%",
                precision: "0.79",
                recall: "0.79",
                f1: "0.79",
              ),

              reportTile(
                icon: Icons.psychology,
                title: "Neural Network",
                accuracy: "86.05%",
                precision: "0.86",
                recall: "0.86",
                f1: "0.86",
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
