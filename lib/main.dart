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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              title: Text(
                "Flutter Ebook App",
                style: TextStyle(fontSize: 25),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250,
                width: 150,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        height: 250,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/lapeste.jpeg"))),
                      );
                    }),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'Catégories',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 50,
                            width: 125,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Chip(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.blue,
                                label: const Text(
                                  "Short stories",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child:
                        Text('Recently added', style: TextStyle(fontSize: 20)),
                  ),
                  Column(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Container(
                              height: 150,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/vieuxnegre.jpg"))),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'The Double',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Fyodor Mikhailovich Dostoyevsky',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Hello bonjour les ami.",
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
