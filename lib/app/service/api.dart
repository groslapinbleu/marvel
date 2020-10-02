
enum Endpoint {
  characters,
  comics,
  creators,
  events,
  series,
  stories
}

class API {

  static final String host = 'gateway.marvel.com';

  Uri endpointUri(Endpoint endpoint) => Uri(
    scheme: 'https',
    host: host,
    path: _paths[endpoint],
  );

  static Map<Endpoint, String> _paths = {
    Endpoint.characters: '/v1/public/characters',
    Endpoint.comics: '/v1/public/comics',
    Endpoint.creators: '/v1/public/creators',
    Endpoint.events: '/v1/public/events',
    Endpoint.series: '/v1/public/series',
    Endpoint.stories: '/v1/public/stories',
  };
}
