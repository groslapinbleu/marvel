import 'package:flutter/material.dart';
import 'package:marvel/app/model/character.dart';
import 'package:marvel/app/service/api_service.dart';
import 'package:marvel/app/ui/favorite_characters_page.dart';
import 'package:provider/provider.dart';
import 'character_page.dart';

class MarvelHomePage extends StatefulWidget {
  @override
  MarvelHomePageState createState() => new MarvelHomePageState();
}

class MarvelHomePageState extends State<MarvelHomePage> {
  static const appBarTitle = "Marvel Characters";
  final _characters = <Character>[];
  final _saved = Set<Character>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Icon _searchIcon = Icon(Icons.search);
  var _filteredCharacters = <Character>[];
  String _searchText = "";
  Widget _appBarTitle = Text(appBarTitle);
  final TextEditingController _filter = TextEditingController();
  bool isLoading = false;
  bool searchBarDisplayed = false;

  @override
  void initState() {
    super.initState();
    //_characters.addAll(Character.getInitialList());
    _filter.addListener(() {
      debugPrint('addListener callback closure called');
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _filteredCharacters = _characters;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
    _updateData(reset: true);
  }

  Future<void> _updateData({bool reset = false}) async {
    debugPrint('_updateData');
    setState(() {
      isLoading = true;
    });
    final apiService = Provider.of<APIService>(context, listen: false);
    if (reset) _characters.clear();
    _characters.addAll(await apiService.getCharacters(reset: reset));
    _filteredCharacters = _characters;
    setState(() {
      isLoading = false;
    });
  }

  void _pushSaveToFavorite() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => FavoriteCharactersPage(savedCharacters: _saved),
      ),
    );
  }

  Widget _listCharacters() {
    if (_searchText.isNotEmpty) {
      var tempList = <Character>[];
      for (int i = 0; i < _filteredCharacters.length; i++) {
        if (_filteredCharacters[i]
            .name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(_filteredCharacters[i]);
        }
      }
      _filteredCharacters = tempList;
    }
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              height: 0.5,
            ),
        itemCount: _filteredCharacters.length,
        itemBuilder: (context, index) => _buildRow(_filteredCharacters[index]));
  }

  Widget _buildRow(Character character) {
    debugPrint('_buildRow');
    final alreadySaved = _saved.contains(character);

    return ListTile(
      title: Text(
        character.name,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onLongPress: () {
        _toggleSave(alreadySaved, character);
      },
      onTap: () => CharacterPage.create(context: context, character: character),
    );
  }

  void _toggleSave(bool alreadySaved, Character character) {
    debugPrint('_toggleSave');
    setState(() {
      if (alreadySaved) {
        _saved.remove(character);
        debugPrint('removing character');
      } else {
        _saved.add(character);
        debugPrint('adding character');
      }
    });
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        searchBarDisplayed = true;
        _searchIcon = Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(hintText: 'Search...'),
        );
      } else {
        searchBarDisplayed = false;
        _searchIcon = Icon(Icons.search);
        _appBarTitle = Text(appBarTitle);
        _filteredCharacters = _characters;
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        centerTitle: true,
        leading: IconButton(icon: _searchIcon, onPressed: _searchPressed),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => _updateData(reset: true)),
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaveToFavorite),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading &&
                    !searchBarDisplayed &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  _updateData();
                  // start loading data
                }
                return true;
              },
              child: _listCharacters(),
            ),
          ),
          if (isLoading)
            Container(
              height: 50.0,
              color: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
