import 'package:flutter/material.dart';
import 'package:salessimplify/constants/fieldinputtype.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/CustomSelectModel.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:provider/provider.dart';
import 'FormTextField.dart';

class SearchWidget extends StatefulWidget {
  static String ROUTE_SEARCH = "route/SearchWidget";
  FieldInputType? inputType;

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _controller = new TextEditingController();
  List<CustomSelectModel> _list = [];
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    widget.inputType =
        ModalRoute.of(context)!.settings.arguments as FieldInputType;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
              top: MediaQuery.of(context).padding.top,
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                FormTextField(
                  hintText: "Search Here",
                  iconColor: Colors.blue,
                  iconData: Icons.search,
                  controller: _controller,
                  onTextChange: onTextChange,
                ),
                Container(
                  padding: EdgeInsets.all(
                    12,
                  ),
                  child: IconButton(
                    color: Colors.blue,
                    icon: Icon(Icons.close),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: isProcessing
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (widget.inputType ==
                                  FieldInputType.PERSON_SELECT) {
                                context
                                    .read<Repository>()
                                    .setPerson(_list[index]);
                              } else {
                                context.read<Repository>().setOrg(_list[index]);
                              }
                              Navigator.of(context).pop();
                            },
                            child: Card(
                              child: ListTile(
                                leading: Container(
                                  padding: EdgeInsets.only(
                                    left: 14,
                                    right: 14,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: blueColor),
                                  ),
                                  child: Text(
                                    _list[index].name.characters.first,
                                  ),
                                ),
                                title: Text(
                                  _list[index].name,
                                ),
                              ),
                            ),
                          ),
                        ),
                        itemCount: _list.length,
                      )),
          )
        ],
      ),
    );
  }

  onTextChange(String value) async {
    setState(() {
      isProcessing = true;
    });
    if (value.isNotEmpty) {
      _list = await Repository.getInstance()
          .getSearchResult(widget.inputType, value);
    }
    setState(() {
      isProcessing = false;
    });
  }
}
