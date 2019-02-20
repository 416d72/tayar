import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tayar/common/sections/sectionCard.dart';

class SectionsPage extends StatefulWidget {
  final String parent;

  const SectionsPage({Key key, @required this.parent}) : super(key: key);

  @override
  _SectionsPageBuilder createState() => _SectionsPageBuilder();
}

class _SectionsPageBuilder extends State<SectionsPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('Sections').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return GridView.count(
          crossAxisCount: 2,
          children: List.generate(snapshot.data.documents.length, (index) {
            var section = snapshot.data.documents[index];
            return SectionCard(
              section: SectionBuilder(
                id: widget.parent,
                parent: null,
                title: section['details'][0].toString(),
                imageURL: section['details'][1].toString(),
              ),
            );
          }),
        );
      },
    );
  }
}
