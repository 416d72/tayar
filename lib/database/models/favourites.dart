class Favourite {
  String documentID;
  String title;
  String image;

  Favourite(this.documentID, this.title, this.image);

  Favourite.fromMap(Map map) {
    documentID = map[documentID];
    title = map[title];
    image = map[image];
  }
}
