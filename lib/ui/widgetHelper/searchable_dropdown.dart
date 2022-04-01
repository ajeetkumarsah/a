import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/widgetHelper/tab_loader.dart';

class SearchableDropdown extends StatefulWidget {
  final TextEditingController searchBarController;
  final Function(String) onSearchTextChanged;
  final Function onSelected;
  final String searchBarTitle;
  final List<SearchCompanyNew> selected;
  final bool searching;
  final List<SearchCompanyNew> all;
  final bool? isRequired;

  String? Function(String?)? validator;
  SearchableDropdown({
    required Key key,
    required this.searchBarTitle,
    required this.searchBarController,
    required this.onSearchTextChanged,
    required this.onSelected,
    required this.selected,
    required this.searching,
    required this.all,
    this.validator,
    this.isRequired,
  }) : super(key: key);

  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
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
                  validator: widget.validator,
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
                      ),
                    ),
                  ),
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
        ? Container(
            height: MediaQuery.of(context).size.height / 8,
            alignment: Alignment.topCenter,
            child: TabLoader())
        : widget.all.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListTile(
                  onTap: () async {
                    final ProgressDialog pr = ProgressDialog(
                      context,
                      type: ProgressDialogType.Normal,
                      isDismissible: false,
                      showLogs: false,
                    );

                    await pr.show();
                    var id = await Repository.getInstance()
                        .createCompanyByName(widget.searchBarController.text);
                    widget.selected.add(SearchCompanyNew(
                        createdAddress: '',
                        createdAt: '',
                        email: [],
                        id: id,
                        name: widget.searchBarController.text,
                        owner: '',
                        phone: [],
                        website: ''));
                    await widget.onSelected();
                    isNew = true;
                    setState(() => widget.searchBarController.clear());
                    pr.hide().then((isHidden) {
                      print(isHidden);
                    });
                  },
                  //contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  title: Text(widget.searchBarController.text),
                  trailing: Container(
                    height: 25,
                    width: 86,
                    decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(4.0)),
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                        child: Text('Create New',
                            style: TextStyle(color: white, fontSize: 13))),
                  ),
                ),
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
                          setState(() {});
                          await widget.onSelected();
                          setState(() => widget.searchBarController.clear());
                        },
                        title: Text(widget.all.elementAt(index).name,
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
            child: Text(widget.selected[0].name,
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
