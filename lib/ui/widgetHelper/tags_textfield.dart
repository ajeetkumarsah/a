import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/Option.dart';
import 'package:salessimplify/models/popupdetails.dart';
import 'package:salessimplify/ui/landing/tabs/deal/DealsPage.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';
//**************this is the example of TaggedSearchField class how to use that class  */
// class MyTagsPage extends StatefulWidget {
//   @override
//   State<MyTagsPage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyTagsPage> {
// final TextEditingController _searchBarController = TextEditingController();
// List<Option> selectedStates = [];
// List<Option> filteredStates = [];
// List<Option> allTags = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: _buildBody());
//   }

//   Widget _buildBody() {
//     return Container(
//       margin: const EdgeInsets.only(top: 30),
// child: TaggedSearchField(
//     key: const ValueKey('key'),
//     searchBarTitle: 'Search States',
//     searchBarController: _searchBarController,
//     onSearchTextChanged: onSearchTextChanged,
//     onSelected: onSelected,
//     selected: selectedStates,
//     filtered: filteredStates,
//     all: allTags),
//     );
//   }

//   void onSearchTextChanged(String text) {
//     filteredStates.clear();
//     setState(() {
//       if (text.isEmpty) {
//         return;
//       }
//       for (Option _state in allTags) {
//         if (_state.label
//             .replaceAll(RegExp(r'[^\w\s]+'), '')
//             .toLowerCase()
//             .contains(text)) filteredStates.add(_state);
//       }
//     });
//   }

//   void onSelected() {
//     // print(selectedStates[4].name);
//     print('New tag has been selected.');
//   }
// }

class TaggedSearchField extends StatefulWidget {
  final TextEditingController searchBarController;
  final Function(String) onSearchTextChanged;
  final Function onSelected;
  final String searchBarTitle;
  final List<Option> selected, filtered, all;

  const TaggedSearchField({
    required Key key,
    required this.searchBarTitle,
    required this.searchBarController,
    required this.onSearchTextChanged,
    required this.onSelected,
    required this.selected,
    required this.filtered,
    required this.all,
  }) : super(key: key);

  @override
  _TaggedSearchFieldState createState() => _TaggedSearchFieldState();
}

class _TaggedSearchFieldState extends State<TaggedSearchField> {
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
            height: 45,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4)),
            child: _buildSearchBar()),
        // if (isSearching())
        if (widget.all.isNotEmpty)
          Container(
              height: MediaQuery.of(context).size.height / 8,
              alignment: Alignment.topCenter,
              child: _buildResultsList()),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
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
        //Tags will be built based on the items of selected list.
        if (widget.selected.isNotEmpty)
          SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: _buildFieldTags()),
        if (widget.searchBarController.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: () => widget.searchBarController.clear(),
                child: Icon(Icons.close, color: Colors.grey[500], size: 25)),
          )
      ],
    );
  }

  Widget _buildResultsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount:
          widget.filtered.isEmpty ? widget.all.length : widget.filtered.length,
      itemBuilder: (context, int index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              border: const Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.2))),
          child: ListTile(
            onTap: () async {
              //Widget automatically adds to selected list what you tap on.

              if (widget.filtered.isNotEmpty) {
                var contain = widget.selected.where((option) =>
                    option.value == widget.filtered.elementAt(index).value);
                if (contain.isEmpty) {
                  //value not exists
                  widget.selected.add(widget.filtered.elementAt(index));

                  setState(() {});
                } else {
                  toastHelper.toastWithTitleAndColor(
                      "Already selected", yellowColor);
                  setState(() {});
                }

                await widget.onSelected();
              } else {
                var contain = widget.selected.where((option) =>
                    option.value == widget.all.elementAt(index).value);
                if (contain.isEmpty) {
                  //value not exists
                  widget.selected.add(widget.all.elementAt(index));

                  setState(() {});
                } else {
                  toastHelper.toastWithTitleAndColor(
                      "Already selected", yellowColor);
                  setState(() {});
                }

                await widget.onSelected();
              }

              setState(() => widget.searchBarController.clear());
            },
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                        color: widget.filtered.isEmpty
                            ? HexColor.fromHex(
                                widget.all.elementAt(index).colorCode)
                            : HexColor.fromHex(
                                widget.filtered.elementAt(index).colorCode),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                        widget.filtered.isEmpty
                            ? widget.all.elementAt(index).label
                            : widget.filtered.elementAt(index).label,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15.0, color: white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldTags() {
    const TextStyle textStyle = TextStyle(color: Colors.white);
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        ...widget.selected.map(
          (tag) {
            final Size size = (TextPainter(
                    text: TextSpan(text: tag.label, style: textStyle),
                    maxLines: 1,
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    textDirection: TextDirection.ltr)
                  ..layout())
                .size;

            return Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  width: size.width + 55,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                      color: HexColor.fromHex(tag.colorCode),
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(tag.label,
                              style: textStyle,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: const Icon(Icons.close,
                              size: 20, color: Colors.white),
                          onTap: () {
                            final foundItem = widget.selected
                                .where((element) => element.label == tag.label)
                                .first;
                            setState(() {
                              widget.selected.remove(foundItem);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
