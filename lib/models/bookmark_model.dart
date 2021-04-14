class BookmarkModel {

  int bookmarkSurahIndex;
  String bookmarkedSurahName;
  int bookmarkedSurahAyat;

  BookmarkModel({
    this.bookmarkSurahIndex,
    this.bookmarkedSurahName,
    this.bookmarkedSurahAyat,
  });

  BookmarkModel.fromMap(Map data) {
    this.bookmarkSurahIndex = data['surahName'];
  }
}