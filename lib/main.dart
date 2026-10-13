import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminHomePage()));
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
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
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
            Row(
              children: const [
                Expanded(child: _StatCard(title: 'Total Tournaments', value: '12', icon: Icons.emoji_events, color: Colors.amber)),
                SizedBox(width: 12),
                Expanded(child: _StatCard(title: 'Total Players', value: '248', icon: Icons.people, color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(child: _StatCard(title: 'Entry Money', value: '₹18,750', icon: Icons.monetization_on, color: Colors.green)),
                SizedBox(width: 12),
                Expanded(child: _StatCard(title: 'Upcoming', value: '2', icon: Icons.schedule, color: Colors.orange)),
              ],
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
                _actionBtn(context, 'Players', Icons.people, Colors.green, const PlayersPage()),
                _actionBtn(context, 'Payments', Icons.payment, Colors.pink, const PaymentsPage()),
                _actionBtn(context, 'QR Upload', Icons.qr_code, Colors.purple, const QrUploadPage()),
                _actionBtn(context, 'Room ID', Icons.meeting_room, Colors.cyan, const RoomPage()),
                _actionBtn(context, 'Leaderboard', Icons.leaderboard, Colors.deepOrange, const LeaderboardPage()),
                _actionBtn(context, 'Notifications', Icons.notifications, Colors.indigo, const NotificationsPage()),
                _actionBtn(context, 'Settings', Icons.settings, Colors.grey, const SettingsPage()),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Recent Tournaments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _tournamentTile('Solo Clash', 'Free • Solo • 13 Oct 2026', 'Ongoing', Colors.green),
            _tournamentTile('One Tap King', 'Paid • Solo • 12 Oct 2026', 'Completed', Colors.grey),
            _tournamentTile('Fire Cup', 'Free • Solo • 11 Oct 2026', 'Completed', Colors.grey),
          ],
        ),
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
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _tournamentTile(String name, String subtitle, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(width: 45, height: 45, decoration: BoxDecoration(color: statusColor.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.gamepad, color: statusColor)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 3),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: statusColor.withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: Text(status, style: TextStyle(fontSize: 10, color: statusColor))),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.4))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ]),
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
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: const [
              Icon(Icons.local_fire_department, color: Color(0xFFFFC107), size: 40),
              SizedBox(height: 8),
              Text('HPFF ARENA', style: TextStyle(color: Color(0xFFFFC107), fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Admin Panel', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
          ),
          _drawerItem(context, 'Dashboard', Icons.home, const AdminHomePage()),
          _drawerItem(context, 'Create Tournament', Icons.emoji_events, const CreateTournamentPage()),
          _drawerItem(context, 'Players', Icons.people, const PlayersPage()),
          _drawerItem(context, 'Payments', Icons.payment, const PaymentsPage()),
          _drawerItem(context, 'QR Upload', Icons.qr_code, const QrUploadPage()),
          _drawerItem(context, 'Room ID', Icons.meeting_room, const RoomPage()),
          _drawerItem(context, 'Leaderboard', Icons.leaderboard, const LeaderboardPage()),
          _drawerItem(context, 'Notifications', Icons.notifications, const NotificationsPage()),
          _drawerItem(context, 'Settings', Icons.settings, const SettingsPage()),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false),
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
  final _slots = TextEditingController();
  String _mode = 'Solo';
  String _type = 'Free';

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tournament Created!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Tournament'), backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          _field(_name, 'Tournament Name'),
          DropdownButtonFormField<String>(
            value: _mode,
            decoration: const InputDecoration(labelText: 'Game Mode', border: OutlineInputBorder()),
            items: ['Solo', 'Duo', 'Squad', 'Clash Squad'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => _mode = v!),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _type,
            decoration: const InputDecoration(labelText: 'Entry Type', border: OutlineInputBorder()),
            items: ['Free', 'Paid'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => _type = v!),
          ),
          const SizedBox(height: 12),
          _field(_entry, 'Entry Fee'),
          _field(_prize, 'Prize Pool'),
          _field(_date, 'Date'),
          _field(_time, 'Time'),
          _field(_slots, 'Total Slots'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 50)),
            child: const Text('CREATE TOURNAMENT', style: TextStyle(fontWeight: FontWeight.bold)),
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
      appBar: AppBar(title: const Text('Player Management'), backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: CircleAvatar(child: Text('R')), title: Text('RakeshFF'), subtitle: Text('UID: 12345678'), trailing: Text('Approved', style: TextStyle(color: Colors.green))),
          ListTile(leading: CircleAvatar(child: Text('N')), title: Text('Nitesh_07'), subtitle: Text('UID: 23456789'), trailing: Text('Approved', style: TextStyle(color: Colors.green))),
          ListTile(leading: CircleAvatar(child: Text('L')), title: Text('LegendBoy'), subtitle: Text('UID: 34567890'), trailing: Text('Pending', style: TextStyle(color: Colors.orange))),
          ListTile(leading: CircleAvatar(child: Text('A')), title: Text('AkashFF123'), subtitle: Text('UID: 45678901'), trailing: Text('Banned', style: TextStyle(color: Colors.red))),
        ],
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
      appBar: AppBar(title: const Text('Payment Management'), backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: Icon(Icons.check_circle, color: Colors.green), title: Text('Tournament Entry'), subtitle: Text('12 Oct 2026 • RakeshFF'), trailing: Text('₹50')),
          ListTile(leading: Icon(Icons.check_circle, color: Colors.green), title: Text('Prize Distribution'), subtitle: Text('11 Oct 2026 • Nitesh_07'), trailing: Text('₹1,000')),
          ListTile(leading: Icon(Icons.cancel, color: Colors.red), title: Text('Withdrawal Request'), subtitle: Text('10 Oct 2026 • LegendBoy'), trailing: Text('₹500')),
        ],
      ),
    );
  }
}

// ================= QR UPLOAD PAGE =================
class QrUploadPage extends StatefulWidget {
  const QrUploadPage({super.key});
  @override
  State<QrUploadPage> createState() => _QrUploadPageState();
}

class _QrUploadPageState extends State<QrUploadPage> {
  File? _qrImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickQr() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _qrImage = File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Upload'), backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Container(
            height: 250, width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.amber)),
            child: _qrImage == null ? const Center(child: Text('No QR uploaded yet', style: TextStyle(color: Colors.grey))) : Image.file(_qrImage!, fit: BoxFit.contain),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _pickQr,
            icon: const Icon(Icons.upload),
            label: const Text('UPLOAD QR CODE'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 50)),
          ),
          const SizedBox(height: 12),
          const Text('This QR will be shown to players in the Player App', style: TextStyle(color: Colors.grey, fontSize: 12), textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

// ================= ROOM PAGE =================
class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room ID & Password'), backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(decoration: const InputDecoration(labelText: 'R
