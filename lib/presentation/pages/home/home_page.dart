import 'package:ai_fitness/presentation/pages/chat/chat_page.dart';
import 'package:ai_fitness/presentation/pages/food_recognition/food_recognition_page.dart';
import 'package:ai_fitness/presentation/pages/meal_plans/meal_plans_page.dart';
import 'package:ai_fitness/presentation/pages/profile/profile_page.dart';
import 'package:ai_fitness/presentation/pages/tasks/tasks_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _navigateToPage(Widget page, int index) {
    setState(() {
      _currentIndex = index;
    });

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void _onBottomNavigationTap(int index) {
    if (index == 0) {
      setState(() {
        _currentIndex = 0;
      });
      return;
    }

    switch (index) {
      case 1:
        _navigateToPage(const ChatPage(), index);
        break;
      case 2:
        _navigateToPage(const TasksPage(), index);
        break;
      case 3:
        _navigateToPage(const MealPlansPage(), index);
        break;
      case 4:
        _navigateToPage(const ProfilePage(), index);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Fitness'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to AI Fitness',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 24),
            Text(
              'Get ready to transform your fitness journey!',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {
                _navigateToPage(const ChatPage(), 1);
              },
              icon: const Icon(Icons.chat),
              label: const Text('Start Chatting'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                _navigateToPage(const TasksPage(), 2);
              },
              icon: const Icon(Icons.assignment),
              label: const Text('View Daily Tasks'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const FoodRecognitionPage(),
                  ),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Scan Food'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                _navigateToPage(const MealPlansPage(), 3);
              },
              icon: const Icon(Icons.restaurant),
              label: const Text('View Meal Plan'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: _currentIndex,
        onTap: _onBottomNavigationTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
