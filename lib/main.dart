import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(TakeMeApp());

class TakeMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner:false,title:'TakeMe',theme:ThemeData.dark().copyWith(scaffoldBackgroundColor:Color(0xFF0A0A0F),primaryColor:Color(0xFF8B5CF6)),home:OTPPage());
  }
}

class OTPPage extends StatefulWidget {
  @override
  _OTPPageState createState()=>_OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String selectedCountry="Uganda";
  final countries=["Uganda","Kenya","Nigeria","USA","UK","Canada","UAE","India","South Africa","Tanzania"];
  final codes={"Uganda":"+256","Kenya":"+254","Nigeria":"+234","USA":"+1","UK":"+44","Canada":"+1","UAE":"+971","India":"+91","South Africa":"+27","Tanzania":"+255"};
  final phoneCtrl=TextEditingController(text:"744742381");
  final otpCtrl=TextEditingController();
  bool checked=true;
  @override
  Widget build(BuildContext context){
    return Scaffold(backgroundColor:Color(0xFF0A0A0F),body:SafeArea(child:SingleChildScrollView(padding:EdgeInsets.all(24),child:Column(children:[
      SizedBox(height:20),
      Container(width:80,height:80,decoration:BoxDecoration(gradient:LinearGradient(colors:[Color(0xFF8B5CF6),Color(0xFFEC4899)]),borderRadius:BorderRadius.circular(20)),child:Icon(Icons.verified_user,size:42,color:Colors.white)),
      SizedBox(height:12),Text("TakeMe",style:TextStyle(fontSize:36,fontWeight:FontWeight.bold)),Text("Real People Only",style:TextStyle(fontSize:18,color:Color(0xFF8B5CF6),fontWeight:FontWeight.w600)),Text("18+ • OTP Verified • No Bots • Worldwide",style:TextStyle(color:Colors.white54,fontSize:12)),
      SizedBox(height:20),
      Container(padding:EdgeInsets.symmetric(horizontal:12),decoration:BoxDecoration(color:Color(0xFF1A1A23),borderRadius:BorderRadius.circular(12),border:Border.all(color:Colors.white10)),child:DropdownButton<String>(value:selectedCountry,isExpanded:true,dropdownColor:Color(0xFF1A1A23),underline:SizedBox(),items:countries.map((c)=>DropdownMenuItem(value:c,child:Text("$c (${codes[c]})",style:TextStyle(color:Colors.white)))).toList(),onChanged:(v)=>setState(()=>selectedCountry=v!))),
      SizedBox(height:12),
      TextField(controller:phoneCtrl,keyboardType:TextInputType.phone,style:TextStyle(color:Colors.white),decoration:InputDecoration(prefixIcon:Icon(Icons.phone,color:Color(0xFF8B5CF6)),prefixText:"${codes[selectedCountry]} ",prefixStyle:TextStyle(color:Colors.white,fontWeight:FontWeight.bold),hintText:"Phone number",filled:true,fillColor:Color(0xFF1A1A23),border:OutlineInputBorder(borderRadius:BorderRadius.circular(12),borderSide:BorderSide.none))),
      SizedBox(height:12),
      TextField(controller:otpCtrl,keyboardType:TextInputType.number,style:TextStyle(color:Colors.white),decoration:InputDecoration(prefixIcon:Icon(Icons.lock,color:Color(0xFF8B5CF6)),hintText:"Enter OTP - use 123456",hintStyle:TextStyle(color:Colors.white38,fontSize:13),filled:true,fillColor:Color(0xFF1A1A23),border:OutlineInputBorder(borderRadius:BorderRadius.circular(12),borderSide:BorderSide.none))),
      SizedBox(height:12),
      Row(children:[Checkbox(value:checked,onChanged:(v)=>setState(()=>checked=v!),activeColor:Color(0xFF8B5CF6)),Expanded(child:Text("I am 18+ real - $selectedCountry",style:TextStyle(fontSize:12,color:Colors.white70)))]),
      SizedBox(height:12),
      SizedBox(width:double.infinity,height:56,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF8B5CF6),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))),onPressed:(){if(otpCtrl.text.length>=4)Navigator.push(context,MaterialPageRoute(builder:(_)=>MainNav(region:selectedCountry)));},child:Text("Verify & Continue • $selectedCountry",style:TextStyle(fontSize:15,fontWeight:FontWeight.bold)))),
    ]))));
  }
}

