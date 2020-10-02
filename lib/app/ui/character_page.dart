import 'package:flutter/material.dart';
import 'package:marvel/app/model/character.dart';
import 'package:marvel/common_widgets/image_block.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({Key key, @required this.character}) : super(key: key);
  final Character character;

  /// pops a CharacterPage from anywhere
  static create({BuildContext context, Character character}) {
    debugPrint('CharacterPage create');
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => CharacterPage(
        character: character,
      ),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
            child: Column(
          children: [
            SizedBox(height: 20),
            ImageBlock(photoUrl: character.thumbnail, radius: 80),
            SizedBox(height: 20),
            Center(
                child: Text(
              character.description.isEmpty
                  ? 'no description'
                  : character.description,
              style: TextStyle(
                fontSize: 20,
              ),
            )),
          ],
        )),
      )),
    );
  }
}
