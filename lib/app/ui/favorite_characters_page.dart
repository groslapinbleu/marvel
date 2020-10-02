import 'package:flutter/material.dart';
import 'package:marvel/app/model/character.dart';
import 'package:marvel/app/ui/character_page.dart';

class FavoriteCharactersPage extends StatelessWidget {
  const FavoriteCharactersPage({Key key, this.savedCharacters}) : super(key: key);
  final Set<Character> savedCharacters;

  final _biggerFont = const TextStyle(fontSize: 18.0);


  @override
  Widget build(BuildContext context) {
      final tiles = savedCharacters.map(
            (Character character) {
          return ListTile(
            onTap: () => CharacterPage.create(context: context, character: character),
            title: Text(
              character.name,
              style: _biggerFont,
            ),
          );
        },
      );
      final divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Favorite Characters'),
          centerTitle: true,
        ),
        body: ListView(children: divided),
      );
    }
}
