import 'package:flutter/material.dart';

void main() => runApp(TakeMeApp());

class TakeMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TakeMe',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0A0F),
        primaryColor: Color(0xFF8B5CF6),
      ),
      home: OTPPage(),
    );
  }
}

class OTPPage extends StatefulWidget {
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  bool checked = true;
  final phoneCtrl = TextEditingController(text: "256 744742381");
  final otpCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Color(0xFF8B5CF6).withOpacity(0.4), blurRadius: 20)],
                ),
                child: Icon(Icons.verified_user, size: 42, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text("TakeMe", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1)),
              SizedBox(height: 6),
              Text("Real People Only", style: TextStyle(fontSize: 18, color: Color(0xFF8B5CF6), fontWeight: FontWeight.w600)),
              SizedBox(height: 6),
              Text("18+ • OTP Verified • No Bots • Uganda", style: TextStyle(color: Colors.white54, fontSize: 13)),
              SizedBox(height: 32),
              _inputField(icon: Icons.phone, hint: "Airtel/MTN Number 256...", controller: phoneCtrl, keyboard: TextInputType.phone),
              SizedBox(height: 16),
              _inputField(icon: Icons.lock, hint: "Enter 6-digit OTP (use 123456 for test)", controller: otpCtrl, keyboard: TextInputType.number),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(value: checked, onChanged: (v)=>setState(()=>checked=v!), activeColor: Color(0xFF8B5CF6)),
                  Expanded(child: Text("I confirm I am 18+ and I am a real person (selfie required)", style: TextStyle(fontSize: 13, color: Colors.white70))),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity, height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8B5CF6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    if(otpCtrl.text.length >= 4){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter OTP: 123456 for test")));
                    }
                  },
                  child: Text("Verify & Continue", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 12),
              Text("Why OTP? To block bots like Oumi. Only real Ugandans with real SIM can join.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 11)),
              SizedBox(height: 24),
              Text("Payments to: 256 744742381 • Airtel Money", style: TextStyle(color: Colors.white24, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({required IconData icon, required String hint, required TextEditingController controller, required TextInputType keyboard}) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFF8B5CF6)),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
        filled: true,
        fillColor: Color(0xFF1A1A23),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Color(0xFF8B5CF6).withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white10)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Color(0xFF8B5CF6))),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final rooms = [
    {"name":"Kampala Night Vibes 🌙","users":127,"live":true},
    {"name":"Gulu Real Connect","users":89,"live":true},
    {"name":"Mbarara Dating 18+","users":54,"live":false},
    {"name":"Kawanda Singles","users":32,"live":true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0A0F),
        title: Text("TakeMe • Real Rooms"),
        actions: [
          IconButton(icon: Icon(Icons.report, color: Colors.redAccent), onPressed: (){
            showDialog(context: context, builder: (_)=>AlertDialog(title: Text("Report User"), content: Text("Report fake/bot/abuse? We ban in 24h. Email: report@takeme.ug"), actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text("OK"))]));
          }),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)]), borderRadius: BorderRadius.circular(16)),
            child: Row(children: [
              Icon(Icons.workspace_premium, color: Colors.white),
              SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Go Premium - UGX 10k/week", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Unlock voice chat, private DMs, see who liked you", style: TextStyle(fontSize: 12)),
              ])),
              ElevatedButton(onPressed: (){ _showPaywall(context); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Color(0xFF8B5CF6)), child: Text("Pay")),
            ]),
          ),
          SizedBox(height: 20),
          Text("🔥 Live Party Rooms (Voice)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ...rooms.map((r)=>Card(
            color: Color(0xFF1A1A23),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Stack(children: [CircleAvatar(backgroundColor: Color(0xFF8B5CF6), child: Icon(Icons.mic, color: Colors.white)), if(r["live"] as bool) Positioned(right:0,bottom:0,child: Container(width:12,height:12,decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.black, width:2))))]),
              title: Text(r["name"] as String, style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text("${r["users"]} real users online • OTP verified"),
              trailing: ElevatedButton(onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Joining ${r["name"]} - Voice chat coming soon (Agora)"))); }, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8B5CF6)), child: Text("Join")),
            ),
          )).toList(),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Color(0xFF1A1A23), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("✅ Why TakeMe > Oumi?", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8B5CF6))),
              SizedBox(height:8),
              Text("• OTP SIM verified - no bots\n• 18+ only with selfie check\n• Report button = ban in 24h\n• Ugandan payments: Airtel 256744742381\n• Real people in Kawanda, Kampala, Gulu", style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5)),
            ]),
          ),
        ],
      ),
    );
  }

  void _showPaywall(BuildContext context){
    showModalBottomSheet(context: context, backgroundColor: Color(0xFF1A1A23), shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (_)=>Padding(
      padding: EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("Upgrade to Premium", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Text("Send UGX 10,000 to:", style: TextStyle(color: Colors.white70)),
        SizedBox(height: 8),
        SelectableText("256744742381", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF8B5CF6), letterSpacing: 2)),
        Text("Airtel Money - Klein Jai", style: TextStyle(color: Colors.white54)),
        SizedBox(height: 16),
        Text("After payment, WhatsApp receipt to 0744742381 to activate premium in 10 mins.", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.white70)),
        SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=>Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8B5CF6), padding: EdgeInsets.symmetric(vertical: 14)), child: Text("I Have Paid - Activate"))),
      ]),
    ));
  }
}
