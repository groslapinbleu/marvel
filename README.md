# marvel

This app uses the Marvel API (www.marvel.com) in a basic way :
the main page displays a list of Marvel characters, has a search bar to find specific characters,
and allows to add characters to a favorites list (a heart icon appears).
The favorites list is then accessible from a button on the top bar.
When tapping on a character, a detailed page about that character pops-up
When long pressing on a character, it gets added to the favorites list.
Pagination: when scrolling down to the end of the page, more data will be retrieved from the
Marvel API and displayed
(Note: pagination is disabled when the search bar is active).

## Getting Started

To avoid disclosing the Marvel api keys, I'm storing them in lib/app/common/api_key.dart which is not stored in the repository.
To set it up,  rename file api_key.example.dart to api_key.dart and type in your own keys.


