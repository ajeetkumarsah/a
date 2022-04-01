import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/ui/widgetHelper/tab_loader.dart';

class DealSearchableDropdown extends StatefulWidget {
  final TextEditingController searchBarController;
  final Function(String) onSearchTextChanged;
  final Function onSelected;
  final String searchBarTitle;
  final List<SearchResult> selected;
  final List<SearchResult> all;
  final bool searching;

  const DealSearchableDropdown({
    required Key key,
    required this.searchBarTitle,
    required this.searchBarController,
    required this.onSearchTextChanged,
    required this.onSelected,
    required this.selected,
    required this.searching,
    required this.all,
  }) : super(key: key);

  @override
  _DealSearchableDropdownState createState() => _DealSearchableDropdownState();
}

class _DealSearchableDropdownState extends State<DealSearchableDropdown> {
  bool isSearching() => widget.searchBarController.text.isNotEmpty;

  @override
  void initState() {
    widget.searchBarController
        .addListener(() => setState(() => widget.searchBarController.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4)),
            child: _buildSearchBar()),
        if (isSearching())
          Container(
              height: MediaQuery.of(context).size.height / 8,
              alignment: Alignment.topCenter,
              child: _buildResultsList()),
      ],
    );
  }

  Widget _buildSearchBar() {
    return widget.selected.isEmpty
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextField(
                  cursorWidth: 3.0,
                  controller: widget.searchBarController,
                  keyboardType: TextInputType.text,
                  onChanged: widget.onSearchTextChanged,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      hintText: widget.searchBarTitle,
                      hintStyle: textHelper.hintText,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ))),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              if (widget.searchBarController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                      onTap: () => widget.searchBarController.clear(),
                      child:
                          Icon(Icons.close, color: Colors.grey[500], size: 25)),
                )
            ],
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width, child: _buildFieldTags());
  }

  Widget _buildResultsList() {
    return widget.searching
        ? TabLoader()
        : widget.all.isEmpty
            ? Container(
                child: Center(child: Text('No deal found')),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: widget.all.length,
                itemBuilder: (context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: const Border(
                            bottom:
                                BorderSide(color: Colors.grey, width: 0.2))),
                    child: ListTile(
                      onTap: () async {
                        widget.selected.add(widget.all.elementAt(index));
                        setState(() {});
                        await widget.onSelected();
                        setState(() => widget.searchBarController.clear());
                      },
                      title: Text(widget.all.elementAt(index).title,
                          style: textHelper.defaultText),
                    ),
                  );
                },
              );
  }

  Widget _buildFieldTags() {
    return Row(
      children: [
        Expanded(
            child: Text(widget.selected[0].title,
                style: textHelper.defaultText,
                overflow: TextOverflow.ellipsis,
                softWrap: true)),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            child: const Icon(Icons.close, size: 20, color: black),
            onTap: () {
              setState(() {
                widget.selected.clear();
              });
            },
          ),
        )
      ],
    );
  }
}
