class BookData {
  static final List<Map<String, dynamic>> books = [
    {
      'imageUrl': 'assets/books/1book.jpg',
      'title': 'Space Forces',
      'description':
          'This is an amazing book, This book winner of the Nobel Prize for Physics',
      'author': 'Author Name here',
      'availableQty': 10,
      'issueDate': 'Jan 20 2024',
      'issueTime': '10:30 AM',
      'returnDate': 'Jan 20 2024',
      'returnTime': '10:30 AM',
      'downloadLink': 'https://web.pdx.edu/~pmoeck/books/Tipler_Llewellyn.pdf',
    },
    {
      'imageUrl': 'assets/books/2book.jpg',
      'title': 'Chemistry Wonders',
      'description':
          'Explore the wonders of chemistry with this insightful book',
      'author': 'Chemist Extraordinaire',
      'availableQty': 5,
      'issueDate': 'Jan 20 2024',
      'issueTime': '10:30 AM',
      'returnDate': 'Jan 20 2024',
      'returnTime': '10:30 AM',
      'downloadLink': 'https://web.pdx.edu/~pmoeck/books/Tipler_Llewellyn.pdf',
    },
    {
      'imageUrl': 'assets/books/2book.jpg',
      'title': 'Chemistry Wonders',
      'description':
          'Explore the wonders of chemistry with this insightful book',
      'author': 'Chemist Extraordinaire',
      'availableQty': 5,
      'issueDate': 'Jan 20 2024',
      'issueTime': '10:30 AM',
      'returnDate': 'Jan 20 2024',
      'returnTime': '10:30 AM',
      'downloadLink': 'https://web.pdx.edu/~pmoeck/books/Tipler_Llewellyn.pdf',
    },
    {
      'imageUrl': 'assets/books/2book.jpg',
      'title': 'Chemistry Wonders',
      'description':
          'Explore the wonders of chemistry with this insightful book',
      'author': 'Chemist Extraordinaire',
      'availableQty': 5,
      'issueDate': 'Jan 20 2024',
      'issueTime': '10:30 AM',
      'returnDate': 'Jan 20 2024',
      'returnTime': '10:30 AM',
      'downloadLink': 'https://web.pdx.edu/~pmoeck/books/Tipler_Llewellyn.pdf',
    },

    // Add more books here...
  ];

  /// Book data Model --->>

  final List<BookItem> response;
  final String message;
  final String status;

  BookData({
    required this.response,
    required this.message,
    required this.status,
  });

  factory BookData.fromJson(Map<String, dynamic> json) {
    List<dynamic> responseList = json['response'] ?? [];
    List<BookItem> response =
        responseList.map((item) => BookItem.fromJson(item)).toList();

    return BookData(
      response: response,
      message: json['message'] ?? "",
      status: json['status'] ?? "",
    );
  }
}

class BookItem {
  final int sNo;
  final String titleId;
  final String bookTitle;
  final String author;
  final String coverImage;
  final String availableQty;
  final String lockStatus;

  BookItem({
    required this.sNo,
    required this.titleId,
    required this.bookTitle,
    required this.author,
    required this.coverImage,
    required this.availableQty,
    required this.lockStatus,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      sNo: json['s.no'] ?? 0,
      titleId: json['title_id'] ?? "",
      bookTitle: json['book_title'] ?? "",
      author: json['author'] ?? "",
      coverImage: json['covor_image'] ?? "",
      availableQty: json['available_qty'] ?? "",
      lockStatus: json['lock_status'] ?? "",
    );
  }


}
