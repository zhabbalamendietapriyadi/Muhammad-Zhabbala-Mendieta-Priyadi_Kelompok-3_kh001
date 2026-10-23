import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

@override
State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = const[
    HomeContent(),
    // Content2(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zhabbala App"),
      ),
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem
            (icon: Icon(Icons.home),
            label:'Home',
          ),
          BottomNavigationBarItem
            (icon: Icon(Icons.settings),
            label: 'settings'
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
          "Selamat Datang",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w900,
            color: Colors.green,
          ),
          ),
          Container(
            width: 200,
            height: 30,
            color: Colors.blue[200],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          Container(
            width: 400,
            height: 20,
            color: Colors.blue[200],
          ),
          Row(
            children: [
             Expanded(child: Container(
               height: 50,
               decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
             ),
             ),
              const SizedBox(width: 12),
              Expanded(child: Container(
                height: 50,
                color: Colors.redAccent,
              )),
            ],
          ),
        ],
      ),
    );
  }
}