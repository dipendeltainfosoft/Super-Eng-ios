import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../Configuration/ColorConfig.dart';
import '../Others/CustomTexts.dart';

class SearchDropdown extends StatefulWidget {
  final String title;
  final String hint;
  final String suggestionText;
  final bool isHide;

  final TextEditingController controller;
  final Function(dynamic) onSelected;
  final FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback;

  const SearchDropdown(
      {Key key,
      @required this.title,
      @required this.hint,
      @required this.controller,
      @required this.suggestionsCallback,
      @required this.onSelected,
      @required this.suggestionText,
      this.isHide})
      : super(key: key);
  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  SuggestionsBoxController _suggestionsBoxController =
      SuggestionsBoxController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        title: CustomText(
          data: widget.title,
          fColor: Colors.black,
          fWeight: FontWeight.bold,
        ),
        subtitle: Container(
          child: TypeAheadField(
            errorBuilder: (context, error) {
              return Center(child: Text("No Data Found"));
            },
            hideSuggestionsOnKeyboardHide: true ?? widget.isHide,
            suggestionsBoxController: this._suggestionsBoxController,
            onSuggestionSelected: widget.onSelected,
            textFieldConfiguration: TextFieldConfiguration(
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.controller.clear();
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
                hintText: widget.hint,
                fillColor: ColorConfig.primaryLightAppColor,
                filled: true,
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.white, width: 0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.white, width: 0),
                ),
              ),
            ),
            suggestionsCallback: widget.suggestionsCallback,
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: Icon(Icons.search),
                title: CustomText(
                    fColor: Colors.black,
                    fWeight: FontWeight.bold,
                    data: suggestion[widget.suggestionText]
                        .toString()
                        .toUpperCase()),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SearchDropdownWOTitle extends StatefulWidget {
  final String title;
  final String hint;
  final String suggestionText;
  final bool isHide;

  final TextEditingController controller;
  final Function(dynamic) onSelected;
  final FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback;

  const SearchDropdownWOTitle(
      {Key key,
      @required this.title,
      @required this.hint,
      @required this.controller,
      @required this.suggestionsCallback,
      @required this.onSelected,
      @required this.suggestionText,
      this.isHide})
      : super(key: key);
  @override
  State<SearchDropdownWOTitle> createState() => _SearchDropdownWOTitleState();
}

class _SearchDropdownWOTitleState extends State<SearchDropdownWOTitle> {
  SuggestionsBoxController _suggestionsBoxController =
      SuggestionsBoxController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      child: TypeAheadField(
        errorBuilder: (context, error) {
          return Center(child: Text("No Data Found"));
        },
        hideSuggestionsOnKeyboardHide: true ?? widget.isHide,
        suggestionsBoxController: this._suggestionsBoxController,
        onSuggestionSelected: widget.onSelected,
        textFieldConfiguration: TextFieldConfiguration(
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    widget.controller.clear();
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                )),
            hintText: widget.hint,
            fillColor: ColorConfig.primaryLightAppColor,
            filled: true,
            hintStyle: TextStyle(
              color: Colors.black,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white, width: 0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white, width: 0),
            ),
          ),
        ),
        suggestionsCallback: widget.suggestionsCallback,
        itemBuilder: (context, suggestion) {
          return ListTile(
            leading: Icon(Icons.search),
            title: CustomText(
                fColor: Colors.black,
                fWeight: FontWeight.bold,
                data:
                    suggestion[widget.suggestionText].toString().toUpperCase()),
          );
        },
      ),
    ));
  }
}
