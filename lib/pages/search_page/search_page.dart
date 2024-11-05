import 'package:babysitterapp/models/search_result.dart';
import 'package:flutter/material.dart';
import 'package:babysitterapp/pages/search_page/widgets/index.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchHistory = [];
  final List<SearchResult> _allBabysitters = SearchResult.fetchBabysitters();
  List<SearchResult> _searchResults = [];

  bool _showAutocomplete = false;
  bool _showResults = false;
  bool _noResultsFound = false;

  void _onSearchSubmit(String value) {
    setState(() {
      if (value.isNotEmpty) {
        //check if the value is not already in the search history
        if (!_searchHistory.contains(value)) {
          _searchHistory.add(value);
        }
        _showAutocomplete = false;

        _searchResults = _allBabysitters.where((result) =>
        result.name.toLowerCase().contains(value.toLowerCase()) ||
            result.bio.toLowerCase().contains(value.toLowerCase()) ||
            result.skills.any((skill) => skill.toLowerCase().contains(value.toLowerCase()))
        ).toList();

        _showResults = true;
        _noResultsFound = _searchResults.isEmpty;
      }
    });
  }


  void _onSearchChanged(String value) {
    setState(() {
      if (value.isNotEmpty) {
        _showAutocomplete = true;
        _showResults = false;

        //autocomplete suggestions
        _searchResults = _allBabysitters.where((result) =>
            result.name.toLowerCase().contains(value.toLowerCase())
        ).toList();
      } else {
        _showAutocomplete = false;
      }
    });
  }

  //handle back button press to hide results and autocomplete
  void _onBackPressed() {
    setState(() {
      _showResults = false;
      _showAutocomplete = false;
    });
  }

  //hndle click on an autocomplete suggestion
  void _onLabelClick(SearchResult babysitter) {
    setState(() {
      _searchHistory.add(babysitter.name);
      _showAutocomplete = false;
      _showResults = true;
      _searchResults = [babysitter];
    });
  }

  //reset the search input and show the default list
  void _onReset() {
    setState(() {
      _searchController.clear();
      _searchResults.clear();
      _showResults = false;
      _showAutocomplete = false;
    });
  }

  //handle click on search history item
  void _onHistoryItemClick(String history) {
    setState(() {
      _searchController.text = history;
      _onSearchSubmit(history);
    });
  }

  //handle click to clear search history item
  void _clearSearchHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBarWidget(
            searchController: _searchController,
            onSearchChanged: _onSearchChanged,
            onSearchSubmit: () => _onSearchSubmit(_searchController.text),
            onBackPressed: _onBackPressed,
            onReset: _onReset,
          ),
          Expanded(
            child: _showResults
                ? SearchResultsWidget(
              searchResults: _searchResults,
              onLabelClick: _onLabelClick,
              noResultsFound: _noResultsFound,
            )
                : _showAutocomplete
                ? AutocompleteWidget(
              searchResults: _searchResults,
              onLabelClick: _onLabelClick,
            )
                : DefaultListWidget(
              searchHistory: _searchHistory,
              onHistoryItemClick: _onHistoryItemClick,
              onClearHistory: _clearSearchHistory,
            ),
          ),
        ],
      ),
    );
  }
}
