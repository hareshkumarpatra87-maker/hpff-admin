import 'package:flutter/material.dart';

void main() {
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HPFF Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        primaryColor: const Color(0xFFFFC107),
      ),
      home: const SplashScreen(),
    );
  }
}

// SPLASH SCREEN
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.local_fire_department, size: 100, color: Color(0xFFFFC107)),
            SizedBox(height: 20),
            Text('HPFF ARENA', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
            SizedBox(height: 8),
            Text('FREE FIRE TOURNAMENT', style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(height: 40),
            CircularProgressIndicator(color: Color(0xFFFFC107)),
          ],
        ),
      ),
    );
  }
}

// LOGIN PAGE
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _error = '';

  void _login() {
    if (_email.text.trim() == 'hareshkumarpatra87@gmail.com' &&
        _password.text.trim() == '8280384483H') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      setState(() => _error = 'ଭୁଲ୍ ଇମେଲ୍ କିମ୍ବା ପାସୱାର୍ଡ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_fire_department, size: 90, color: Color(0xFFFFC107)),
            const SizedBox(height: 16),
            const Text('HPFF ARENA', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
            const Text('ADMIN LOGIN', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 40),
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            if (_error.isNotEmpty) Text(_error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('LOGIN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// HOME PAGE WITH DRAWER
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HPFF ARENA ADMIN'),
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0D0D0D)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.local_fire_department, color: Color(0xFFFFC107), size: 40),
                  SizedBox(height: 8),
                  Text('HPFF ARENA', style: TextStyle(color: Color(0xFFFFC107), fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Admin Panel', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFFFFC107)),
              title: const Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events, color: Color(0xFFFFC107)),
              title: const Text('Create Tournament'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTournamentPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Color(0xFFFFC107)),
              title: const Text('Players'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayersPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment, color: Color(0xFFFFC107)),
              title: const Text('Payments'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.meeting_room, color: Color(0xFFFFC107)),
              title: const Text('Room ID'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RoomPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.leaderboard, color: Color(0xFFFFC107)),
              title: const Text('Leaderboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LeaderboardPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _card('Tournaments', '12', Icons.emoji_events, Colors.amber)),
                const SizedBox(width: 12),
                Expanded(child: _card('Players', '248', Icons.people, Colors.blue)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _card('Entry Money', '₹18,750', Icons.monetization_on, Colors.green)),
                const SizedBox(width: 12),
                Expanded(child: _card('Upcoming', '2', Icons.schedule, Colors.orange)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}

// CREATE TOURNAMENT
class CreateTournamentPage extends StatefulWidget {
  const CreateTournamentPage({super.key});
  @override
  State<CreateTournamentPage> createState() => _CreateTournamentPageState();
}

class _CreateTournamentPageState extends State<CreateTournamentPage> {
  final _name = TextEditingController();
  final _entry = TextEditingController();
  final _prize = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Tournament'),
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _name, decoration: const InputDecoration(labelText: 'Tournament Name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _entry, decoration: const InputDecoration(labelText: 'Entry Fee', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _prize, decoration: const InputDecoration(labelText: 'Prize Pool', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tournament Created!')));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('CREATE'),
            ),
          ],
        ),
      ),
    );
  }
}

// PLAYERS PAGE
class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Players'),
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: const [
          ListTile(leading: CircleAvatar(child: Text('R')), title: Text('RakeshFF'), subtitle: Text('UID: 12345678')),
          ListTile(leading: CircleAvatar(child: Text('N')), title: Text('Nitesh_07'), subtitle: Text('UID: 23456789')),
          ListTile(leading: CircleAvatar(child: Text('L')), title: Text('LegendBoy'), subtitle: Text('UID: 34567890')),
        ],
      ),
    );
  }
}

// PAYMENTS PAGE
class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.check_circle, color: Colors.green), title: Text('Tournament Entry'), trailing: Text('₹50')),
          ListTile(leading: Icon(Icons.check_circle, color: Colors.green), title: Text('Prize Distribution'), trailing: Text('₹1,000')),
        ],
      ),
    );
  }
}

// ROOM PAGE
class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room ID'),
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Room ID', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Published!')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('PUBLISH'),
            ),
          ],
        ),
      ),
    );
  }
}

// LEADERBOARD PAGE
class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: const [
          ListTile(leading: Text('1'), title: Text('RakeshFF'), trailing: Text('₹5,000')),
          ListTile(leading: Text('2'), title: Text('Nitesh_07'), trailing: Text('₹3,000')),
          ListTile(leading: Text('3'), title: Text('LegendBoy'), trailing: Text('₹2,000')),
        ],
      ),
    );
  }
}