class MainNav extends StatefulWidget {
  final String region;
  MainNav({required this.region});
  @override
  _MainNavState createState()=>_MainNavState();
}

class _MainNavState extends State<MainNav> {
  int idx=0;
  @override
  Widget build(BuildContext context){
    final pages=[HomePage(region:widget.region),WorldPage(),MatchesPage(),ProfilePage(region:widget.region)];
    return Scaffold(body:pages[idx],bottomNavigationBar:BottomNavigationBar(backgroundColor:Color(0xFF0A0A0F),selectedItemColor:Color(0xFF8B5CF6),unselectedItemColor:Colors.white38,type:BottomNavigationBarType.fixed,currentIndex:idx,onTap:(i)=>setState(()=>idx=i),items:[BottomNavigationBarItem(icon:Icon(Icons.home),label:widget.region),BottomNavigationBarItem(icon:Icon(Icons.public),label:"World"),BottomNavigationBarItem(icon:Icon(Icons.favorite),label:"Matches"),BottomNavigationBarItem(icon:Icon(Icons.person),label:"Profile")]));
  }
}

class HomePage extends StatelessWidget {
  final String region;
  HomePage({required this.region});
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar:AppBar(backgroundColor:Color(0xFF0A0A0F),title:Text("TakeMe • $region")),body:ListView(padding:EdgeInsets.all(16),children:[
      Container(padding:EdgeInsets.all(14),decoration:BoxDecoration(gradient:LinearGradient(colors:[Color(0xFF8B5CF6),Color(0xFFEC4899)]),borderRadius:BorderRadius.circular(14)),child:Row(children:[Icon(Icons.verified_user,color:Colors.white),SizedBox(width:10),Expanded(child:Text("Real people in $region • OTP Verified • No Bots",style:TextStyle(fontSize:12,fontWeight:FontWeight.bold)))])),
      SizedBox(height:16),Text("🔥 $region Party Rooms",style:TextStyle(fontSize:17,fontWeight:FontWeight.bold)),SizedBox(height:10),
      Card(color:Color(0xFF1A1A23),child:ListTile(leading:CircleAvatar(backgroundColor:Color(0xFF8B5CF6),child:Icon(Icons.mic)),title:Text("$region Night Vibes 🌙"),subtitle:Text("127 verified • $region"),trailing:ElevatedButton(onPressed:(){},style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF8B5CF6)),child:Text("Join")))),
    ]));
  }
}

class WorldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){return Scaffold(appBar:AppBar(backgroundColor:Color(0xFF0A0A0F),title:Text("World • TakeMe")),body:Center(child:Text("🌍 World Rooms\nKenya, USA, UK, Canada\nComing Soon",textAlign:TextAlign.center,style:TextStyle(color:Colors.white54))));}
}

class MatchesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){return Scaffold(appBar:AppBar(backgroundColor:Color(0xFF0A0A0F),title:Text("Matches")),body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.favorite_border,size:60,color:Color(0xFF8B5CF6)),SizedBox(height:12),Text("No matches yet",style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),Text("Join Party Rooms to meet",style:TextStyle(color:Colors.white54))])));}
}

