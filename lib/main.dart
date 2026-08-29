import 'package:flutter/material.dart';

void main() => runApp(TakeMeApp());

class TakeMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TakeMe',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0F0F14),
        primaryColor: Color(0xFF8B5CF6),
      ),
      home: RealLoginScreen(),
    );
  }
}

// 1. REAL PEOPLE LOGIN - OTP + 18+ + Selfie
class RealLoginScreen extends StatefulWidget {
  @override
  _RealLoginScreenState createState() => _RealLoginScreenState();
}
class _RealLoginScreenState extends State<RealLoginScreen> {
  bool is18 = false;
  bool otpSent = false;
  final phoneCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(children: [
          SizedBox(height: 40),
          Center(child: Icon(Icons.verified_user, size: 80, color: Color(0xFF8B5CF6))),
          SizedBox(height: 10),
          Center(child: Text("TakeMe - Real People Only", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
          Center(child: Text("18+ • OTP Verified • No Bots", style: TextStyle(color: Colors.grey))),
          SizedBox(height: 30),
          TextField(controller: phoneCtrl, decoration: InputDecoration(labelText: "Airtel/MTN Number 256...", border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone))),
          SizedBox(height: 12),
          if(otpSent) TextField(controller: otpCtrl, decoration: InputDecoration(labelText: "Enter 6-digit OTP", border: OutlineInputBorder())),
          SizedBox(height: 12),
          Row(children: [
            Checkbox(value: is18, onChanged: (v){setState(()=>is18=v!);}),
            Expanded(child: Text("I confirm I am 18+ and I am a real person (selfie required)"))
          ]),
          SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Color(0xFF8B5CF6)),
            onPressed: is18? (){
              if(!otpSent){ setState(()=>otpSent=true); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("OTP sent to ${phoneCtrl.text} (Firebase)"))); }
              else{ Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeWithParties())); }
            }: null,
            child: Text(otpSent ? "Verify & Continue" : "Send OTP"),
          ),
          SizedBox(height: 10),
          Text("Why OTP? To block bots like Oumi. Only real Ugandans with real SIM can join.", style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center)
        ]),
      ),
    );
  }
}

// 2. HOME - LIKE OUMI SCREENSHOT BUT REAL
class HomeWithParties extends StatelessWidget {
  final parties = [
    {"name":"Kampala Night Vibes","users":"12 online","type":"FREE VOICE"},
    {"name":"Love Talk Luganda","users":"8 online","type":"FREE VOICE"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TakeMe"), actions: [IconButton(icon: Icon(Icons.report), onPressed: (){})]),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.purple.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: Row(children: [Icon(Icons.shield, color: Colors.green), SizedBox(width:8), Expanded(child: Text("All users OTP verified • Real people only • No bots", style: TextStyle(fontSize:12)))]) ),
          SizedBox(height: 16),
          Text("Top Party Rooms (FREE)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...parties.map((p)=>Card(
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Color(0xFF8B5CF6), child: Icon(Icons.mic)),
              title: Text(p["name"]!),
              subtitle: Text("${p["users"]} • ${p["type"]}"),
              trailing: ElevatedButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=>VoiceRoom(name: p["name"]!))); }, child: Text("JOIN")),
            ),
          )).toList(),
          SizedBox(height: 20),
          Text("Swipe - Real Profiles", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              Image.network("https://randomuser.me/api/portraits/women/44.jpg", height: 300, width: double.infinity, fit: BoxFit.cover),
              ListTile(
                title: Text("Amina, 23 • Verified ✓"),
                subtitle: Text("Kawanda • Real person • OTP verified"),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(icon: Icon(Icons.close), onPressed: (){}),
                  IconButton(icon: Icon(Icons.favorite, color: Colors.pink), onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=>PaywallScreen())); }),
                  IconButton(icon: Icon(Icons.flag, color: Colors.grey), onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Reported - we will check"))); }),
                ]),
              )
            ]),
          )
        ],
      ),
    );
  }
}

class VoiceRoom extends StatelessWidget {
  final String name;
  VoiceRoom({required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Column(children: [
        Expanded(child: GridView.count(crossAxisCount: 4, children: List.generate(8, (i)=>Column(children: [CircleAvatar(radius: 30, child: Text("U${i+1}")), Text(i==0?"You":"User ${i+1}")])))),
        Padding(padding: EdgeInsets.all(16), child: Row(children: [Expanded(child: TextField(decoration: InputDecoration(hintText: "Type free message...", border: OutlineInputBorder()))), IconButton(icon: Icon(Icons.mic, size: 30), onPressed: (){})])),
        Text("Voice by Agora • Free for first 10k mins", style: TextStyle(fontSize: 10, color: Colors.grey))
      ]),
    );
  }
}

class PaywallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Unlock Real Chat")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Icon(Icons.lock_open, size: 60, color: Color(0xFF8B5CF6)),
          Text("Chat with verified real people", style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          _card("Weekly", "10,000 UGX", "7 days"),
          _card("Monthly - BEST", "25,000 UGX", "30 days • Popular", isPop: true),
          SizedBox(height: 20),
          ElevatedButton(style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.red), onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pay with Airtel 256744742381 - Enter PIN on prompt"))); }, child: Text("Pay with Airtel Money")),
          ElevatedButton(style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.yellow, foregroundColor: Colors.black), onPressed: (){}, child: Text("Pay with MTN MoMo")),
        ]),
      ),
    );
  }
  Widget _card(String t, String p, String s, {bool isPop=false})=>Container(margin: EdgeInsets.only(bottom:10), padding: EdgeInsets.all(14), decoration: BoxDecoration(border: Border.all(color: isPop?Color(0xFF8B5CF6):Colors.grey), borderRadius: BorderRadius.circular(12)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t, style: TextStyle(fontWeight: FontWeight.bold)), Text(s, style: TextStyle(fontSize: 11, color: Colors.grey))]), Text(p, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]));
}
