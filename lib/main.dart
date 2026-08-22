import 'package:flutter/material.dart';

void main() => runApp(TakeMeApp());

class TakeMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TakeMe',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<String> likes = [];

  final profiles = [
    {"name": "Sofia, 24", "city": "Medellín", "img": "💃"},
    {"name": "Valentina, 22", "city": "Bogotá", "img": "🌸"},
    {"name": "Isabella, 26", "city": "Cali", "img": "✨"},
    {"name": "Mariana, 25", "city": "Medellín", "img": "💖"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TakeMe ❤️', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: currentIndex >= profiles.length
       ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('No more profiles today! 😍', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('You liked ${likes.length} people'),
            ElevatedButton(onPressed: (){setState((){currentIndex=0; likes=[];});}, child: Text('Start Again'))
          ]))
        : Column(
          children: [
            Expanded(
              child: Card(
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 10,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [Colors.pink.shade200, Colors.purple.shade200], begin: Alignment.topLeft, end: Alignment.bottomRight)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(profiles[currentIndex]['img']!, style: TextStyle(fontSize: 100)),
                      SizedBox(height: 20),
                      Text(profiles[currentIndex]['name']!, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 8),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.location_on, color: Colors.white),
                        Text(profiles[currentIndex]['city']!, style: TextStyle(fontSize: 18, color: Colors.white)),
                      ]),
                      SizedBox(height: 30),
                      Text('Tap ❤️ to Like, ❌ to Pass', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: 'nope',
                    backgroundColor: Colors.grey,
                    onPressed: () => setState(() => currentIndex++),
                    child: Icon(Icons.close, size: 30),
                  ),
                  FloatingActionButton(
                    heroTag: 'like',
                    backgroundColor: Colors.pink,
                    onPressed: () {
                      setState(() {
                        likes.add(profiles[currentIndex]['name']!);
                        currentIndex++;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Liked! ❤️'), backgroundColor: Colors.pink));
                    },
                    child: Icon(Icons.favorite, size: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