class ProfilePage extends StatefulWidget {
  final String region;
  ProfilePage({required this.region});
  @override
  _ProfilePageState createState()=>_ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  String name="Klein Jai";
  String bio="Real Ugandan from Kawanda 🇺🇬 • 18+ Verified • Looking for real connections";
  final picker=ImagePicker();
  Future pickImage() async {
    final picked=await picker.pickImage(source:ImageSource.gallery);
    if(picked!=null){setState(()=>_image=File(picked.path));}
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(backgroundColor:Color(0xFF0A0A0F),title:Text("Profile"),actions:[IconButton(icon:Icon(Icons.settings),onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>SettingsPage(region:widget.region))))]),
      body:ListView(padding:EdgeInsets.all(20),children:[
        Center(child:Stack(children:[CircleAvatar(radius:60,backgroundColor:Color(0xFF8B5CF6),backgroundImage:_image!=null?FileImage(_image!):null,child:_image==null?Icon(Icons.person,size:60,color:Colors.white):null),Positioned(bottom:0,right:0,child:InkWell(onTap:pickImage,child:Container(padding:EdgeInsets.all(8),decoration:BoxDecoration(color:Color(0xFFEC4899),shape:BoxShape.circle),child:Icon(Icons.camera_alt,size:18,color:Colors.white))))])),
        SizedBox(height:12),
        Center(child:ElevatedButton.icon(onPressed:pickImage,icon:Icon(Icons.add_a_photo),label:Text("Add / Change Profile Picture"),style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF8B5CF6),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))))),
        SizedBox(height:20),
        Card(color:Color(0xFF1A1A23),child:ListTile(leading:Icon(Icons.person,color:Color(0xFF8B5CF6)),title:Text(name),subtitle:Text("Tap to edit"),onTap:()=>editField("Name",name,(v)=>setState(()=>name=v)))),
        Card(color:Color(0xFF1A1A23),child:ListTile(leading:Icon(Icons.location_on,color:Color(0xFF8B5CF6)),title:Text(widget.region),subtitle:Text("Your region"))),
        Card(color:Color(0xFF1A1A23),child:ListTile(leading:Icon(Icons.info,color:Color(0xFF8B5CF6)),title:Text("Bio"),subtitle:Text(bio),onTap:()=>editField("Bio",bio,(v)=>setState(()=>bio=v)))),
        SizedBox(height:10),
        Container(padding:EdgeInsets.all(14),decoration:BoxDecoration(color:Color(0xFF1A1A23),borderRadius:BorderRadius.circular(12)),child:Row(children:[Icon(Icons.verified,color:Colors.green),SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text("OTP Verified • ${widget.region}",style:TextStyle(fontWeight:FontWeight.bold,fontSize:13)),Text("Real person, real SIM",style:TextStyle(color:Colors.white54,fontSize:11))]))])),
        SizedBox(height:20),
        SizedBox(width:double.infinity,height:48,child:ElevatedButton.icon(icon:Icon(Icons.settings),label:Text("Settings • Privacy • Logout"),style:ElevatedButton.styleFrom(backgroundColor:Colors.white10),onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>SettingsPage(region:widget.region))))),
      ]),
    );
  }
  void editField(String title,String current,Function(String) onSave){
    final ctrl=TextEditingController(text:current);
    showDialog(context:context,builder:(_)=>AlertDialog(backgroundColor:Color(0xFF1A1A23),title:Text("Edit $title"),content:TextField(controller:ctrl,maxLines:title=="Bio"?3:1,style:TextStyle(color:Colors.white),decoration:InputDecoration(filled:true,fillColor:Color(0xFF0A0A0F),border:OutlineInputBorder(borderRadius:BorderRadius.circular(10),borderSide:BorderSide.none))),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:Text("Cancel")),ElevatedButton(onPressed:(){onSave(ctrl.text);Navigator.pop(context);},style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF8B5CF6)),child:Text("Save"))]));
  }
}

class SettingsPage extends StatelessWidget {
  final String region;
  SettingsPage({required this.region});
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar:AppBar(backgroundColor:Color(0xFF0A0A0F),title:Text("Settings")),body:ListView(padding:EdgeInsets.all(16),children:[
      Text("Account",style:TextStyle(color:Color(0xFF8B5CF6),fontWeight:FontWeight.bold)),
      Card(color:Color(0xFF1A1A23),child:ListTile(leading:Icon(Icons.lock),title:Text("Privacy"),subtitle:Text("Control who sees you"))),
      Card(color:Color(0xFF1A1A23),child:ListTile(leading:Icon(Icons.notifications),title:Text("Notifications"),subtitle:Text("On • Party invites"))),
      Card(color:Color(0xFF1A1A23),child:ListTile(leading:Icon(Icons.language),title:Text("Region"),subtitle:Text(region),trailing:Icon(Icons.check,color:Colors.green))),
      SizedBox(height:20),
      Text("Support",style:TextStyle(color:Color(0xFF8B5CF6),fontWeight:FontWeight.bold)),
      Card(color:Color(0xFF1A1A23),child:ListTile(leading:Icon(Icons.report),title:Text("Report Fake"),subtitle:Text("Ban in 24h"))),
      Card(color:Color(0xFF1A1A23),child:ListTile(leading:Icon(Icons.help),title:Text("Help: 0744742381"))),
      SizedBox(height:20),
      SizedBox(width:double.infinity,height:50,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.red.withOpacity(0.8)),onPressed:()=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(_)=>OTPPage()),(r)=>false),child:Text("Log Out"))),
      Center(child:Text("TakeMe v1.0 Global • $region",style:TextStyle(color:Colors.white38,fontSize:11))),
    ]));
  }
}
