import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuto/models/models.dart';
import 'package:tuto/pages/pages.dart';
import 'package:tuto/widgets/book_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BookModel> _books = [];
  List<String> _categories = [];
  final Dio _dio = Dio();

  @override
  void initState() {
    _fetchFiveBooks();
    super.initState();
  }

  Future<void> _fetchFiveBooks() async {
    try {
      Response response =
          await _dio.get('https://freetestapi.com/api/v1/books?limit=5');
      if (response.statusCode == 200) {
        setState(() {
          _books = List<BookModel>.from(response.data
              .map((el) => BookModel(
                  id: el['id'],
                  author: el['author'],
                  coverImage: el['cover_image'],
                  description: el['description'],
                  genre: el['genre'],
                  publicationYear: el['publication_year'],
                  title: el['title']))
              .toList());
          _categories =
              List<String>.from(response.data.map((el) => el['genre'][0]));
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching books: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              title: Text(
                "Flutter Ebook App",
                style: TextStyle(fontSize: 25),
              ),
              actions: [
                IconButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage())),
                    icon: Icon(Icons.logout))
              ],
            ),
            SliverToBoxAdapter(
              child: _books.isNotEmpty
                  ? SizedBox(
                      height: 250,
                      width: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _books.length,
                          itemBuilder: (context, index) {
                            return BookWidget(
                                book: _books[index],
                                mainContainerWidth: 150,
                                mainContainerHeight: 250,
                                positionedContainerWidth: 150,
                                positionedContainerHeight: 75);
                          }),
                    )
                  : const SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(child: CircularProgressIndicator())),
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
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 50,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Chip(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.blue,
                                label: Text(
                                  _categories[index],
                                  style: const TextStyle(color: Colors.white),
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
                    children: List.generate(_books.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            BookWidget(
                                book: _books[index],
                                mainContainerWidth: 100,
                                mainContainerHeight: 150,
                                positionedContainerWidth: 100,
                                positionedContainerHeight: 50),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _books[index].title,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    _books[index].author,
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: AutoSizeText(
                                      _books[index].description,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
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
