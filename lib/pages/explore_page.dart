import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:tuto/models/book_model.dart';
import 'package:tuto/pages/pages.dart';
import 'package:tuto/widgets/widgets.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<BookModel> _books = [];
  final Dio _dio = Dio();

  Future<void> _fetchAllBooks() async {
    try {
      Response response =
          await _dio.get('https://freetestapi.com/api/v1/books');
      if (response.statusCode == 200) {
        setState(() {
          _books = List<BookModel>.from(response.data
              .map((el) => BookModel(
                  id: el['id'],
                  author: el['author'],
                  coverImage: el['cover_image'],
                  description: el['description'],
                  genre: el['genre'][0],
                  publicationYear: el['publication_year'],
                  title: el['title']))
              .toList());
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching books: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(
              'Explore',
              style: TextStyle(fontSize: 25),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: GroupedListView<BookModel, String>(
                order: GroupedListOrder.DESC,
                padding: const EdgeInsets.only(
                    bottom: kBottomNavigationBarHeight + 150),
                elements: _books,
                groupBy: (BookModel bookModel) => bookModel.genre,
                groupSeparatorBuilder: (String groupBy) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        groupBy,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoriesBooksPage(
                                      genre: groupBy,
                                      books: _books
                                          .where((b) => b.genre == groupBy)
                                          .toList(),
                                    ))),
                        child: const Text(
                          'Voir tout',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
                groupComparator: (value1, value2) => value2.compareTo(value1),
                itemBuilder: (BuildContext context, BookModel element) {
                  final filteredBooks = _books
                      .where((b) => b.genre == element.genre)
                      .take(5)
                      .toList();
                  return (filteredBooks.isNotEmpty &&
                          filteredBooks.first == element)
                      ? SizedBox(
                          height: 250,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: filteredBooks.length,
                              itemBuilder: (context, index) {
                                return BookWidget(
                                    book: filteredBooks[index],
                                    mainContainerWidth: 150,
                                    mainContainerHeight: 250,
                                    positionedContainerWidth: 150,
                                    positionedContainerHeight: 75);
                              }),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
