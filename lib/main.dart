import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_options.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFC107),
          secondary: Color(0xFFFFC107),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ================= SPLASH SCREEN =================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToLogin();
  }

  Future<void> _goToLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_fire_department, size: 100, color: Color(0xFFFFC107)),
            const SizedBox(height: 20),
            const Text('HPFF ARENA', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
            const SizedBox(height: 8),
            const Text('FREE FIRE TOURNAMENT', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Color(0xFFFFC107)),
          ],
        ),
      ),
    );
  }
}

// ================= LOGIN PAGE =================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    if (_emailController.text.trim() == 'hareshkumarpatra87@gmail.com' &&
        _passwordController.text.trim() == '8280384483H') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminHomePage()),
      );
    } else {
      setState(() => _errorMessage = 'ଭୁଲ୍ ଇମେଲ୍ କିମ୍ବା ପାସୱାର୍ଡ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_fire_department, size: 90, color: Color(0xFFFFC107)),
            const SizedBox(height: 16),
            const Text('HPFF ARENA', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
            const Text('FREE FIRE TOURNAMENT', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            if (_errorMessage.isNotEmpty) Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 50)),
              child: const Text('LOGIN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= ADMIN HOME =================
class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HPFF ARENA ADMIN'),
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.black,
      ),
      drawer: const AdminDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('tournaments').snapshots(),
              builder: (context, tournamentSnap) {
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').snapshots(),
                  builder: (context, userSnap) {
                    final tournaments = tournamentSnap.data?.docs ?? [];
                    final users = userSnap.data?.docs ?? [];

                    int totalTournaments = tournaments.length;
                    int totalPlayers = users.length;
                    int upcoming = 0;
                    int entryMoney = 0;

                    for (var doc in tournaments) {
                      final data = doc.data() as Map<String, dynamic>;
                      if (data['status'] == 'upcoming') upcoming++;
                      final fee = int.tryParse(data['entryFee']?.toString() ?? '0') ?? 0;
                      entryMoney += fee;
                    }

                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: _statCard('Total Tournaments', '$totalTournaments', Icons.emoji_events, Colors.amber)),
                            const SizedBox(width: 12),
                            Expanded(child: _statCard('Total Players', '$totalPlayers', Icons.people, Colors.blue)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: _statCard('Entry Money', '₹$entryMoney', Icons.monetization_on, Colors.green)),
                            const SizedBox(width: 12),
                            Expanded(child: _statCard('Upcoming', '$upcoming', Icons.schedule, Colors.orange)),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.8,
              children: [
                _actionBtn(context, 'Create Tournament', Icons.emoji_events, Colors.amber, const CreateTournamentPage()),
                _actionBtn(context, 'View Players', Icons.people, Colors.green, const PlayersPage()),
                _actionBtn(context, 'View Payments', Icons.payment, Colors.pink, const PaymentsPage()),
                _actionBtn(context, 'QR Upload', Icons.qr_code, Colors.purple, const QrUploadPage()),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Recent Tournaments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('tournaments')
                  .orderBy('createdAt', descending: true)
                  .limit(3)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return const Text('No tournaments yet', style: TextStyle(color: Colors.grey));
                }
                return Column(
                  children: docs.map((doc) {
                    final d = doc.data() as Map<String, dynamic>;
                    return _tournamentTile(
                      d['name'] ?? 'Unknown',
                      '${d['entryFee'] ?? '0'} Fee • ${d['date'] ?? ''}',
                      d['status'] ?? 'upcoming',
                      d['status'] == 'live' ? Colors.green : (d['status'] == 'upcoming' ? Colors.orange : Colors.grey),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
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

  Widget _actionBtn(BuildContext context, String label, IconData icon, Color color, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _tournamentTile(String name, String subtitle, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.gamepad, color: statusColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 3),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(status, style: TextStyle(fontSize: 10, color: statusColor)),
          ),
        ],
      ),
    );
  }
}

// ================= DRAWER =================
class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A1A),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF0D0D0D)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.local_fire_department, color: Color(0xFFFFC107), size: 40),
                SizedBox(height: 8),
                Text('HPFF ARENA', style: TextStyle(color: Color(0xFFFFC107), fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Admin Panel', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          _drawerItem(context, 'Dashboard', Icons.home, const AdminHomePage()),
          _drawerItem(context, 'Create Tournament', Icons.emoji_events, const CreateTournamentPage()),
          _drawerItem(context, 'Players', Icons.people, const PlayersPage()),
          _drawerItem(context, 'Payments', Icons.payment, const PaymentsPage()),
          _drawerItem(context, 'QR Upload', Icons.qr_code, const QrUploadPage()),
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
    );
  }

  Widget _drawerItem(BuildContext context, String title, IconData icon, Widget page) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFFC107)),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}

// ================= CREATE TOURNAMENT =================
class CreateTournamentPage extends StatefulWidget {
  const CreateTournamentPage({super.key});
  @override
  State<CreateTournamentPage> createState() => _CreateTournamentPageState();
}

class _CreateTournamentPageState extends State<CreateTournamentPage> {
  final _name = TextEditingController();
  final _entry = TextEditingController();
  final _prize = TextEditingController();
  final _date = TextEditingController();
  final _time = TextEditingController();
  final _roomId = TextEditingController();
  final _roomPass = TextEditingController();
  bool _saving = false;

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await FirebaseFirestore.instance.collection('tournaments').add({
        'name': _name.text.trim(),
        'entryFee': _entry.text.trim(),
        'prize': _prize.text.trim(),
        'date': _date.text.trim(),
        'time': _time.text.trim(),
        'roomId': _roomId.text.trim(),
        'roomPass': _roomPass.text.trim(),
        'game': 'Free Fire',
        'status': 'upcoming',
        'players': '0',
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tournament Created!')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Tournament'), backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          _field(_name, 'Tournament Name'),
          _field(_entry, 'Entry Fee'),
          _field(_prize, 'Prize Pool'),
          _field(_date, 'Date'),
          _field(_time, 'Time'),
          _field(_roomId, 'Room ID'),
          _field(_roomPass, 'Room Password'),
          const SizedBox(height: 20),
          _saving ? const CircularProgressIndicator() : ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 50)),
            child: const Text('SAVE TOURNAMENT', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }

  Widget _field(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(controller: c, decoration: InputDecoration(labelText: label, border: const OutlineInputBorder())),
    );
  }
}

// ================= PLAYERS PAGE =================
class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Players'), backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return const Center(child: Text('No players yet'));
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final d = docs[i].data() as Map<String, dynamic>;
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(d['name'] ?? 'Unknown'),
                subtitle: Text('UID: ${d['uid'] ?? '-'}'),
              );
            },
          );
        },
      ),
    );
  }
}

// ================= PAYMENTS PAGE =================
class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Requests'), backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('payments').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return const Center(child: Text('No payment requests'));
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final d = docs[i].data() as Map<String, dynamic>;
              return ListTile(
             
