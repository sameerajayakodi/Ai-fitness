import 'package:flutter/material.dart';

class MealPlansPage extends StatefulWidget {
  const MealPlansPage({Key? key}) : super(key: key);

  @override
  State<MealPlansPage> createState() => _MealPlansPageState();
}

class _MealPlansPageState extends State<MealPlansPage> {
  final List<Map<String, dynamic>> _weeklyMeals = [
    {
      'day': 'Monday',
      'meals': ['Oatmeal with fruits', 'Grilled Chicken Salad', 'Baked Salmon'],
      'totalCalories': 1800,
    },
    {
      'day': 'Tuesday',
      'meals': [
        'Eggs and Toast',
        'Turkey Sandwich',
        'Lean Beef with Vegetables'
      ],
      'totalCalories': 1750,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plans'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // TODO: Randomize meal plan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekly Calorie Goal',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '2000 calories/day',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _weeklyMeals.length,
              itemBuilder: (context, index) {
                final day = _weeklyMeals[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ExpansionTile(
                    title: Text(day['day']),
                    subtitle: Text('${day['totalCalories']} calories'),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var meal in day['meals'])
                              Padding(
                                padding: EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: [
                                    Icon(Icons.restaurant, size: 20),
                                    SizedBox(width: 12),
                                    Expanded(child: Text(meal)),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Generate new meal plan
                },
                icon: Icon(Icons.create),
                label: Text('Generate New Plan'),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
