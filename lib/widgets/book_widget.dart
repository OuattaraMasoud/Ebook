import 'package:flutter/material.dart';
import 'package:tuto/models/book_model.dart';

class BookWidget extends StatelessWidget {
  final double mainContainerWidth;
  final double positionedContainerWidth;
  final double mainContainerHeight;
  final double positionedContainerHeight;
  final BookModel book;
  const BookWidget(
      {super.key,
      required this.book,
      required this.mainContainerWidth,
      required this.mainContainerHeight,
      required this.positionedContainerWidth,
      required this.positionedContainerHeight});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          height: mainContainerHeight,
          width: mainContainerWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(book.coverImage), fit: BoxFit.cover)),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              height: positionedContainerHeight,
              width: positionedContainerWidth,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Text(
                textAlign: TextAlign.center,
                book.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ))
      ],
    );
  }
}
