class Section {
  final String id;
  final String parent;
  final String title;
  final String imageURL;

  const Section({
    this.id,
    this.parent,
    this.title,
    this.imageURL,
  });

  Section.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          parent: data['parent'],
          title: data['title'],
          imageURL: data['image'],
        );
}
