import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Morning Stretch',
      'duration': 10,
      'completed': false,
      'category': 'Stretching',
    },
    {
      'title': 'Meditation',
      'duration': 15,
      'completed': false,
      'category': 'Meditation',
    },
    {
      'title': 'Morning Run',
      'duration': 30,
      'completed': false,
      'category': 'Cardio',
    },
    {
      'title': 'Drink Water',
      'duration': 5,
      'completed': false,
      'category': 'Hydration',
    },
  ];

  int _completedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Tasks'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Progress',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: _completedCount / _tasks.length,
                    minHeight: 10,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '$_completedCount/${_tasks.length} tasks completed',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return CheckboxListTile(
                  value: task['completed'],
                  onChanged: (value) {
                    setState(() {
                      _tasks[index]['completed'] = value ?? false;
                      _completedCount = _tasks
                          .where((t) => t['completed'])
                          .length;
                    });
                  },
                  title: Text(task['title']),
                  subtitle: Text(
                    '${task['duration']} minutes • ${task['category']}',
                  ),
                  enabled: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
