class WorldPage extends StatefulWidget {
  @override
  _WorldPageState createState()=>_WorldPageState();
}
class _WorldPageState extends State<WorldPage> {
  String selected="USA";
  final regions=["Uganda","Kenya","USA","UK","Canada","Nigeria","South Africa","UAE","India"];
  Map<String, List<String>> rooms={
    "Uganda":["Kampala Night Vibes 🌙 127","Kawanda Singles ❤️ 32","Gulu Real 89"],
    "Kenya":["Nairobi Night 🇰🇪 203","Mombasa Beach 112","Kisumu Singles 67"],
    "USA":["NYC Real Dating 🗽 543","LA Party Rooms 421","Texas Singles 298","Miami Vibes 156"],
    "UK":["London Verified 🇬🇧 334","Manchester Real 156","Birmingham Connect 98"],
    "Canada":["Toronto Real 🇨🇦 198","Vancouver Vibes 134","Montreal Night 87"],
    "Nigeria":["Lagos Party 🇳🇬 412","Abuja Real 203"],
    "South Africa":["Jozi Night 🇿🇦 234","Cape Town Real 189"],
    "UAE":["Dubai Night 🇦🇪 298","Abu Dhabi Connect 134"],
    "India":["Mumbai Real 🇮🇳 456","Delhi Night 321"],
  };
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(backgroundColor:Color(0xFF0A0A0F),title:Text("World • TakeMe 🌍")),
      body:Column(children:[
        SizedBox(height:10),
        SingleChildScrollView(scrollDirection:Axis.horizontal,padding:EdgeInsets.symmetric(horizontal:12),child:Row(children:regions.map((r)=>Padding(padding:EdgeInsets.only(right:8),child:ChoiceChip(label:Text(r),selected:selected==r,selectedColor:Color(0xFF8B5CF6),onSelected:(v)=>setState(()=>selected=r)))).toList())),
        SizedBox(height:12),
        Padding(padding:EdgeInsets.all(16),child:Align(alignment:Alignment.centerLeft,child:Text("🔥 $selected Party Rooms • OTP Verified",style:TextStyle(fontSize:16,fontWeight:FontWeight.bold)))),
        Expanded(child:ListView(padding:EdgeInsets.symmetric(horizontal:16),children:rooms[selected]!.map((room)=>Card(color:Color(0xFF1A1A23),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),child:ListTile(leading:CircleAvatar(backgroundColor:Color(0xFF8B5CF6),child:Icon(Icons.mic,color:Colors.white,size:18)),title:Text(room.split(" ")[0],style:TextStyle(fontWeight:FontWeight.w600,fontSize:14)),subtitle:Text("${room.split(" ")[1]} verified • No bots"),trailing:ElevatedButton(onPressed:(){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Joined ${room.split(" ")[0]} in $selected! 🎉")));},style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF8B5CF6),minimumSize:Size(60,32)),child:Text("Join",style:TextStyle(fontSize:12)))))).toList())),
      ]),
    );
  }
}
