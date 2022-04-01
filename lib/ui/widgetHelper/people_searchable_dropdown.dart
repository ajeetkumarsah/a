import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/ui/widgetHelper/tab_loader.dart';

class PeopleSearchableDropdown extends StatefulWidget {
  final TextEditingController searchBarController;
  final Function(String) onSearchTextChanged;
  final Function(bool) newPerson;
  final Function onSelected;
  final String searchBarTitle;
  final List<SearchPeopleNew> selected;
  final List<SearchPeopleNew> all;
  final bool searching;
  final bool withNew;
  final bool? isRequired;
  final Function()? onClear;

  String? Function(String?)? validator;

  PeopleSearchableDropdown({
    required Key key,
    required this.searchBarTitle,
    required this.searchBarController,
    required this.onSearchTextChanged,
    required this.newPerson,
    required this.onSelected,
    required this.selected,
    required this.searching,
    required this.withNew,
    required this.all,
    required this.onClear,
    this.validator,
    this.isRequired,
  }) : super(key: key);

  @override
  _PeopleSearchableDropdownState createState() =>
      _PeopleSearchableDropdownState();
}

class _PeopleSearchableDropdownState extends State<PeopleSearchableDropdown> {
  bool isSearching() => widget.searchBarController.text.isNotEmpty;
  bool isNew = false;
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
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: widget.isRequired != null
                        ? widget.isRequired!
                            ? redColor
                            : bgColor!
                        : bgColor!,
                    width: 1)),
            child: _buildSearchBar()),
        if (isSearching()) _buildResultsList(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return widget.selected.isEmpty
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextFormField(
                  cursorWidth: 3.0,
                  controller: widget.searchBarController,
                  keyboardType: TextInputType.text,
                  onChanged: widget.onSearchTextChanged,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 20, 10),
                    hintText: widget.searchBarTitle,
                    hintStyle: textHelper.hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: widget.validator,
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
        ? Container(
            height: MediaQuery.of(context).size.height / 8,
            alignment: Alignment.topCenter,
            child: TabLoader())
        : widget.all.isEmpty
            ? widget.withNew
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListTile(
                      onTap: () async {
                        widget.selected.add(SearchPeopleNew(
                            '', widget.searchBarController.text, [], []));
                        isNew = false;
                        widget.newPerson(isNew);
                        isNew = true;
                        widget.newPerson(isNew);
                        await widget.onSelected();
                        setState(() => widget.searchBarController.clear());
                      },
                      //contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      title: Text(widget.searchBarController.text),
                      trailing: Container(
                        height: 25,
                        width: 86,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(4.0)),
                        padding: EdgeInsets.all(4.0),
                        child: Center(
                            child: Text('Create New',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: white, fontSize: 13))),
                      ),
                    ),
                  )
                : Container(
                    height: 40,
                    alignment: Alignment.topCenter,
                    child: Center(child: Text('No people found!')),
                  )
            : Container(
                height: MediaQuery.of(context).size.height / 8,
                alignment: Alignment.topCenter,
                child: ListView.builder(
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
                          isNew = false;
                          widget.newPerson(isNew);
                          setState(() {});
                          await widget.onSelected();
                          setState(() => widget.searchBarController.clear());
                        },
                        title: Text(widget.all.elementAt(index).name ?? 'NA',
                            style: textHelper.defaultText),
                      ),
                    );
                  },
                ),
              );
  }

  Widget _buildFieldTags() {
    return Row(
      children: [
        Expanded(
            child: Text(
                widget.selected[0].name != ''
                    ? widget.selected[0].name ?? 'NA'
                    : 'NA',
                style: textHelper.defaultText,
                overflow: TextOverflow.ellipsis,
                softWrap: true)),
        isNew
            ? Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 25,
                  width: 50,
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(4.0)),
                  padding: EdgeInsets.all(4.0),
                  child: Center(
                      child: Text('New', style: TextStyle(color: white))),
                ),
              )
            : SizedBox(),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            child: const Icon(Icons.close, size: 20, color: black),
            onTap: widget.onClear,
          ),
        )
      ],
    );
  }
}
