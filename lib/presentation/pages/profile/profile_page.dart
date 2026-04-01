import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Header
              CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'User Name',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                'user@example.com',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),

              // Stats Cards
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _StatCard(
                    title: 'Current Streak',
                    value: '7',
                    icon: Icons.local_fire_department,
                  ),
                  _StatCard(
                    title: 'Longest Streak',
                    value: '30',
                    icon: Icons.trending_up,
                  ),
                  _StatCard(
                    title: 'Calories Today',
                    value: '1,850',
                    icon: Icons.restaurant,
                  ),
                  _StatCard(
                    title: 'Daily Goal',
                    value: '2,000',
                    icon: Icons.flag,
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Achievements Section
              Text(
                'Achievements',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _BadgeWidget(icon: Icons.star, label: 'First Step'),
                  _BadgeWidget(
                      icon: Icons.calendar_today, label: 'Week Warrior'),
                  _BadgeWidget(icon: Icons.emoji_events, label: '7-Day Streak'),
                ],
              ),
              SizedBox(height: 24),

              // Settings Section
              Text(
                'Settings',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notification Time'),
                subtitle: Text('6:00 AM'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Show time picker
                },
              ),
              ListTile(
                leading: Icon(Icons.gps_fixed),
                title: Text('Daily Calorie Goal'),
                subtitle: Text('2000 calories'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Show goal editor
                },
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text('Language'),
                subtitle: Text('English'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Show language picker
                },
              ),
              SizedBox(height: 24),

              // Logout Button
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Logout
                },
                icon: Icon(Icons.logout),
                label: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeWidget extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BadgeWidget({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
