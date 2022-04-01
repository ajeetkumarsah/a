import 'package:flutter/material.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/widget/FormTextField.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';

class SearchDeals extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  List<SearchResult> result = [];
  static String ROUTE_SEARCH_DEAL_ACTIVITY = "route/SearchDeals";

  @override
  Widget build(BuildContext context) {
    result = context.watch<Repository>().searchResult;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Search Deals",
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                FormTextField(
                  hintText: "Search Here",
                  iconColor: Colors.blue,
                  iconData: Icons.search,
                  controller: _controller,
                  onTextChange: (String value) {
                    context.read<Repository>().getDealSearch(_controller.text);
                  },
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
            child: ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  context.read<Repository>().setSearchResult(result[index]);
                  Navigator.of(context).pop();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 16,
                        bottom: 4,
                      ),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white38,
                      ),
                      child: Text(
                        result[index].title,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
