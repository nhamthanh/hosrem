import 'dart:async';

import 'package:flutter/material.dart';

import 'edit_text_field.dart';

/// Search text field.
class SearchTextField extends StatefulWidget {
  const SearchTextField({Key key, this.executeSearch}) : super(key: key);

  final Function executeSearch;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _searchController = TextEditingController();

  Timer _debounce;

  @override
  Widget build(BuildContext context) {
    return EditTextField(
      hasLabel: false,
//      prefixIcon: const SvgIcon('assets/images/search.svg', size: 17.5),
      prefixIcon: Icon(Icons.search),
      title: 'Search',
      hint: 'Search',
      onTextChanged: _onSearchChanged,
      controller: _searchController,
    );
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce.cancel();
    }

    _debounce = Timer(Duration(milliseconds: 300), () {
      widget.executeSearch(_searchController.text);
    });
  }
}
