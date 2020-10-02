import 'package:flutter/foundation.dart';

class Character {
  final String id;
  final String name;
  final String description;
  final String thumbnail;

  Character(
      {@required this.id,
      @required this.name,
      this.description,
      this.thumbnail});

  factory Character.fromJson(Map<String, dynamic> list) {
    final thumbnail = list['thumbnail'];
    return Character(
        id: list['id'].toString(),
        name: list['name'],
        description: list['description'],
        thumbnail: '${thumbnail['path']}.${thumbnail['extension']}');
  }
  @override
  String toString() {
    return ('id: $id name: $name description: $description thumbnail: $thumbnail');
  }

  // for testing purpose
  static List<Character> getInitialList() {
    return [
      Character(
          id: '001',
          name: '3-D Man',
          description: "I don't know him",
          thumbnail:
              'http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg'),
      Character(
          id: '002',
          name: 'A-Bomb (HAS)',
          description:
              "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! "
              "Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. "
              "And when he curls into action, he uses it like a giant bowling ball of destruction! ",
          thumbnail:
              'http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg'),
      Character(
          id: '003',
          name: 'Abomination (Emil Blonsky)',
          description:
              "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.",
          thumbnail:
              'http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04.jpg')
    ];
  }
}
